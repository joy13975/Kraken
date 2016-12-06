#include "XInOut.hh"
#include "JInstruction.hh"

void XInOut::onCanWrite()
{
    this->beforeWrite();

    //write the data through to next unit's signal input
    myOpcodeReg.writeData(myOpcodeOutport);
    for (int i = 0; i < 3; i++)
        myOperandRegs[i].writeData(myOperandOutports[i]);
    myImmediateReg.writeData(myImmediateOutport);
}

XInOut::XInOut(Clock& clock,
               const int& stageId,
               Registers& inputReadyRegs,
               XOut& xot) :
    XOut(clock,
         stageId,
         inputReadyRegs),
    myOpcodeOutport(xot.getOpcodeOutport()),
    myOperandOutports{xot.getOperandsOutport(0),
                      xot.getOperandsOutport(1),
                      xot.getOperandsOutport(2)},
    myImmediateOutport(xot.getImmediateOutport())
{
}