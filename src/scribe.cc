#include "scribe.h"

namespace Kraken
{

void Scribe::hardResetComponent()
{

}

void Scribe::softResetComponent()
{
    instrCount = 0;
}

void Scribe::computeComponent()
{
    int nToPop = 0;
    bool noSucc = false;
    while (robHead &&
            (robHead->status == RobStatus::CanKill ||
             robHead->status == RobStatus::Invalid))
    {
        prf("   Scribe: shifting robHead %p for status %s\n",
            robHead->decInstr.instr, RobStatusString[robHead->status]);
        nToPop++;

        if (robHead->status != RobStatus::Invalid)
        {
            //TODO: commit changes from robentry to proc state
        }

        if ((noSucc = !robHead->successor))
            break;

        RobEntry * tmp = robHead->successor;
        delete robHead;
        robHead = tmp;

        instrCount++;
    }

    dbg("   Scribe: popped %d ROB entries (now: %p:%s)\n",
        nToPop, robHead, noSucc ? "NoSucc" : RobStatusString[robHead->status]);
}

void Scribe::updateComponent()
{
}

} // namespace Kraken