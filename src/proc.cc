#include <fstream>
#include <iostream>

#include <stdint.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"
#include "decoder.h"
#include "fetcher.h"
#include "enactor.h"
#include "scribe.h"

using namespace std;

KrakenProc::KrakenProc(const KrakenOptions &_options)
    : options(_options)
{
}

void KrakenProc::startSimulation()
{
    // intialise processor state
    ifstream binStream(options.inputFile, ios::binary);
    state = new KrakenState(binStream);
    binStream.close();

    resetStateRegs();

    // wrn("Ignoring main entry to test instruction decoding\n");
    // state->pc = (Word*) addPointers(state->memory, state->progInfo.textStart);
    msg("Entering binary at %p (real: %p)\n",
        subPointers(state->pc, state->memory), state->pc);

    run();

    msg("Program has exited\n");
    wrn("Todo: stats and reg status (ret code?)\n");
}

// Private functions

void KrakenProc::resetStateRegs()
{
    state->pc = state->progInfo.entry;
}

bool KrakenProc::isPCSensible()
{
    // add 2 to compensate the starting odd address
    const Word* pcOffset = (Word*) state->getPcOffset();
    const bool sensible = pcOffset <= state->progInfo.textEnd &&
                          pcOffset >= state->progInfo.textStart;

    if (!sensible)
        wrn("PC became weird: %p (%p ~ %p)\n",
            pcOffset, state->progInfo.textStart, state->progInfo.textEnd);
    return sensible;
}

void KrakenProc::run()
{
    while (isPCSensible())
    {
        // check whether to break
        for (uintptr_t bAddr : options.bpoints)
            if (bAddr == state->getPcOffset())
            { breakpoint(bAddr); break; }

        const KrakenInstr instr = Fetcher::fetch(state);
        KrakenAction action     = Decoder::decode(instr);
        KrakenScripture script  = Enactor::enact(action, state);
        Scribe::write(script, state);

        if (options.interactive)
            getchar();
    }
}

void KrakenProc::breakpoint(const uintptr_t addr)
{
    msg("Breakpoint: %p\n", addr);

    // print reg vals
    wrn("TODO: brekapoint()\n");

    getchar();
}