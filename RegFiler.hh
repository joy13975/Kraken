#ifndef _REGFILER_HH_
#define _REGFILER_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "XInOut.hh"
#include "Register.hh"

class RegFiler : public virtual XInOut
{
public:
    RegFiler(Clock& clock,
             const int& stageId,
             Registers& inputReadyRegs,
             XOut& xot,
             Registers& regFile);
    virtual ~RegFiler() {};

protected:
    Registers&  myRegFile;
};

#endif /* include guard */