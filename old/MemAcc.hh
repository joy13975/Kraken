#ifndef _MEMACC_HH_
#define _MEMACC_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "RegFiler.hh"
#include "DMemer.hh"
#include "Register.hh"

class MemAcc : public RegFiler, public DMemer
{
public:
    MemAcc(Clock& clock,
              Registers& inputReadyRegs,
              XOut& exec,
              Registers& regFile,
              Memory& dMem);
    ~MemAcc();
    void testClass();
    virtual void onPrepare();
    virtual void beforeWrite();
    virtual void onCannotWrite();

private:
    bool skip;

    Byte dstRegIdx;
    Word dstRegData;

    Byte srcRegIdx;
    Word srcRegData;

    Word srcMemAddr;
    Word dstMemAddr;
};

#endif /* include guard */