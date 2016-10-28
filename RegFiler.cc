#include "RegFiler.hh"

RegFiler::RegFiler(Clock& clock,
                   const int& stageId,
                   Registers& inputReadyRegs,
                   XOut& xot,
                   Registers& regFile) :
    XInOut(clock,
           stageId,
           inputReadyRegs,
           xot),
    myRegFile(regFile)
{
}