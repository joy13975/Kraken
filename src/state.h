#ifndef _STATE_H_
#define _STATE_H_

#include "vixl/a64/logic-regs-a64.h"

namespace Kraken
{

struct State
{
    const vixl::Instruction *       pc = 0;
    vixl::SimRegister               regs[vixl::kNumberOfRegisters];
    vixl::SimVRegister              vregs[vixl::kNumberOfVRegisters];
    vixl::SimSystemRegister         nzcv;
    vixl::SimSystemRegister         fpcr;
};

} // namespace Kraken

#endif /* include guard */