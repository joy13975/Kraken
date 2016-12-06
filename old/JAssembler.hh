#ifndef _JASSEMBLER_HH_
#define _JASSEMBLER_HH_

//CPP headers
#include "JProcDefs.hh"
#include "JInstruction.hh"
#include "UtilCpp.hh"
#include "JMachineCode.hh"

static const int ISA_Size = sizeof(JInsTable) / sizeof(JInsTable[0]);

class JAssembler : public Testable
{
public:
    JAssembler(const char *jasmFile);
    ~JAssembler();
    void testClass();
    const JProgram getProgram();
    static char* makeMnemonic(const int opcode);
    static int getOpcode(const char *name);
    static const char* getOprFmt(const int opcode);

private:
    const char *myJasmFile;
    const JProgram myProgram;

    const JProgram parse(const char *jasmFile);
};

#endif /* include guard */