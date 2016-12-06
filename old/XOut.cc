#include "XOut.hh"

const Byte* XOut::getOpcodeOutport()
{
    return this->myOpcodeReg.getOutport();
}

const Byte* XOut::getOperandsOutport(int idx)
{
    if (idx > 2)
        die("There are only 3 operands\n");
    return this->myOperandRegs[idx].getOutport();
}

const Byte* XOut::getImmediateOutport()
{
    return this->myImmediateReg.getOutport();
}

XOut::XOut(Clock& clock,
           const int& stageId,
           Registers& inputReadyRegs) :
    ProcStage(clock,
              stageId,
              inputReadyRegs),
    myOpcodeReg(Register(clock, 1)),
    myOperandRegs{Register(clock, 1),
                  Register(clock, 1),
                  Register(clock, 1)},
    myImmediateReg(Register(clock, WordLength))
{
}