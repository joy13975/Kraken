#include "DMemer.hh"

DMemer::DMemer(Clock& clock,
               const int& stageId,
               Registers& inputReadyRegs,
               XOut& xot,
               Memory& dMem) :
    XInOut(clock,
           stageId,
           inputReadyRegs,
           xot),
    myDMem(dMem)
{
}