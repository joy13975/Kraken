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
    Proc(const Options &_options)
        : options(_options),
          progInfo(ProgramInfo(std::ifstream(options.input, std::ios::binary))),
          absTextStart(progInfo.offset<InstrPtr >(progInfo.textStart)),
          absTextEnd(progInfo.offset<InstrPtr >(progInfo.textEnd)),
          pc(progInfo.offset<InstrPtr >(progInfo.entry)),
          branchRecords(_options.bpMode, _options.nBPBits, absTextEnd)
    {}

    virtual ~Proc() {}

    void reset();
    void update();
    void startSimulation();

private:
    const Options options;
    const ProgramInfo progInfo;
    const InstrPtr absTextStart;
    const InstrPtr absTextEnd;

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
    void dumpData();
    void dumpStack();
};

} // namespace Kraken

#endif /* include guard */