#include "Decoder.hh"
#include "JInstruction.hh"

void Decoder::onPrepare()
{
}
void Decoder::beforeWrite()
{
    this->myJI = JInsTable[*myOpcodeOutport];

    raw("%14s: %-14s%-16s%-8s\n",
        this->myStageName,
        XUnitOp_String[this->myJI.xUnitOp],
        XUnitCtrl_String[this->myJI.xUnitCtrl],
        OperandFmt_String[this->myJI.operandFmt]);
}

void Decoder::onCannotWrite()
{
}

void Decoder::testClass()
{
    wrn("Decoder has no unit test\n");
}

Decoder::~Decoder()
{
}

Decoder::Decoder(Clock& clock,
                 Registers& inputReadyRegs,
                 XOut& fetcher) :
    XInOut(clock,
           STAGE_DECODE,
           inputReadyRegs,
           fetcher)
{
}