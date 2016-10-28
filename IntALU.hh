#ifndef _INTALU_HH_
#define _INTALU_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "RegFiler.hh"
#include "MemReader.hh"
#include "Register.hh"

class IntALU : public RegFiler
{
public:
    IntALU(Clock& clock,
           Registers& inputReadyRegs,
           XOut& memReader,
           Registers& regFile,
           Register& pcReg);
    ~IntALU();
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