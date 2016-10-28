#ifndef _JPROCESSOR_HH
#define _JPROCESSOR_HH

//CPP Headers
#include <vector>
#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "JMachineCode.hh"
#include "Register.hh"
#include "Clock.hh"
#include "Fetcher.hh"
#include "Decoder.hh"
#include "Executor.hh"
#include "MemAcc.hh"
#include "WTBack.hh"

class JProcessor : public Testable
{
public:
    JProcessor(const double &clockFreq, const JProgram &program);
    virtual ~JProcessor();
    void testClass();
    void run();

private:
    //The following components MUST be written in this order!
    //The class init list dependencies is CRUCIAL
    //Wrong order can cause HAUNTING bugs that will take
    //a millennium to fix!!!!!!!
    Clock           myClock;

    const Memory    myIMem;
    Memory          myDMem;
    Register        myPCReg;
    Registers       myInputReadyRegs;
    Registers       myRegFile;

    Fetcher         myFetcher;
    Decoder         myDecoder;
    Executor        myExec;
    MemAcc          myMemAcc;
    WTBack          myWTBack;


    //private methods
    Registers makeInputReadyRegs(Clock &clock);
    Memory loadIMem(const JProgram &program);
    Memory makeDMem();
};

#endif /* include guard */