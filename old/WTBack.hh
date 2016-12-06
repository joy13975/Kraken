#ifndef _WTBACK_HH_
#define _WTBACK_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "RegFiler.hh"
#include "Register.hh"

class WTBack : public RegFiler
{
public:
    WTBack(Clock& clock,
           Registers& inputReadyRegs,
           XOut& macc,
           Registers& regFile);
    ~WTBack();
    void testClass();
    virtual void onPrepare();
    virtual void beforeWrite();
    virtual void onCannotWrite();

private:
};

#endif /* include guard */