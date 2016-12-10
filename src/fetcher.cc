#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

Fetcher::Fetcher(const Word *& pc)
    : pc_(pc)
{
}

const vixl::Instruction * Fetcher::fetch()
{
    dbg("Fetching at pc: %p\n", pc_);

    const vixl::Instruction * instr =
        reinterpret_cast<const vixl::Instruction*>(pc_);
    pc_++;

    return instr;
}

} // namespace Kraken