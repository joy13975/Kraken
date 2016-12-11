#ifndef _PROC_H_
#define _PROC_H_

#include <string>

#include "types.h"
#include "bit_util.h"
#include "fetcher.h"
#include "scribe.h"
#include "resettable.h"

#include "vixl/a64/decoder-a64.h"
#include "vixl/a64/logic-a64.h"

namespace Kraken
{

class Proc : public Resettable
{
public:

    Proc(const Options &_options);
    virtual ~Proc()
    { delete state_; };

    void Reset() {};
    void startSimulation();

private:
    const Options options_;
    const ProgramInfo progInfo_;
    State *state_;

    vixl::Decoder decoder_;
    Fetcher fetcher_;
    vixl::Logic logic_;

    void resetStateRegs();
    void run();
    void breakpoint(const ptrdiff_t addr);
};

} // namespace Kraken

#endif /* include guard */