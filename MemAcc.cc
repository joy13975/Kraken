#include "MemAcc.hh"
#include "JInstruction.hh"

void MemAcc::onPrepare()
{
}

void MemAcc::beforeWrite()
{
    this->myJI = JInsTable[*myOpcodeOutport];

    bool isLD = this->myJI.xUnitOp == XUOP_LD;
    bool isST = this->myJI.xUnitOp == XUOP_ST;
    bool imdv = this->myJI.xUnitCtrl == XUCTRL_IMDV;
    this->skip = !isLD && !isST;
    if (this->skip)
    {
        raw("%14s: Skipping %s\n",
            this->myStageName, XUnitOp_String[this->myJI.xUnitOp]);
    }
    else
    {
        //fixed
        this->srcRegIdx  = *myOperandOutports[1];
        this->srcRegData = *((Word*) this->myRegFile[srcRegIdx].getOutport());
        this->dstRegIdx  = *myOperandOutports[0];
        this->dstRegData = *((Word*) this->myRegFile[dstRegIdx].getOutport());

        if (isLD)
        {
            this->srcMemAddr = imdv ?
                               *((Word*) myImmediateOutport) :
                               *((Word*) this->myRegFile[srcRegIdx].getOutport());

            raw("%14s: Loading DMEM[%d] (%d) into R%d (%d)\n",
                this->myStageName,
                this->srcMemAddr,
                this->myDMem[srcMemAddr],
                this->dstRegIdx,
                this->dstRegData);

            *((Word*)this->myRegFile[dstRegIdx].getInport()) = this->myDMem[srcMemAddr];
        }
        else if (isST)
        {
            this->dstMemAddr = imdv ?
                               *((Word*) myImmediateOutport) :
                               *((Word*) this->myRegFile[dstRegIdx].getOutport());
            raw("%14s: Storing R%d (%d) into DMEM[%d] (%d)\n",
                this->myStageName,
                this->srcRegIdx,
                this->srcRegData,
                this->dstMemAddr,
                this->myDMem[dstMemAddr]);

            this->myDMem[dstMemAddr] = srcRegData;
        }
    }

    if (this->myJI.xUnitCtrl == XUCTRL_VSET)
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

void MemAcc::onCannotWrite()
{
}

void MemAcc::testClass()
{
    wrn("MemAcc has no unit test\n");
}

MemAcc::~MemAcc()
{
}

MemAcc::MemAcc(Clock& clock,
               Registers& inputReadyRegs,
               XOut& exec,
               Registers& regFile,
               Memory& dMem) :
    XInOut(clock,
           STAGE_MEMACC,
           inputReadyRegs,
           exec),
    RegFiler(clock,
             STAGE_MEMACC,
             inputReadyRegs,
             exec,
             regFile),
    DMemer(clock,
           STAGE_MEMACC,
           inputReadyRegs,
           exec,
           dMem)
{
}