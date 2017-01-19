#include "scribe.h"

namespace Kraken
{

void Scribe::hardResetComponent()
{

}

void Scribe::softResetComponent()
{
    dbg("   Scribe: soft reset\n");
    instrCount = 0;
}

void Scribe::computeComponent()
{
    int nToPop = 0;
    bool noSucc = false;

    while (robHead)
    {
        prf("   Scribe: robHead %p, status %s, succ %p\n",
            robHead,
            RobStatusString[robHead->status],
            robHead->successor);

        // this includes CanKill and Invalid
        if (robHead->status >= RobStatus::CanKill)
        {
            if (robHead->status == RobStatus::CanKill)
            {
                if (robHead->speculator)
                    break;
                instrCount++;
            }

            nToPop++;

            if ((noSucc = (!robHead->successor)))
                break;

            RobEntry * tmp = robHead->successor;
            // do not delete - not built for this yet
            // delete robHead;
            robHead = tmp;
        }
        else
        {
            break;
        }
    }

    dbg("   Scribe: retired %d ROB entries (now: %p:%s)\n",
        nToPop, robHead, noSucc ? "NoSucc" : RobStatusString[robHead->status]);
}

void Scribe::updateComponent()
{
}

} // namespace Kraken