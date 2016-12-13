#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

void Fetcher::Fetch(const vixl::Instruction * const pc)
{
    dbg("   Fetch with pc: %p\n", pc);

    fetchedInstr = pc;
    dbg("   Fetch fetchedInstr <- %p\n", fetchedInstr);
}

} // namespace Kraken