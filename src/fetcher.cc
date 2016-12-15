#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

Fetcher::Fetcher(InstrPtr & _pc,
                 const BranchRecords * _branchRecords,
                 const bool _pipelined,
                 const InstrPtr _absTextEnd)
    : pc(_pc), branchRecords(_branchRecords),
      pipelined(_pipelined),
      absTextEnd(_absTextEnd)
{
}

void Fetcher::hardResetComponent()
{
    pc = 0;
    decoder = 0;
    logic = 0;
}

void Fetcher::softResetComponent()
{
    dbg("   Fetcher reset\n");
    fetchedInstr = 0;
    cachedInstr = 0;
}

void Fetcher::computeComponent()
{
    if (!logic || !decoder)
        die("Fetcher's logic/decoder pointer is not set\n");
    fetch();
}

void Fetcher::updateComponent()
{
    cachedInstr = fetchedInstr;
    dbg("   Fetch cachedInstr <- %p\n", cachedInstr);
}

void Fetcher::syncComponent()
{
}

void Fetcher::fetch()
{
    if (pc < absTextEnd)
    {
        dbg("   Fetch with pc: %p\n", pc);

        fetchedInstr = pc;
        dbg("   Fetch fetchedInstr <- %p\n", fetchedInstr);

        // guess next pc
        const InstrPtr bpSuggest =
            branchRecords->predict(pc);

        dbg("   Fetch BP: %p -> %p\n",
            pc, bpSuggest);

        pc = bpSuggest;
    }
    else
    {
        dbg("   Fetch no fetch because pc reached the end\n");
    }
}

} // namespace Kraken