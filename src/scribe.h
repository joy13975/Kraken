#ifndef _SCRIBE_H_
#define _SCRIBE_H_

#include "types.h"
#include "util.h"
#include "proc.h"

namespace Kraken
{

class Scribe
{
public:
    Scribe();
    virtual ~Scribe() {};

    // void commit(Scripture script, State *const state);
private:
};

} // namespace Kraken

#endif /* include guard */