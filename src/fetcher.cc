#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

const vixl::Instruction * Fetcher::Fetch(const Word ** pcPtr)
{
    dbg("Fetching at pc: %p (global)\n",
        *pcPtr);

    const vixl::Instruction * instr =
        reinterpret_cast<const vixl::Instruction*>(*(pcPtr));
    (*pcPtr)++;

    return instr;
}

} // namespace Kraken