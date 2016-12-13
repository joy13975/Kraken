#ifndef _PROC_H_
#define _PROC_H_

#include <string>

#include "types.h"
#include "bit_util.h"
#include "fetcher.h"
#include "scribe.h"
#include "component_base.h"

#include "vixl/a64/decoder-a64.h"
#include "vixl/a64/logic-a64.h"

namespace Kraken
{

class Proc : public ComponentBase
{
public:

    Proc(const Options &_options);
    virtual ~Proc() {};

    void reset();
    void update();
    void startSimulation();

private:
    // "ROM"
    const Options options_;
    const ProgramInfo progInfo_;

    // components
    vixl::Decoder decoder_;
    Fetcher fetcher_;
    vixl::Logic logic_;

    // state
    const Word * pc_;

    void run();
    void breakpoint(const ptrdiff_t addr);
    void dumpData();
    void dumpStack();
};

} // namespace Kraken

#endif /* include guard */