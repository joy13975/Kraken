#include <fstream>

#include <stdint.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"

namespace Kraken
{

static Proc * currentProc;

#define FOREACH_PROCSTAGE(MACRO) \
    MACRO(FETCH,        0B00001) \
    MACRO(DECODE,       0B00010) \
    MACRO(EXECUTE,      0B00100) \
    MACRO(WRITEBACK,    0B01000) \
    MACRO(_NSTAGES_,    4) \
    MACRO(PIPELINED,    0xffffffff)

GEN_ENUM_VAL_AND_STRING(ProcStage, ProcStageString, FOREACH_PROCSTAGE);
ProcStage nextStage(const ProcStage &s)
{
    if (s == FETCH) return DECODE;
    if (s == DECODE) return EXECUTE;
    if (s == EXECUTE) return WRITEBACK;
    if (s == WRITEBACK) return FETCH;
    if (s == PIPELINED) return PIPELINED;
    die("Impossible stage: %s\n", ProcStageString(s));
}

#define FOREACH_CLKSTATE(MACRO)\
    MACRO(HIGH) \
    MACRO(FALLING) \
    MACRO(LOW) \
    MACRO(RISING) \
    MACRO(_NCLKSTATES_)

GEN_ENUM_AND_STRING(ClkState, ClkStateString, FOREACH_CLKSTATE);

void signalHandler(int sig)
{
    err("Signal caught - %s\n", strsignal(sig));

    if (currentProc)
    {
        currentProc->printMemInfo();
        currentProc->dumpData();
        currentProc->dumpStack();
    }
    else
    {
        die("currentProc is null\n");
    }

    exit(sig == SIGINT ? 0 : 1);
}

Proc::Proc(const Options &_options)
    : options(_options),
      progInfo(ProgramInfo(std::ifstream(options.input, std::ios::binary))),
      absTextStart(progInfo.offset<InstrPtr >(progInfo.textStart)),
      absTextEnd(progInfo.offset<InstrPtr >(progInfo.textEnd)),
      branchRecords(_options.bpMode, _options.nBPBits, absTextEnd),
      fetcher(state.pc, branchRecords, _options.pipelined, absTextEnd),
      decoder(robHead),
      logic(robHead,
            branchRecords,
            _options.pipelined,
            _options.simExecLatency,
            _options.nSuperscalar),
      scribe(robHead, state)
{
    currentProc = this;
    signal(SIGINT, signalHandler);
    signal(SIGSEGV, signalHandler);

    connect(this, (ComponentBase*) &fetcher);
    connect(this, (ComponentBase*) &decoder);
    connect(this, (ComponentBase*) &logic);
}

void Proc::computeComponent()
{
    if (options.interactive)
        msg("Interactive mode is enabled\n");
    if (options.pipelined)
        msg("Pipelining is enabled\n");

    softReset();
    init();
    run();

    dumpData();
    dumpStack();
}
void Proc::softResetComponent()
{
    fetcher.hardReset();
    decoder.hardReset();
    logic.hardReset();
    scribe.hardReset();

    branchRecords.clearRecords();

    if (get_log_level() < LOG_MESSAGE)
        logic.set_trace_parameters(vixl::LOG_ALL);

    state.pc = 0;

    breakSubsequent = false;
}

void Proc::init()
{
    if (!hasReset)
        die("Must call softReset() before init()\n");

    hasReset = false;

    // hook up components
    fetcher.setDecoder(&decoder);
    fetcher.setLogic(&logic);
    decoder.setFetcher(&fetcher);
    decoder.addExUnit(&logic);
    logic.setFetcher(&fetcher);
    logic.setDecoder(&decoder);
    //logic.addSlave ...

    // initialise reg values
    state.pc = progInfo.offset<InstrPtr >(progInfo.entry);
}

void Proc::run()
{
    msg("PC at entry (main): %p (global: %p)\n",
        progInfo.offset<ptrdiff_t>(state.pc), state.pc);
    printMemInfo();

    bool shouldHalt = false;

    // statistics
    long cycleCount = 0;

    // execution loop
    ProcStage stage = options.pipelined ? PIPELINED : FETCH;
    ClkState clkState = HIGH;

    #pragma omp parallel
    {
        while (!shouldHalt)
        {
            #pragma omp barrier

            #pragma omp single nowait
            {
                const ptrdiff_t pcOffset = progInfo.fromBase<ptrdiff_t>(state.pc);
                if (clkState == HIGH)
                    checkBreakpoint(pcOffset);

                prf("Clk: %s, Stage: %s\n",
                ClkStateString[clkState], ProcStageString(stage));
                switch (clkState)
                {
                case HIGH:
                {
                    dbg("======================================== Compute[%d/%d]\n",
                    cycleCount, logic.getInstrCount());
                    dbg("PC Offsest: %p\n", pcOffset);
                    prf("Clock HIGH: %s\n", ProcStageString(stage));

                    #pragma omp task
                    if (stage & FETCH) fetcher.compute();

                    #pragma omp task
                    if (stage & DECODE) decoder.compute();

                    #pragma omp task
                    if (stage & EXECUTE) logic.compute();

                    #pragma omp task
                    if (stage & WRITEBACK) scribe.compute();

                    break;
                }
                case FALLING:
                {
                    break;
                }
                case LOW:
                {
                    dbg("======================================== Update[%d/%d] \n",
                        cycleCount, logic.getInstrCount());

                    #pragma omp task
                    if (stage & FETCH) fetcher.update();

                    #pragma omp task
                    if (stage & DECODE) decoder.update();

                    #pragma omp task
                    if (stage & EXECUTE) logic.update();

                    #pragma omp task
                    if (stage & WRITEBACK) scribe.update();

                    break;
                }
                case RISING:
                {
                    dbg("======================================== Sync [%d/%d] \n",
                        cycleCount, logic.getInstrCount());

                    #pragma omp task
                    if (stage & FETCH) fetcher.sync();

                    #pragma omp task
                    if (stage & DECODE) decoder.sync();

                    #pragma omp task
                    if (stage & EXECUTE) logic.sync();

                    #pragma omp task
                    if (stage & WRITEBACK) scribe.sync();

                    break;
                }
                default:
                    die("Unused clock state: %s\n", ClkStateString[clkState]);
                }

                #pragma omp taskwait

                // below code MUST run AFTER task sync
                if (clkState == RISING)
                {
                    stage = nextStage(stage);
                    cycleCount++;
                    dbg("======================================== Cycle End\n");
                }

                if (state.pc == 0)
                {
                    shouldHalt = true;
                    dbg("======================================== Proc Halts\n");
                }
                else if (state.pc < absTextStart || state.pc > absTextEnd)
                {
                    err("Invalid state.PC: [%d, %d]\n",
                        state.pc < absTextStart, state.pc > absTextStart);
                    die("PC: %p is not inside [%p, %p]\n",
                        state.pc, absTextStart, absTextEnd);
                }

                clkState = static_cast<ClkState>((clkState + 1) % _NCLKSTATES_);
            } // omp single

            #pragma omp barrier
        } // while(!shouldHalt)
    }

    logic.PrintRegister(0);
    // logic.PrintVRegisters();
    // logic.PrintSystemRegisters();

    msg("Return code as long:  %ld\n", logic.getRegisters()[0].Get<uint64_t>());

    msg("%ld instructions in %ld cycles; I/C = %.2f\n",
        logic.getInstrCount(), cycleCount, (float) logic.getInstrCount() / cycleCount);

    const unsigned long bpTotal = logic.getBpCorrect() + logic.getBpWrong();
    const float bpAccuracy = (float) 100.0f * logic.getBpCorrect() / bpTotal;
    msg("Branch Prediction Accuracy: %.2f%% (%ld/%ld)\n",
        bpAccuracy, logic.getBpCorrect(), bpTotal);
}

void Proc::checkBreakpoint(const ptrdiff_t pcOffset)
{
    if (!breakSubsequent)
        for (const uintptr_t & bAddr : options.bpoints)
            if (breakSubsequent = (bAddr == pcOffset))
                break;

    if (!breakSubsequent && !options.interactive)
        return;

    msg("Breakpoint: %p\n", pcOffset);

    getchar();
}

void Proc::dumpData()
{
    size_t bytesToWrite = sizeof(Word) * (progInfo.dataEnd - progInfo.dataStart);
    const char * absDataStart = addPointers<char*>(progInfo.image, progInfo.dataStart);
    write_binary(options.dataOutput.c_str(), absDataStart, bytesToWrite);
}

void Proc::dumpStack()
{
    write_binary(options.stackOutput.c_str(), (char*) logic.getStackBegin(), logic.getStackSize());
}

void Proc::printMemInfo()
{
    msg(".text scope:  %p - %p\n",
        absTextStart, absTextEnd);
    msg("Memory scope: %p - %p\n",
        progInfo.image,
        progInfo.offset<void*>((void*) progInfo.imgSize));
    msg("Stack scope:  %p - %p\n",
        logic.getStackBegin(),
        addPointers<void*>(logic.getStackBegin(),
                           (void*) logic.getStackSize()));
}

} // namespace Kraken