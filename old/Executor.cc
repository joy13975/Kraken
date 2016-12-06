#include <string.h>

#include "Executor.hh"
#include "JInstruction.hh"

void Executor::onPrepare()
{
}

void Executor::beforeWrite()
{
    this->myJI = JInsTable[*myOpcodeOutport];

    this->skip = (this->myJI.xUnitOp == XUOP_LD ||
                  this->myJI.xUnitOp == XUOP_ST ||
                  this->myJI.xUnitOp == XUOP_NONE);
    if (this->skip)
    {
        raw("%14s: Skipping %s\n",
            this->myStageName, XUnitOp_String[this->myJI.xUnitOp]);
    }
    else
    {
        this->imdv = (this->myJI.xUnitCtrl == XUCTRL_IMDV);
        this->alu = true;

        //alu
        this->dstRegIdx     = *myOperandOutports[0];
        this->dstRegData    = *((Word*) this->myRegFile[dstRegIdx].getOutport());
        this->src1RegIdx    = *myOperandOutports[1];
        this->src1RegData   = *((Word*) this->myRegFile[src1RegIdx].getOutport());
        this->src2RegIdx    = *myOperandOutports[2];
        this->src2RegData   = *((Word*) this->myRegFile[src2RegIdx].getOutport());
        this->imdData       = *((Word*) myImmediateOutport);
        this->src2Data      = this->imdv ? imdData : src2RegData;
        this->aluDstRegIdx  = dstRegIdx;

        this->relv          = (this->myJI.xUnitCtrl == XUCTRL_RELV);
        this->currentPC     = *((Word*) myPCReg.getOutport());

        switch (this->myJI.xUnitOp)
        {
        case XUOP_ADD:
            this->aluResult = src1RegData + src2Data;
            this->aluSymbol = "+";
            break;
        case XUOP_SUB:
            this->aluResult = src1RegData - src2Data;
            this->aluSymbol = "-";
            break;
        case XUOP_MUL:
            this->aluResult = src1RegData * src2Data;
            this->aluSymbol = "*";
            break;
        case XUOP_DIV:
            this->aluResult = src1RegData / src2Data;
            this->aluSymbol = "/";
            break;
        case XUOP_B:
            this->alu = false;
            this->bDstAddr = this->relv ?
                             this->currentPC - 1 + this->imdData :
                             this->imdData;
            break;
        case XUOP_BLT:
            this->alu = false;
            this->bDstAddr = src1RegData < src2RegData ?
                             (this->relv ?
                              this->currentPC - 1 + this->imdData :
                              this->imdData)
                             :
                             (this->currentPC);
            break;
        case XUOP_BZ:
            this->alu = false;
            this->bDstAddr = src1RegData == 0 ?
                             (this->relv ?
                              this->currentPC - 1 + this->imdData :
                              this->imdData)
                             :
                             (this->currentPC);
            break;
        default:
            die("Unimplemented instruction: %d (%s)\n",
                this->myJI.xUnitOp,
                XUnitOp_String[this->myJI.xUnitOp]);
            break;
        }
    }

    if (!this->skip)
    {
        if (this->alu)
        {
            if (this->imdv)
            {
                raw("%14s: R%d(%d) <- R%d(%d) %s I(%d) = %d\n",
                    this->myStageName,
                    this->aluDstRegIdx,
                    this->dstRegData,
                    this->src1RegIdx,
                    this->src1RegData,
                    this->aluSymbol,
                    this->src2Data,
                    this->aluResult);
            }
            else
            {
                raw("%14s: R%d(%d) <- R%d(%d) %s R%d(%d) = %d\n",
                    this->myStageName,
                    this->aluDstRegIdx,
                    this->dstRegData,
                    this->src1RegIdx,
                    this->src1RegData,
                    this->aluSymbol,
                    this->src2RegIdx,
                    this->src2Data,
                    this->aluResult);
            }

            *((Word*) this->myRegFile[this->aluDstRegIdx].getInport()) = this->aluResult;
        }
        else
        {
            raw("%14s: Branch (%s) from (PC-1)=%d to PC=%d\n",
                this->myStageName,
                this->relv ? "R" : "I",
                this->currentPC,
                this->bDstAddr);

            *((Word*) myPCReg.getInport()) = this->bDstAddr;
        }
    }

    //halt clock at end of pipeline?
    if (this->myJI.xUnitCtrl == XUCTRL_HALT)
    {
        wrn("HALT received - clock stopped\n");
        this->myClock->pause();
    }
}

void Executor::onCannotWrite()
{
}

void Executor::testClass()
{
    wrn("Executor has no unit test\n");
}

Executor::~Executor()
{
}

Executor::Executor(Clock& clock,
                   Registers& inputReadyRegs,
                   XOut& decoder,
                   Registers& regFile,
                   Register& pcReg) :
    XInOut(clock,
           STAGE_EXEC,
           inputReadyRegs,
           decoder),
    RegFiler(clock,
             STAGE_EXEC,
             inputReadyRegs,
             decoder,
             regFile),
    myPCReg(pcReg)
{
}