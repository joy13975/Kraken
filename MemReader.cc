#include "MemReader.hh"
#include "JInstruction.hh"

void MemReader::onPrepare()
{
}

void MemReader::beforeWrite()
{
    this->myJI = JInsTable[*myOpcodeOutport];

    this->skip = this->myJI.xUnitOp != XUOP_LD;
    if (this->skip)
    {
        raw("%14s: Skipping non-load instruction: %s\n",
            this->myStageName, XUnitOp_String[this->myJI.xUnitOp]);
    }
    else
    {
        //fixed
        this->dstRegIdx  = *myOperandOutports[0];
        this->dstRegData = *((Word*) this->myRegFile[dstRegIdx].getOutport());
        this->srcRegIdx  = *myOperandOutports[1];

        //depends
        this->srcMemAddr = this->myJI.xUnitCtrl == XUCTRL_IMDV ?
                           *((Word*) myImmediateOutport) :
                           *((Word*) this->myRegFile[srcRegIdx].getOutport());

        raw("%14s: Loading DMEM[%d] (%d) into R%d (%d)\n",
            this->myStageName,
            this->srcMemAddr,
            this->myDMem[srcMemAddr],
            this->dstRegIdx,
            this->dstRegData);
    }

    if (!skip)
        *((Word*)this->myRegFile[dstRegIdx].getInport()) = this->myDMem[srcMemAddr];
}

void MemReader::onCannotWrite()
{
}

void MemReader::testClass()
{
    wrn("MemReader has no unit test\n");
}

MemReader::~MemReader()
{
}

MemReader::MemReader(Clock& clock,
                     Registers& inputReadyRegs,
                     XOut& decoder,
                     Registers& regFile,
                     Memory& dMem) :
    XInOut(clock,
           STAGE_MEMRDR,
           inputReadyRegs,
           decoder),
    RegFiler(clock,
             STAGE_MEMRDR,
             inputReadyRegs,
             decoder,
             regFile),
    DMemer(clock,
           STAGE_MEMRDR,
           inputReadyRegs,
           decoder,
           dMem)
{
}