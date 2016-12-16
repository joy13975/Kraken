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

protected:
    virtual void softResetComponent();

private:
    // registers
    State state;

    // components
    Fetcher fetcher;
    vixl::Decoder decoder;
    vixl::Logic logic;
    Scribe scribe;

    // buffers
    BranchRecords branchRecords;
    ReorderBuffer reorderBuffer;

    // flags
    bool breakSubsequent = false;

    void init();
    void run();
    void checkBreakpoint(const ptrdiff_t pcOffset);
};

} // namespace Kraken

#endif /* include guard */