#ifndef _ENACTOR_H_
#define _ENACTOR_H_

#include "util.h"
#include "types.h"
#include "enactor.h"
#include "proc.h"

namespace Kraken
{

class Enactor
{
public:
    Enactor();
    virtual ~Enactor() {};

    Scripture enact(const Action &action,
                    const State *const state);
private:
};

} // namespace Kraken

#endif /* include guard */