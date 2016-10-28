#ifndef _DECODER_HH_
#define _DECODER_HH_

#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "XInOut.hh"
#include "Fetcher.hh"
#include "Register.hh"

class Decoder : public XInOut
{
public:
    Decoder(Clock& clock,
            Registers& inputReadyRegs,
            XOut& fetcher);
    ~Decoder();
    void testClass();
    virtual void onPrepare();
    virtual void beforeWrite();
    virtual void onCannotWrite();

private:
};

#endif /* include guard */