#ifndef _FETCHER_H_
#define _FETCHER_H_

#include "types.h"
#include "resettable.h"

#include "vixl/a64/instructions-a64.h"

namespace Kraken
{

class Fetcher : public Resettable
{
public:
    Fetcher() {};
    virtual ~Fetcher() {};

    void Reset() {};

    const vixl::Instruction * Fetch(const Word ** pcPtr);
private:
};

} // namespace Kraken

#endif /* include guard */