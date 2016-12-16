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
    Scribe(ReorderBuffer & _reorderBuffer,
           State & _state)
        : reorderBuffer(_reorderBuffer),
          state(_state)
    {}

    virtual ~Scribe() {}

protected:
    virtual void hardResetComponent();
    virtual void softResetComponent();
    virtual void updateComponent();

private:
    ReorderBuffer & reorderBuffer;
    State & state;

    void applyScripture(const Scripture & s);
};

} // namespace Kraken

#endif /* include guard */