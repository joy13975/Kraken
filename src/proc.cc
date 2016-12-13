#include <fstream>

#include <stdint.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"

namespace Kraken
{

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

Proc::Proc(const Options &options)
    : options_(options),
      progInfo_(ProgramInfo(std::ifstream(options_.input, std::ios::binary)))
{
}

void Proc::reset()
{
    fetcher_.reset();
    decoder_.reset();
    logic_.reset();

    if (get_log_level() < LOG_MESSAGE)
        logic_.set_trace_parameters(vixl::LOG_ALL);
    //scribe_.Reset();
}

void Proc::update()
{

}

void Proc::startSimulation()
{
    reset();

    if (options_.interactive)
        msg("Interactive mode is enabled\n");
    if (options_.pipelined)
        msg("Pipelining is enabled\n");

    run();

    dumpData();
    dumpStack();
}

// Private functions

void Proc::run()
{
    // memory housekeeping
    pc_ = addPointers<Word*>(progInfo_.image_, progInfo_.entry_);
    const Word * absTextStart =
        addPointers<Word*>(progInfo_.image_, progInfo_.textStart_);
    const Word * absTextEnd =
        addPointers<Word*>(progInfo_.image_, progInfo_.textEnd_);

    msg("Main is at %p (global: %p)\n",
        progInfo_.offset<ptrdiff_t>(pc_), pc_);
    msg("Absolute .text scope:  %p - %p\n",
        absTextStart, absTextEnd);
    msg("Absolute memory scope: %p - %p\n",
        progInfo_.image_,
        addPointers<Word*>(progInfo_.image_, (void*) progInfo_.imgSize_));

    bool shouldHalt = false;

    // data paths
    vixl::SimRegister       dpRegs[vixl::kNumberOfRegisters];
    vixl::SimVRegister      dpVregs[vixl::kNumberOfVRegisters];
    vixl::SimSystemRegister dpNZCV;
    vixl::SimSystemRegister dpFPCR;

    // statistics
    long cycleCount = 0, instrCount = 0;

    // execution loop
    ProcStage stage = options_.pipelined ? PIPELINED : FETCH;
    ClkState clkState = HIGH;

    #pragma omp parallel
    {
        while (!shouldHalt)
        {
            #pragma omp barrier

            #pragma omp single nowait
            {
                //check for breakpoint
                const ptrdiff_t pcOffset = progInfo_.offset<ptrdiff_t>(pc_);
                if (clkState == HIGH)
                {
                    if (options_.interactive)
                        breakpoint(pcOffset);
                    else
                        // check whether to break
                        for (uintptr_t bAddr : options_.bpoints)
                            if (bAddr == pcOffset)
                            { breakpoint(pcOffset); break; };
                }

                prf("Clk: %s, Stage: %s\n",
                    ClkStateString[clkState], ProcStageString(stage));

                switch (clkState)
                {
                case HIGH:
                {
                    dbg("======================================== Compute[%d/%d]\n",
                        cycleCount, instrCount);
                    dbg("PC Offsest: %p\n", pcOffset);
                    prf("Clock HIGH: %s\n", ProcStageString(stage));

                    #pragma omp task
                    if (stage & FETCH)
                    {
                        if (pc_ >= absTextEnd)
                            dbg("   Fetcher has halted\n");
                        else
                            fetcher_.Fetch(pc_, options_.n_superscalar);
                    }

                    #pragma omp task
                    if (stage & DECODE)
                    {
                        decoder_.Decode(fetcher_.cachedInstr(), fetcher_.cachedPc());
                    }

                    #pragma omp task
                    if (stage & EXECUTE)
                    {
                        logic_.Execute(decoder_.cachedPc(),
                                       decoder_.cachedAction(),
                                       decoder_.cachedInstr());

                        // memcpy(dpRegs, logic_.getRegisters(),
                        //        sizeof(vixl::SimRegister) * vixl::kNumberOfRegisters);
                        // memcpy(dpRegs, logic_.getVRegisters(),
                        //        sizeof(vixl::SimRegister) * vixl::kNumberOfVRegisters);
                        // memcpy(&dpNZCV, logic_.getNZCV(),
                        //        sizeof(vixl::SimRegister));
                        // memcpy(&dpFPCR, logic_.getFPCR(),
                        //        sizeof(vixl::SimRegister));
                    }

                    #pragma omp task
                    if (stage & WRITEBACK)
                    {
                        // commit modified reg vals
                        // Scribe::commit(script, state);
                    }

                    break;
                }
                case FALLING:
                {
                    break;
                }
                case LOW:
                {
                    dbg("======================================== Update[%d/%d] \n",
                        cycleCount, instrCount);

                    #pragma omp task
                    if (stage & FETCH)
                    {
                        fetcher_.update();
                        pc_ = reinterpret_cast<const Word*>(fetcher_.cachedPc());
                    }

                    #pragma omp task
                    if (stage & DECODE)
                        decoder_.update();

                    #pragma omp task
                    if (stage & EXECUTE)
                        logic_.update();

                    #pragma omp task
                    if (stage & WRITEBACK)
                    {
                        // gather only MODIFIED register values
                        // dbg("   WRITEBACK COPIED: ??\n");
                    }

                    break;
                }
                case RISING:
                {
                    dbg("======================================== Sync [%d/%d] \n",
                        cycleCount, instrCount);

                    #pragma omp task
                    if (stage & FETCH)
                    {
                    }

                    #pragma omp task
                    if (stage & DECODE)
                    {
                        if (logic_.cachedHasExecuted())
                            instrCount += options_.n_superscalar;
                    }

                    #pragma omp task
                    if (stage & EXECUTE)
                    {
                        fflush(stdout);
                        if (logic_.pcIsDirty())
                        {
                            fetcher_.reset();
                            decoder_.reset();

                            pc_ = reinterpret_cast<const Word*>(logic_.cachedExePc());
                            dbg("   Execute pc_ <- cachedExePc_: %p\n", logic_.cachedExePc());
                        }
                    }

                    #pragma omp task
                    if (stage & WRITEBACK)
                    {
                    }

                    break;
                }
                default:
                    die("Unused clock state: %s\n", ClkStateString[clkState]);
                }

                #pragma omp taskwait

                // below code must run only after task sync
                if (clkState == RISING)
                {
                    stage = nextStage(stage);
                    cycleCount++;
                    dbg("======================================== Cycle End\n");
                }

                if (pc_ == 0)
                {
                    shouldHalt = true;
                    dbg("======================================== Proc Halts\n");
                }
                else if (pc_ < absTextStart || pc_ > absTextEnd)
                {
                    err("PC went out of bound!\n");
                    die("PC: %p is not inside [%p, %p]\n",
                        pc_, absTextStart, absTextEnd);
                }

                clkState = static_cast<ClkState>((clkState + 1) % _NCLKSTATES_);
            } // omp single

            #pragma omp barrier
        } // while(!shouldHalt)
    }

    logic_.PrintRegister(0);
    // logic_.PrintVRegisters();
    // logic_.PrintSystemRegisters();

    msg("%ld instructions in %ld cycles; I/C = %.2f\n",
        instrCount, cycleCount, (float) instrCount / cycleCount);
}

void Proc::breakpoint(const ptrdiff_t pcOffset)
{
    msg("Breakpoint: %p\n", pcOffset);

    // print reg vals
    wrn("TODO: brekapoint()\n");

    getchar();
}

void Proc::dumpData()
{
    size_t bytesToWrite = sizeof(Word) * (progInfo_.dataEnd_ - progInfo_.dataStart_);
    const char * absDataStart = addPointers<char*>(progInfo_.image_, progInfo_.dataStart_);
    write_binary(options_.dataOutput.c_str(), absDataStart, bytesToWrite);
}

void Proc::dumpStack()
{
    write_binary(options_.stackOutput.c_str(), (char*) logic_.stackBegin(), logic_.stackSize());
}

} // namespace Kraken