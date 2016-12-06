#ifndef _PROCSTAGE_HH_
#define _PROCSTAGE_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "Register.hh"

class ProcStage : public Clock::Clockable, public Testable
{
public:
    ProcStage(Clock& clock,
              const int& stageId,
              Registers& inputReadyRegs);
    virtual ~ProcStage() {};
    virtual void testClass() = 0;
    void onClockHigh();
    virtual void onPrepare() {};
    virtual void onCanWrite() = 0;
    virtual void onCannotWrite() {};

protected:
    Byte *myInputReadyInport;
    const Outports myInputReadyOutports;
    const int myStageId;
    const char* myStageName;
};

#endif /* include guard */