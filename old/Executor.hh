#ifndef _EXECUTOR_HH_
#define _EXECUTOR_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "RegFiler.hh"
#include "Register.hh"

class Executor : public RegFiler
{
public:
    Executor(Clock& clock,
             Registers& inputReadyRegs,
             XOut& decoder,
             Registers& regFile,
             Register& pcReg);
    ~Executor();
    void testClass();
    virtual void onPrepare();
    virtual void beforeWrite();
    virtual void onCannotWrite();

private:
    Register& myPCReg;

    bool skip;
    bool alu;
    bool imdv;
    bool relv;

    Byte dstRegIdx;
    Word dstRegData;
    Byte src1RegIdx;
    Word src1RegData;
    Byte src2RegIdx;
    Word src2RegData;
    Word imdData;
    Word src2Data;

    char const* aluSymbol;
    Byte aluDstRegIdx;
    Word aluResult;

    Word currentPC;
    Word bDstAddr;

    void doB();
    void doBLT();
    void doBZ();
};

#endif /* include guard */