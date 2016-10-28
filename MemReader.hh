#ifndef _MEMREADER_HH_
#define _MEMREADER_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "RegFiler.hh"
#include "DMemer.hh"
#include "Decoder.hh"
#include "Register.hh"

class MemReader : public RegFiler, public DMemer
{
public:
    MemReader(Clock& clock,
              Registers& inputReadyRegs,
              XOut& decoder,
              Registers& regFile,
              Memory& dMem);
    ~MemReader();
    void testClass();
    virtual void onPrepare();
    virtual void beforeWrite();
    virtual void onCannotWrite();

private:
    bool skip;
    Byte dstRegIdx;
    Word dstRegData;
    Byte srcRegIdx;
    Word srcMemAddr;
};

#endif /* include guard */