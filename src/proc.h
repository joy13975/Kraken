#ifndef _PROC_H_
#define _PROC_H_

#include <string>

#include "types.h"
#include "bit_util.h"

class KrakenProc
{
public:

    KrakenProc(const KrakenOptions &_options);
    virtual ~KrakenProc()
    { delete state; };

    void startSimulation();

private:
    const KrakenOptions &options;
    KrakenState *state;

    void resetStateRegs();
    bool isPCSensible();
    void run();
    void breakpoint(const uintptr_t addr);
};

#endif /* include guard */