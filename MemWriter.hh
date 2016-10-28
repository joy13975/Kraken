#ifndef _MEMRWRITER_HH_
#define _MEMRWRITER_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "RegFiler.hh"
#include "DMemer.hh"
#include "IntALU.hh"
#include "Register.hh"

class MemWriter : public RegFiler, public DMemer
{
public:
    MemWriter(Clock& clock,
              Registers& inputReadyRegs,
              XOut& intALU,
              Registers& regFile,
              Memory& dMem);
    ~MemWriter();
    void testClass();
    virtual void onPrepare();
    virtual void beforeWrite();
    virtual void onCannotWrite();

private:
    bool skip;
    Byte srcRegIdx;
    Word srcRegData;
    Byte dstRegIdx;
    Word dstMemAddr;
};

#endif /* include guard */