#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Fetcher
{

const KrakenInstr fetch(KrakenState *const state)
{
    KrakenInstr instr(state->pc);
    dbg("Fetching at pc: %p (real: %p)\n",
        state->getPcOffset(), state->pc);
    state->pc += 1;
    return instr;
}

} // namespace Fetcher