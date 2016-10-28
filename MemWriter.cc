#include "MemWriter.hh"
#include "JInstruction.hh"

void MemWriter::onPrepare()
{
}

void MemWriter::beforeWrite()
{
    this->myJI = JInsTable[*myOpcodeOutport];

    this->skip = this->myJI.xUnitOp != XUOP_ST;
    if (this->skip)
    {
        raw("%14s: Skipping non-store instruction: %s\n",
            this->myStageName, XUnitOp_String[this->myJI.xUnitOp]);
    }
    else
    {
        //fixed
        this->srcRegIdx  = *myOperandOutports[1];
        this->srcRegData = *((Word*) this->myRegFile[srcRegIdx].getOutport());
        this->dstRegIdx  = *myOperandOutports[0];

        //depends
        this->dstMemAddr = this->myJI.xUnitCtrl == XUCTRL_IMDV ?
                           *((Word*) myImmediateOutport) :
                           *((Word*) this->myRegFile[dstRegIdx].getOutport());
        raw("%14s: Storing R%d (%d) into DMEM[%d] (%d)\n",
            this->myStageName,
            this->srcRegIdx,
            this->srcRegData,
            this->dstMemAddr,
            this->myDMem[dstMemAddr]);
    }

    if (!skip)
        this->myDMem[dstMemAddr] = srcRegData;

    //halt clock at end of pipeline?
    if (this->myJI.xUnitCtrl == XUCTRL_HALT)
    {
        wrn("HALT received - clock stopped\n");
        this->myClock->pause();
    }
    else if (this->myJI.xUnitCtrl == XUCTRL_VSET)
    {
        const Word base = *((Word*) this->myRegFile[*myOperandOutports[0]].getOutport());
        const Word len  = *((Word*) this->myRegFile[*myOperandOutports[1]].getOutport());
        const Word val  = *((Word*) this->myRegFile[*myOperandOutports[2]].getOutport());

        wrn("VSET received - setting DMEM[%d-%d] to value of %d\n",
            base, base + len, val);
        for (int i = base; i < base + len; i++)
            this->myDMem[i] = val;
    }
}

void MemWriter::onCannotWrite()
{
}

void MemWriter::testClass()
{
    wrn("MemWriter has no unit test\n");
}

MemWriter::~MemWriter()
{
}

MemWriter::MemWriter(Clock& clock,
                     Registers& inputReadyRegs,
                     XOut& intALU,
                     Registers& regFile,
                     Memory& dMem) :
    XInOut(clock,
           STAGE_MEMWTR,
           inputReadyRegs,
           intALU),
    RegFiler(clock,
             STAGE_MEMWTR,
             inputReadyRegs,
             intALU,
             regFile),
    DMemer(clock,
           STAGE_MEMRDR,
           inputReadyRegs,
           intALU,
           dMem)
{
}