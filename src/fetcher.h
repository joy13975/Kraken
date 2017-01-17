#ifndef _FETCHER_H_
#define _FETCHER_H_

#include "types.h"
#include "component_base.h"
#include "util.h"

#include "vixl/a64/instructions-a64.h"
#include "vixl/a64/logic-a64.h"

namespace vixl
{
class Logic;
class Decoder;
} // namespace vixl

#define MAX_BUF_SIZE 64

namespace Kraken
{

class Fetcher : public ComponentBase
{
public:
    Fetcher(InstrPtr & _pc,
            const BranchRecords & _branchRecords,
            const bool _pipelined,
            const InstrPtr _absTextEnd);
    virtual ~Fetcher() {}

    void setLogic(vixl::Logic * _logic) {
        logic = _logic;
        connect(this, (ComponentBase*) _logic);
    }
    void setDecoder(vixl::Decoder * _decoder) {
        decoder = _decoder;
        connect(this, (ComponentBase*) _decoder);
    }

    InstrPtr consumeInstr();
    void setPc(InstrPtr newPc) { pc = newPc; }
    InstrPtr peekPc() {
        if (buffer.size() > 0)
            return buffer.front();
        else
            return pc;
    }

protected:
    virtual void hardResetComponent();
    virtual void softResetComponent();
    virtual void computeComponent();
    virtual void updateComponent();
    virtual void syncComponent();

private:
    InstrPtr & pc;
    const BranchRecords & branchRecords;
    const bool pipelined;
    const InstrPtr absTextEnd;

    vixl::Decoder * decoder = 0;
    vixl::Logic * logic = 0;

    InstrPtr fetchedInstr, cachedInstr;
    std::deque<InstrPtr> tmpBuffer;
    std::deque<InstrPtr> buffer;

    void fetch();
};

} // namespace Kraken

#endif /* include guard */