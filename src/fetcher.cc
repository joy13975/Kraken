#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

Fetcher::Fetcher(State * state)
    : state_(state)
{
}

const vixl::Instruction * Fetcher::fetch()
{
    dbg("Fetching at pc: %p (global: %p)\n",
        state_->getPcOffset(), state_->pc_);

    const vixl::Instruction * instr =
        reinterpret_cast<const vixl::Instruction*>(state_->pc_);
    state_->pc_++;

    return instr;
}

} // namespace Kraken