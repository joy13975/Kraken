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
        fetchedInstr_ = 0;
        cachedInstr_ = 0;
        fetchedPc_ = 0;
        cachedPc_ = 0;
    }
    void update() {
        cachedPc_ = fetchedPc_;
        dbg("   Fetch cachedPc_ <- %p\n", cachedPc_);
        cachedInstr_ = fetchedInstr_;
        dbg("   Fetch cachedInstr_ <- %p\n", cachedInstr_);
    }
    const vixl::Instruction * cachedInstr() { return cachedInstr_; }
    const vixl::Instruction * cachedPc() { return cachedPc_; }

    void Fetch(const Word * pc, const short &n_superscalar);

private:
    const vixl::Instruction * fetchedInstr_, * cachedInstr_;
    const vixl::Instruction * fetchedPc_, * cachedPc_;
};

} // namespace Kraken

#endif /* include guard */