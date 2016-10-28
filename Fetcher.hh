#ifndef _FETCHER_HH_
#define _FETCHER_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "XOut.hh"
#include "Register.hh"
#include "Clock.hh"
#include "JMachineCode.hh"

class Fetcher : public XOut
{
public:
    Fetcher(Clock& clock,
            Registers& inputReadyRegs,
            const Memory& iMem,
            Register& pcReg);
    ~Fetcher();
    void testClass();
    virtual void onPrepare();
    virtual void onCanWrite() ;
    virtual void onCannotWrite();

private:
    Word myPC;
    JMachineCode myJMC;

    const Memory& myIMemOutport;
    Register& myPCReg;
};

#endif /* include guard */