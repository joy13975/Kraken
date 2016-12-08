#include "fetcher.h"
#include "decoder.h"

namespace Fetcher
{

const Instr fetch(KrakenProc::State *const state)
{
    const bool is32bits = Decoder::is32bitInstr(UpperByte(*(state->pc)));
    dbg("Fetching at pc: %p, %d-bit\n", state->getPCOffset(), is32bits ? 32 : 16);
    Instr instr = {(byte*) state->pc, is32bits};
    state->pc += is32bits ? 2 : 1;
    return instr;
}

} // namespace Fetcher