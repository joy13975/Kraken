#include "Fetcher.hh"
#include "JAssembler.hh"

void Fetcher::onPrepare()
{
}

void Fetcher::onCanWrite()
{
    //read instruction from mem[pc]
    myPC = *((Word*) myPCReg.getOutport());

    //fetch instruction
    myJMC = *((JMachineCode *) &myIMemOutport[2 * myPC]);

    //about to write
    const char *mnemonic   = JAssembler::makeMnemonic(myJMC.opcode);
    raw("%14s: IMEM[%d]: %-8s { %-2d %-2d %-2d} { %d }\n",
        this->myStageName,
        myPC, mnemonic,
        myJMC.operands[0], myJMC.operands[1], myJMC.operands[2],
        myJMC.immediate);

    //write the data to decoder's signal input
    myOpcodeReg.writeData(&myJMC.opcode);
    for (int i = 0; i < 3; i++)
        myOperandRegs[i].writeData(&myJMC.operands[i]);
    myImmediateReg.writeData((Byte *) &myJMC.immediate);

    //increment PC
    *((Word*) myPCReg.getInport()) += 1;
}

void Fetcher::onCannotWrite()
{
}

void Fetcher::testClass()
{
    wrn("Fetcher has no unit test\n");
}

Fetcher::~Fetcher()
{
}

Fetcher::Fetcher(Clock& clock,
                 Registers& inputReadyRegs,
                 const Memory& iMem,
                 Register& pcReg) :
    XOut(clock,
         STAGE_FETCH,
         inputReadyRegs),
    myIMemOutport(iMem),
    myPCReg(pcReg)
{
}