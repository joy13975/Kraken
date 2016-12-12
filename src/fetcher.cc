#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

void Fetcher::Fetch(const Word * const pc, const short &n_superscalar)
{
    dbg("   Fetch with pc: %p\n", pc);

    fetchedInstr_ =
        reinterpret_cast<const vixl::Instruction*>(pc);
    dbg("   Fetch fetchedInstr_ <- %p\n", fetchedInstr_);

    fetchedPc_ =
        reinterpret_cast<const vixl::Instruction*>(pc + n_superscalar);
    dbg("   Fetch fetchedPc_ <- %p\n", fetchedPc_);
}

} // namespace Kraken