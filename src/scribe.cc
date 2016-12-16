#include "scribe.h"

namespace Kraken
{

void Scribe::hardResetComponent()
{

}

void Scribe::softResetComponent()
{

}

void Scribe::updateComponent()
{

    while (reorderBuffer.front().status == ReorderBufferEntry::Status::Done)
    {
        const ReorderBufferEntry rbe = reorderBuffer.front();

        for (const Scripture & s : rbe.getScriptures())
            applyScripture(s);

        reorderBuffer.pop_front();
    }
}

void Scribe::applyScripture(const Scripture & s)
{

}


} // namespace Kraken