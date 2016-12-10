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
    Fetcher(const Word *& pc);
    virtual ~Fetcher() {};

    const vixl::Instruction * fetch();
private:
    const Word *& pc_;
};

} // namespace Kraken

#endif /* include guard */