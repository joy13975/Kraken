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

    void reset();
    void update();
    void startSimulation();

    void dumpData();
    void dumpStack();

    const vixl::Decoder & getDecoder() { return decoder; }
    const Fetcher & getFetcher() { return fetcher; }
    const vixl::Logic & getLogic() { return logic; }

private:
    // components
    vixl::Decoder decoder;
    Fetcher fetcher;
    vixl::Logic logic;

    // registers
    InstrPtr pc;
    // vixl::SimRegister               regs_[vixl::kNumberOfRegisters];
    // vixl::SimVRegister              vregs_[vixl::kNumberOfVRegisters];
    // vixl::SimSystemRegister         nzcv;
    // vixl::SimSystemRegister         fpcr;

    // buffers
    BranchRecords branchRecords;

    void run();
    void breakpoint(const ptrdiff_t addr);
};

} // namespace Kraken

#endif /* include guard */