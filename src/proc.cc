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

void Proc::reset()
{
    fetcher.reset();
    decoder.reset();
    logic.reset();

    if (get_log_level() < LOG_MESSAGE)
        logic.set_trace_parameters(vixl::LOG_ALL);
    //scribe_.Reset();
}

void Proc::update()
{

}

void Proc::startSimulation()
{
    reset();

    if (options.interactive)
        msg("Interactive mode is enabled\n");
    if (options.pipelined)
        msg("Pipelining is enabled\n");

    run();

    dumpData();
    dumpStack();
}

// Private functions

void Proc::run()
{
    msg("PC at entry (main): %p (global: %p)\n",
        progInfo.offset<ptrdiff_t>(pc), pc);
    msg("Absolute .text scope:  %p - %p\n",
        absTextStart, absTextEnd);
    msg("Absolute memory scope: %p - %p\n",
        progInfo.image,
        progInfo.offset<void*>((void*) progInfo.imgSize));

    bool shouldHalt = false;

    // statistics
    long cycleCount = 0, instrCount = 0, bpCorrectCount = 0, bpWrongCount = 0;

    // execution loop
    ProcStage stage = options.pipelined ? PIPELINED : FETCH;
    ClkState clkState = HIGH;

    // debugging
    bool breakSubsequent = false;

    #pragma omp parallel
    {
        while (!shouldHalt)
        {
            #pragma omp barrier

            #pragma omp single nowait
            {
                //check for breakpoint
                const ptrdiff_t pcOffset = progInfo.fromBase<ptrdiff_t>(pc);
                if (clkState == HIGH)
                {
                    if (options.interactive || breakSubsequent)
                        breakpoint(pcOffset);
                    else
                        // check whether to break
                        for (uintptr_t bAddr : options.bpoints)
                            if (breakSubsequent = (bAddr == pcOffset))
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
                        if (pc < absTextEnd)
                            fetcher.Fetch(pc);
                        else
                            dbg("   Fetcher has halted\n");
                    }

                    #pragma omp task
                    if (stage & DECODE)
                    {
                        decoder.Decode(fetcher.getInstr());
                    }

                    #pragma omp task
                    if (stage & EXECUTE)
                    {
                        logic.Execute(decoder.getAction(),
                                      decoder.getInstr());

                        // memcpy(dpRegs, logic.getRegisters(),
                        //        sizeof(vixl::SimRegister) * vixl::kNumberOfRegisters);
                        // memcpy(dpRegs, logic.getVRegisters(),
                        //        sizeof(vixl::SimRegister) * vixl::kNumberOfVRegisters);
                        // memcpy(&dpNZCV, logic.getNZCV(),
                        //        sizeof(vixl::SimRegister));
                        // memcpy(&dpFPCR, logic.getFPCR(),
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
                        if (pc < absTextEnd)
                        {
                            fetcher.update();

                            // check branch prediction
                            const InstrPtr bpSuggest =
                                branchRecords.predict(pc);
                            wrn("Suggest: %p, pc: %p\n",
                                progInfo.offset<InstrPtr>(bpSuggest),
                                progInfo.offset<InstrPtr>(pc));

                            pc = bpSuggest;
                        }

                    }

                    #pragma omp task
                    if (stage & DECODE)
                        decoder.update();

                    #pragma omp task
                    if (stage & EXECUTE)
                        logic.update();

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
                        if (logic.getHasExecuted())
                            instrCount++;
                    }

                    #pragma omp task
                    if (stage & EXECUTE)
                    {
                        InstrPtr newPc = logic.getNewPc();
                        const InstrPtr exeInstr = logic.getExeInstr();
                        const bool wasBrInstr =
                            exeInstr && vixl::Decoder::isBranch(exeInstr);

                        if (wasBrInstr)
                        {
                            branchRecords.updateRecord(exeInstr,
                                                       newPc);
                            if (decoder.getInstr() == newPc)
                            {
                                bpCorrectCount++;
                                dbg("   Branch prediction was correct: %d\n",
                                    bpCorrectCount);
                            }
                            else
                            {
                                bpWrongCount++;
                                fetcher.reset();
                                decoder.reset();
                                logic.resetFlags();

                                pc = newPc;
                                dbg("   Branch prediction was wrong: %d; pc <- newPc: %p\n",
                                    bpWrongCount, newPc);
                            }
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

                // below code MUST run AFTER task sync
                if (clkState == RISING)
                {
                    stage = nextStage(stage);
                    cycleCount++;
                    dbg("======================================== Cycle End\n");
                }

                if (pc == 0)
                {
                    shouldHalt = true;
                    dbg("======================================== Proc Halts\n");
                }
                else if (pc < absTextStart || pc > absTextEnd)
                {
                    err("Invalid PC: [%d, %d]\n",
                        pc < absTextStart, pc > absTextStart);
                    die("PC: %p is not inside [%p, %p]\n",
                        pc, absTextStart, absTextEnd);
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
        instrCount, cycleCount, (float) instrCount / cycleCount);

    float bpAccuracy = (float) 100.0f * bpCorrectCount / (bpCorrectCount + bpWrongCount);
    msg("Branch Prediction: %d correct %d wrong; ACC = %.2f%%\n",
        bpCorrectCount, bpWrongCount, bpAccuracy);
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
    size_t bytesToWrite = sizeof(Word) * (progInfo.dataEnd - progInfo.dataStart);
    const char * absDataStart = addPointers<char*>(progInfo.image, progInfo.dataStart);
    write_binary(options.dataOutput.c_str(), absDataStart, bytesToWrite);
}

void Proc::dumpStack()
{
    write_binary(options.stackOutput.c_str(), (char*) logic.stackBegin(), logic.stackSize());
}

} // namespace Kraken