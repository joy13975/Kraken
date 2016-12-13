#ifndef _FETCHER_H_
#define _FETCHER_H_

#include "types.h"
#include "component_base.h"
#include "util.h"

#include "vixl/a64/instructions-a64.h"

namespace Kraken
{

class Fetcher : public ComponentBase
{
public:
    Fetcher() {}
    virtual ~Fetcher() {}

    void reset() {
        dbg("   Fetcher reset\n");
        fetchedInstr = 0;
        cachedInstr = 0;
    }
    void update() {
        cachedInstr = fetchedInstr;
        dbg("   Fetch cachedInstr <- %p\n", cachedInstr);
    }
    const vixl::Instruction * getInstr() { return cachedInstr; }

    void Fetch(const vixl::Instruction * pc);

private:
    const vixl::Instruction * fetchedInstr, * cachedInstr;
};

} // namespace Kraken

#endif /* include guard */