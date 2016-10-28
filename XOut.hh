#ifndef _XOUT_HH_
#define _XOUT_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "ProcStage.hh"
#include "Register.hh"

class XOut : public ProcStage
{
public:
    XOut(Clock& clock,
         const int& stageId,
         Registers& inputReadyRegs);
    virtual ~XOut() {};

    //outports
    const Byte* getOpcodeOutport();
    const Byte* getOperandsOutport(int idx);
    const Byte* getImmediateOutport();
protected:

    //output buffer
    Register myOpcodeReg;
    Register myOperandRegs[3];
    Register myImmediateReg;
};

#endif /* include guard */