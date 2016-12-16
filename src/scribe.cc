#include "scribe.h"

namespace Kraken
{

void Scribe::hardResetComponent()
{

}

void Scribe::softResetComponent()
{
    nToPop = 0;
    cachedNToPop = 0;
}

void Scribe::computeComponent()
{
    for (int i = 0; i < cachedNToPop; i++)
    {
        if (!robHead)
            die("   Scribe: robHead is null\n");

        for (const Scripture & s : robHead->getScriptureList())
            applyScripture(s);

        RobEntry * tmp = robHead;
        if (!robHead->successor)
            die("   Scribe: robHead->successor is null\n");
        robHead = robHead->successor;
        if (robHead == tmp)
            die("Impossible ROB\n");
        delete tmp;
    }

    nToPop = 0;
    RobEntry * tmp = robHead;
    while (tmp &&
            (tmp->status == RobEntry::Status::Done ||
             tmp->status == RobEntry::Status::Invalid))
    {
        nToPop++;
        tmp = tmp->successor;
    }

    if(!tmp)
        nToPop--;

    dbg("   Scribe: could pop %d entries (%p)\n",
        nToPop, robHead);
}

void Scribe::updateComponent()
{
    cachedNToPop = nToPop;
}

void Scribe::applyScripture(const Scripture & s)
{
    wrn("TODO: applyScripture\n");
}


} // namespace Kraken