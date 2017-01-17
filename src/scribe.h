#ifndef _SCRIBE_H_
#define _SCRIBE_H_

#include "types.h"
#include "util.h"
#include "component_base.h"
#include "state.h"

namespace Kraken
{

class Scribe : public ComponentBase
{
public:
    Scribe(RobEntry * _robHead,
           State & _state)
        : robHead(_robHead),
          state(_state)
    {}

    virtual ~Scribe() {}
    unsigned long getInstrCount() {
        return instrCount;
    }

protected:
    virtual void hardResetComponent();
    virtual void softResetComponent();
    virtual void computeComponent();
    virtual void updateComponent();

private:
    RobEntry * robHead, * cachedRobHead;
    State & state;
    unsigned long instrCount = 0;
};

} // namespace Kraken

#endif /* include guard */