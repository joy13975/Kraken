#ifndef _PROC_H_
#define _PROC_H_

#include <string>

#include <signal.h>

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
    const Options options;
    const ProgramInfo progInfo;
    const InstrPtr absTextStart;
    const InstrPtr absTextEnd;

    Proc(const Options &_options);

    virtual ~Proc() {}

    virtual void computeComponent() final;

    void dumpData();
    void dumpStack();

    void printMemInfo();
    unsigned long getCycleCount() { return cycleCount; }
    vixl::Logic * getLogic() { return &logic; };

protected:
    virtual void softResetComponent();

private:
    // buffers
    BranchRecords branchRecords;
    RobEntry * robHead = new RobEntry();

    // registers
    State state;

    // components
    Fetcher fetcher;
    vixl::Decoder decoder;
    vixl::Logic logic;
    Scribe scribe;

    // flags
    bool breakSubsequent = false;

    unsigned long cycleCount;

    void init();
    void run();
    void checkBreakpoint(const ptrdiff_t pcOffset);
};

} // namespace Kraken

#endif /* include guard */