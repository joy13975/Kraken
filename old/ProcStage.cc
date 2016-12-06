#include "ProcStage.hh"
#include "JInstruction.hh"

void ProcStage::onClockHigh()
{
    const int prevStageId       = (this->myStageId - 1 + N_STAGES) % N_STAGES;
    const int nextStageId       = (myStageId + 1) % N_STAGES;
    const bool canWrite         = *myInputReadyOutports[nextStageId];
    const bool acceptingInput   = *myInputReadyOutports[myStageId];
    const bool willAcceptInput  = *myInputReadyOutports[prevStageId];

    if (canWrite)
    {
        dbg("%s: ACTIVE\n", this->myStageName);
    }
    else
    {
        if (acceptingInput)
        {
            dbg("%s: READY\n", this->myStageName);
        }
        else if (!willAcceptInput)
        {
            dbg("%s: IDLE\n", this->myStageName);
        }
    }

    if (willAcceptInput)
    {
        dbg("%s: WAIT\n",
            this->myStageName);
    }

    this->onPrepare();

    if (canWrite)
    {
        this->onCanWrite();
    }
    else
    {
        this->onCannotWrite();
    }

    if (PIPELINED)
    {
        die("Need to check all input ready flags here\n");
        // this->onCanWrite(); ?
    }
    else
    {
        *myInputReadyInport = willAcceptInput;
    }
}

ProcStage::ProcStage(Clock& clock,
                     const int& stageId,
                     Registers& inputReadyRegs):
    Clock::Clockable(clock),
    myStageId(stageId),
    myInputReadyInport(inputReadyRegs[stageId].getInport()),
    myInputReadyOutports(Register::getOutports(inputReadyRegs)),
    myStageName(StageID_String[myStageId])
{
}