#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Fetcher
{

const KrakenInstr fetch(KrakenState *const state)
{
    dbg("pc: %p\n", state->pc);
    KrakenInstr instr((byte*) state->pc);
    dbg("Fetching at pc: %p, %d-bit\n",
        state->getPcOffset(), instr.isT32 ? 32 : 16);
    state->pc += instr.isT32 ? 2 : 1;
    return instr;
}

} // namespace Fetcher