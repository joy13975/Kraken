#include <fstream>

#include <stdint.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"

namespace Kraken
{

#define FOREACH_PROCSTAGE(MACRO)\
    MACRO(FETCH) \
    MACRO(DECODE) \
    MACRO(EXECUTE) \
    MACRO(WRITEBACK) \
    MACRO(_NSTAGES_)

DECL_ENUM_AND_STRING(ProcStage, ProcStageString, FOREACH_PROCSTAGE);

Proc::Proc(const Options &options)
    : options_(options),
      progInfo_(ProgramInfo(std::ifstream(options_.inputFile, std::ios::binary)))
{
}

void Proc::startSimulation()
{
    // intialise processor state
    state_ = new State(progInfo_);
    resetStateRegs();

    // wrn("Ignoring main entry to test instruction decoding\n");
    // state_->pc_ = (Word*) addPointers(state_->baseAddr_, progInfo_.textStart_);
    msg("Main is at %p (global: %p)\n",
        state_->getPcOffset(), state_->pc_);

    run();
}

// Private functions

void Proc::resetStateRegs()
{
    // do not use progInfo_.binary_, it does not represent
    // the memory space
    state_->pc_ = state_->memAt<Word>(progInfo_.entry_);
}

void Proc::run()
{
    // memory housekeeping
    Word* absTextStart =
        state_->memAt<Word>(progInfo_.textStart_);
    Word* absTextEnd =
        state_->memAt<Word>(progInfo_.textEnd_);
    state_->pc_ = state_->memAt<Word>(progInfo_.entry_);

    msg("Absolute .text scope:  %p - %p\n",
        absTextStart, absTextEnd);
    msg("Absolute memory scope: %p - %p\n",
        state_->baseAddr_,
        addPointers<Word*>(state_->baseAddr_, (void*) progInfo_.imgSize_));

    //initialise components
    fetcher_.Reset();
    decoder_.Reset();
    logic_.Reset();
    // logic_.set_trace_parameters(vixl::LOG_ALL);
    //scribe_Reset();

    // data paths
    const vixl::Instruction * instr;
    ActionCode ac;

    // statistics
    long cycleCount = 0, instrCount = 0;

    // execution loop
    while (state_->pc_ < absTextEnd)
    {
        //check for breakpoint
        {
            bool shouldBreak = options_.interactive;
            const ptrdiff_t pcOffset = state_->getPcOffset();

            // check whether to break
            for (uintptr_t bAddr : options_.bpoints)
                if (shouldBreak |= (bAddr == pcOffset))
                    break;

            if (shouldBreak)
                breakpoint(pcOffset);
        }

#define PIPELINE_LOCK() if (!options_.pipelined) break
        for (int stage = 0; stage < _NSTAGES_; stage++)
        {
            switch (stage)
            {
            case FETCH:
                instr = fetcher_.Fetch(&(state_->pc_));
                instrCount += 1; // change with superscalar
                logic_.set_pc(reinterpret_cast<const vixl::Instruction*>(state_->pc_));
                PIPELINE_LOCK();
            case DECODE:
                dbg("Dest Reg: %d\n", instr->Rd());
                ac = decoder_.Decode(instr);
                PIPELINE_LOCK();
            case EXECUTE:
                logic_.Execute(ac, instr);
                PIPELINE_LOCK();
            case WRITEBACK:
                state_->pc_ = reinterpret_cast<const Word*>(logic_.get_pc());
                // Scribe::write(script, state);
                PIPELINE_LOCK();
            default:
                die("Unknown stage: %s\n", ProcStageString[stage]);
            }

            // pipelined execution takes 1 "stage" time in total
            cycleCount++;
            if (options_.pipelined)
                break;
        }
#undef PIPELINE_LOCK

        if (state_->pc_ == 0)
        {
            msg("Program has returned\n");
            break;
        }
    }

    logic_.PrintRegister(0);
    // logic_.PrintVRegisters();
    // logic_.PrintSystemRegisters();

    msg("%ld instructions in %ld cycles --> %.2f\n",
        instrCount, cycleCount, (float) instrCount / cycleCount);
}

void Proc::breakpoint(const ptrdiff_t pcOffset)
{
    msg("Breakpoint: %p\n", pcOffset);

    // print reg vals
    wrn("TODO: brekapoint()\n");

    getchar();
}

} // namespace Kraken