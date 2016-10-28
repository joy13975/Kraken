#include "util.h"

#include "JProcessor.hh"
#include "JAssembler.hh"

void JProcessor::run()
{
    raw("Starting JProcessor\n");

    myClock.autoTick();

    //print until last non zero value
    int lastNonZeroIdx = -1;
    for (int i = this->myDMem.size() - 1; i > -1; i--)
    {
        if (this->myDMem[i] != 0)
        {
            lastNonZeroIdx = i;
            break;
        }
    }

    for (int i = 0; i < lastNonZeroIdx + 1; i++)
        raw("DMEM[%-2d] = %d\n", i, myDMem[i]);

    while (1) {};
}

Registers JProcessor::makeInputReadyRegs(Clock &clock)
{
    Registers vr = Register::makeRegisters(clock,
                                           N_STAGES,
                                           1);

    Byte ready = 1;
    vr[STAGE_DECODE].writeData(&ready);

    return vr;
}

Memory JProcessor::makeDMem()
{
    Memory m;
    for (int i = 0; i < DEFAULT_DMEM_SIZE; i++)
        m.push_back(0);
    return m;
}

Memory JProcessor::loadIMem(const JProgram &program)
{
    Memory m;
    for (int i = 0; i < program.size(); i++)
    {
        const Word *jmcData = (const Word*) & (program[i]);
        m.push_back(jmcData[0]);
        m.push_back(jmcData[1]);
    }

    //always append halt instruction
    JMachineCode haltMC = { (Byte) JAssembler::getOpcode("HALT"), 0, 0, 0, 0};
    const Word * jmcData = (const Word*) &haltMC;
    m.push_back(jmcData[0]);
    m.push_back(jmcData[1]);

    return m;
}

void JProcessor::testClass()
{
    //test dependencies
    Clock testClock(1000);
    testClock.testClass();

    const Memory testIMem = myIMem;
    Memory testDmem = makeDMem();

    Register testPCReg(testClock, WordLength);
    testPCReg.testClass();

    Registers testInputReadyRegs =
        makeInputReadyRegs(testClock);

    Registers testRegFile = Register::makeRegisters(myClock,
                            DEFAULT_REG_FILE_SIZE,
                            WordLength);

    Fetcher testFetcher(testClock,
                        testInputReadyRegs,
                        testIMem,
                        testPCReg);
    testFetcher.testClass();

    Decoder testDecoder(testClock,
                        testInputReadyRegs,
                        testFetcher);
    testDecoder.testClass();

    MemReader testMemReader(testClock,
                            testInputReadyRegs,
                            testDecoder,
                            testRegFile,
                            testDmem);
    testMemReader.testClass();

    IntALU testIntALU(testClock,
                      testInputReadyRegs,
                      testMemReader,
                      testRegFile,
                      testPCReg);
    testIntALU.testClass();

    MemWriter testMemWriter(testClock,
                            testInputReadyRegs,
                            testIntALU,
                            testRegFile,
                            testDmem);
    testMemWriter.testClass();

    //test current class
    Memory m;
    for (int i = 0; i < m.size(); i++)
        if (m[i])
            die("Memory initialised was not clean! Word is %d at location %d\n",
                m[i], i);

    JMachineCode testJmc[] = {
        {0, 1, 2, 3, 1337},
        {0, 1, 2, 3, 1338},
        {0, 1, 2, 3, 2000},
        {3, 2, 1, 0, -999}
    };
    const int nTestJmc = sizeof(testJmc) / sizeof(testJmc[0]);
    const JProgram testProgram(testJmc, testJmc + nTestJmc);
    m = loadIMem(testProgram);

    for (int i = 0; i < m.size(); i++)
    {
        if (i == m.size() - 2)
        {
            Byte *b = (Byte*) &m[i];
            if (b[0] != JAssembler::getOpcode("HALT"))
                die("Final instruction should be HALT\n");
            break;
        }
        else if (i % 2 == 0)
        {
            JMachineCode jmc = testJmc[i / 2];
            Byte *b = (Byte*) &m[i];
            if (jmc.opcode != b[0] ||
                    jmc.operands[0] != b[1] ||
                    jmc.operands[1] != b[2] ||
                    jmc.operands[2] != b[3])
                die("JMachineCode parsing check failed at %d: %d,%d,%d,%d (ops) should be %d,%d,%d,%d\n",
                    i, b[0], b[1], b[2], b[3],
                    jmc.opcode, jmc.operands[0], jmc.operands[1], jmc.operands[2]);
        }
        else
        {
            JMachineCode jmc = testJmc[i / 2];
            if (jmc.immediate != m[i])
                die("JMachineCode parsing check failed: %d (immediate) should be %d\n",
                    m[i], jmc.immediate);
        }
    }
}

JProcessor::~JProcessor()
{
}

JProcessor::JProcessor(const double & clockFreq, const JProgram & program) :
    myClock(clockFreq),
    myIMem(loadIMem(program)),
    myDMem(makeDMem()),
    myPCReg(Register(myClock, WordLength)),
    myInputReadyRegs(makeInputReadyRegs(myClock)),
    myRegFile(Register::makeRegisters(myClock,
                                      DEFAULT_REG_FILE_SIZE,
                                      WordLength)),
    myFetcher(myClock,
              myInputReadyRegs,
              myIMem,
              myPCReg),
    myDecoder(myClock,
              myInputReadyRegs,
              myFetcher),
    myMemReader(myClock,
                myInputReadyRegs,
                myDecoder,
                myRegFile,
                myDMem),
    myIntALU(myClock,
             myInputReadyRegs,
             myMemReader,
             myRegFile,
             myPCReg),
    myMemWriter(myClock,
                myInputReadyRegs,
                myIntALU,
                myRegFile,
                myDMem)
{
    raw("+----------------------------------------------------------+\n");
    raw("|                   JProcessor Simulator                   |\n");
    raw("+----------------------------------------------------------+\n");
}

