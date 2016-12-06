#include <string.h>

#include "WTBack.hh"
#include "JInstruction.hh"

void WTBack::onPrepare()
{
}

void WTBack::beforeWrite()
{
    raw("%14s: Writing back to register file\n",
        this->myStageName);
}

void WTBack::onCannotWrite()
{
}

void WTBack::testClass()
{
    wrn("WTBack has no unit test\n");
}

WTBack::~WTBack()
{
}

WTBack::WTBack(Clock& clock,
               Registers& inputReadyRegs,
               XOut& macc,
               Registers& regFile) :
    XInOut(clock,
           STAGE_WTBACK,
           inputReadyRegs,
           macc),
    RegFiler(clock,
             STAGE_WTBACK,
             inputReadyRegs,
             macc,
             regFile)
{
}