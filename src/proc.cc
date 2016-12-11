#include <fstream>

#include <stdint.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"
#include "fetcher.h"
#include "scribe.h"

#include "vixl/a64/decoder-a64.h"
#include "vixl/a64/logic-a64.h"

namespace Kraken
{


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
    Word* absTextStart =
        state_->memAt<Word>(progInfo_.textStart_);
    Word* absTextEnd =
        state_->memAt<Word>(progInfo_.textEnd_);
    state_->pc_ = state_->memAt<Word>(progInfo_.entry_);

    //initialise components
    vixl::Decoder decoder;
    Fetcher fetcher(state_);
    vixl::Logic logic;
    logic.set_trace_parameters(vixl::LOG_ALL);

    msg("Absolute .text scope:  %p - %p\n",
        absTextStart, absTextEnd);
    msg("Absolute memory scope: %p - %p\n",
        state_->baseAddr_,
        addPointers<Word*>(state_->baseAddr_, (void*) progInfo_.imgSize_));
    while (state_->pc_ < absTextEnd)
    {
        bool shouldBreak = options_.interactive;
        const ptrdiff_t pcOffset = state_->getPcOffset();

        // check whether to break
        for (uintptr_t bAddr : options_.bpoints)
            if (shouldBreak |= (bAddr == pcOffset))
                break;

        if (shouldBreak)
            breakpoint(pcOffset);

        const vixl::Instruction * instr = fetcher.fetch();
        ActionCode ac = decoder.Decode(instr);
        logic.set_pc(reinterpret_cast<const vixl::Instruction*>(state_->pc_));
        logic.Execute(ac, instr);
        state_->pc_ = reinterpret_cast<const Word*>(logic.get_pc());
        // Scribe::write(script, state);

        if (state_->pc_ == 0)
        {
            msg("Program has returned\n");
            break;
        }
    }

    logic.PrintRegisters();
    logic.PrintVRegisters();
    logic.PrintSystemRegisters();
}

void Proc::breakpoint(const ptrdiff_t pcOffset)
{
    msg("Breakpoint: %p\n", pcOffset);

    // print reg vals
    wrn("TODO: brekapoint()\n");

    getchar();
}

} // namespace Kraken