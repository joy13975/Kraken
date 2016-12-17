#ifndef _SCRIBE_H_
#define _SCRIBE_H_

#include "types.h"
#include "util.h"
#include "component_base.h"

namespace Kraken
{

class Scribe : public ComponentBase
{
public:
    Scribe(RobEntry *& _robHead,
           State & _state)
        : robHead(_robHead),
          state(_state)
    {}

    virtual ~Scribe() {}

protected:
    virtual void hardResetComponent();
    virtual void softResetComponent();
    virtual void computeComponent();
    virtual void updateComponent();

private:
    RobEntry * robHead, * cachedRobHead;
    State & state;
    int nToPop, cachedNToPop;

    void applyScripture(const Scripture & s);
};

} // namespace Kraken

#endif /* include guard */