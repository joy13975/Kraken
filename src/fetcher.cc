#include "fetcher.h"
#include "bit_util.h"
#include "util.h"

namespace Kraken
{

Fetcher::Fetcher(InstrPtr & _pc,
                 const BranchRecords & _branchRecords,
                 const bool _pipelined,
                 const InstrPtr _absTextEnd)
    : pc(_pc),
      branchRecords(_branchRecords),
      pipelined(_pipelined),
      absTextEnd(_absTextEnd)
{
}

InstrPtr Fetcher::consumeInstr() {
    if (buffer.size() > 0)
    {
        InstrPtr ip = buffer.front();
        buffer.pop_front();
        tmpBuffer.pop_front();
        dbg("   Fetcher: consume instr %p (%d left in buffer)\n",
            ip, buffer.size());
        return ip;
    }
    else
    {
        dbg("   Fetcher: nothing in buffer for consumption\n");
        return 0;
    }
}

void Fetcher::hardResetComponent()
{
    pc = 0;
    decoder = 0;
    logic = 0;
}

void Fetcher::softResetComponent()
{
    dbg("   Fetcher: soft reset\n");
    tmpBuffer.clear();
    buffer.clear();
}

void Fetcher::computeComponent()
{
    if (!logic || !decoder)
        die("Fetcher:  logic/decoder pointer is not set\n");
    fetch();
}

void Fetcher::updateComponent()
{
    buffer = tmpBuffer;
}

void Fetcher::syncComponent()
{
}

void Fetcher::fetch()
{
    dbg("   Fetcher: at: %p (buffer %d:%d)\n",
        pc, tmpBuffer.size(), buffer.size());

    int n = 0;
    while (tmpBuffer.size() < MAX_BUF_SIZE)
    {
        if (pc < absTextEnd)
        {
            tmpBuffer.push_back(pc);

            // guess next pc
            const InstrPtr bpSuggest =
                branchRecords.predict(pc);

            prf("   Fetcher: BP: %p -> %p\n", pc, bpSuggest);
            pc = bpSuggest;
            n++;
        }
        else
        {
            dbg("   Fetcher: PC reached end of .text: %p/%p\n", pc, absTextEnd);
            break;
        }
    }

    if (tmpBuffer.size() > 0)
        dbg("   Fetcher: front instr = %p, fetched %d, tmpBuffer: %d\n", tmpBuffer.front(), n, tmpBuffer.size());
}

} // namespace Kraken