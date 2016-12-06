#ifndef _XINOUT_HH_
#define _XINOUT_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "XOut.hh"
#include "Register.hh"
#include "JInstruction.hh"

class XInOut : public XOut
{
public:
    XInOut(Clock& clock,
           const int& stageId,
           Registers& inputReadyRegs,
           XOut& xot);
    virtual ~XInOut() {};
    void onCanWrite() final;
    virtual void beforeWrite() = 0;

protected:
    //outports from preview XOut
    const Byte* myOpcodeOutport;
    const Byte* myOperandOutports[3];
    const Byte* myImmediateOutport;

    JInstruction myJI;
};

#endif /* include guard */