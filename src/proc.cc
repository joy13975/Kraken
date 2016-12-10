#include <fstream>

#include <stdint.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"
#include "decoder.h"
#include "fetcher.h"
#include "enactor.h"
#include "scribe.h"

#include "vixl/a64/decoder-a64.h"

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

    msg("Program has exited\n");
    wrn("TODO: stats and reg status (ret code?)\n");
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
    Word *const absStart = state_->memAt<Word>(progInfo_.textStart_);
    Word *const absEnd = state_->memAt<Word>(progInfo_.textEnd_);
    state_->pc_ = absStart;

    //initialise components
    vixl::Decoder vixlDecoder;
    Fetcher fetcher(state_->pc_);

    msg("Absolute .text addresses: %p to %p\n",
        absStart, absEnd);
    while (state_->pc_ < absEnd)
    {
        bool shouldBreak = options_.interactive;
        const ptrdiff_t pcOffset = state_->getPcOffset();

        // check whether to break
        for (uintptr_t bAddr : options_.bpoints)
            if (shouldBreak |= (bAddr == pcOffset))
                break;

        if (shouldBreak)
            breakpoint(pcOffset);

        const vixl::Instruction *instr = fetcher.fetch();
        ActionCode ac = vixlDecoder.Decode(instr);
        msg("Got: %s\n", ActionCodeString[ac]);
        // Scripture script  = Enactor::enact(action, state);
        // Scribe::write(script, state);

    }
}

void Proc::breakpoint(const ptrdiff_t pcOffset)
{
    msg("Breakpoint: %p\n", pcOffset);

    // print reg vals
    wrn("TODO: brekapoint()\n");

    getchar();
}

} // namespace Kraken