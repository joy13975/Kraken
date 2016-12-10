#ifndef _PROC_H_
#define _PROC_H_

#include <string>

#include "types.h"
#include "bit_util.h"

namespace Kraken
{

class Proc
{
public:

    Proc(const Options &_options);
    virtual ~Proc()
    { delete state_; };

    void startSimulation();

private:
    const Options options_;
    const ProgramInfo progInfo_;
    State *state_;

    void resetStateRegs();
    void run();
    void breakpoint(const ptrdiff_t addr);
};

} // namespace Kraken

#endif /* include guard */