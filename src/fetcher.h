#ifndef _FETCHER_H_
#define _FETCHER_H_

#include "proc.h"
#include "types.h"
#include "vixl/a64/instructions-a64.h"

namespace Kraken
{

class Fetcher
{
public:
    Fetcher(State * state);
    virtual ~Fetcher() {};

    const vixl::Instruction * fetch();
private:
    State *const state_;
};

} // namespace Kraken

#endif /* include guard */