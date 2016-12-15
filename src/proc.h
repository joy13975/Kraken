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
    InstrPtr pc = 0;
    // vixl::SimRegister               regs_[vixl::kNumberOfRegisters];
    // vixl::SimVRegister              vregs_[vixl::kNumberOfVRegisters];
    // vixl::SimSystemRegister         nzcv;
    // vixl::SimSystemRegister         fpcr;

    // components
    Fetcher fetcher;
    vixl::Decoder decoder;
    vixl::Logic logic;

    // buffers
    BranchRecords branchRecords;

    // flags
    bool breakSubsequent = false;

    void init();
    void run();
    void checkBreakpoint(const ptrdiff_t pcOffset);
};

} // namespace Kraken

#endif /* include guard */