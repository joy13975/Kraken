#ifndef _DMEMER_HH_
#define _DMEMER_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "XInOut.hh"
#include "Register.hh"

class DMemer : public virtual XInOut
{
public:
    DMemer(Clock& clock,
             const int& stageId,
             Registers& inputReadyRegs,
             XOut& xot,
             Memory& dMem);
    virtual ~DMemer() {};

protected:
    Memory&  myDMem;
};

#endif /* include guard */