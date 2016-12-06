//C headers#include <stdio.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <assert.h>
#include <ctype.h>
#include "util.h"

//CPP headers
#include <vector>
#include "JAssembler.hh"

#define BUFFER_SIZE 512

const JProgram JAssembler::getProgram()
{
    return myProgram;
}

const JProgram JAssembler::parse(const char *jasmFile)
{
    assert(sizeof(JMachineCode) == 2 * sizeof(Word));

    FILE *fp;
    if (!(fp = fopen(jasmFile, "r")))
        die("Can't open JAssembler file \"%s\" (%s)\n", jasmFile, get_error_string());

    JProgram program;
    char line_buffer[BUFFER_SIZE] = {0};
    char *line_mutable_original, *line_mutable;
    while (fgets(line_buffer, BUFFER_SIZE, fp))
    {
        if (strlen(line_buffer) == 0) continue;

        line_mutable_original = strdup(line_buffer);
        line_mutable = line_mutable_original;

        //trim leading whitespace
        while (line_mutable[0] == ' ')
            line_mutable++;

        //trim comments
        char *comment;
        if ((comment = strstr(line_mutable, "#")))
            * comment = '\0';

        //replace \n with \0
        char *newline;
        if ((newline = strstr(line_mutable, "\n")))
            * newline = '\0';

        if (strlen(line_mutable) == 0)
            continue;

        //log cleansed line
        prf("Trimed line: \"%s\"\n", line_mutable);

        //longest mnemonic string would be ~4 chars
        char mnemonic[16] = {0};
        sscanf(line_mutable, "%s", mnemonic);
        char *arguments_original = strdup(line_mutable + strlen(mnemonic) + 1);
        char *arguments = arguments_original;

        JMachineCode mc = {0};
        mc.opcode = getOpcode(mnemonic);
        const char *oprFmt = (char*) getOprFmt(mc.opcode);

        dbg("Mnemonic \"%s\" opcode: %d, operand format: %s\n",
            mnemonic, mc.opcode, oprFmt);

        for (int i = 0; i < strlen(oprFmt); i++)
        {
            //longest instruction argument would be less than 4 chars
            char oprStr[16] = {0};
            sscanf(arguments, "%s", oprStr);
            arguments += strlen(oprStr) + 1;

            dbg("oprStr #%d: %s\n", i, oprStr);

            if (!strlen(oprStr))
                die("Expecting more arguments for %s\n",
                    mnemonic);

            if (oprFmt[i] == 'R')
            {
                if (toupper(oprStr[0]) != 'R')
                    die("Expecting register index for argument #%d of %s",
                        i + 1, mnemonic);
                mc.operands[i] = parse_long(oprStr + 1);
            }
            else if (oprFmt[i] == 'I')
                mc.immediate = parse_long(oprStr);
            else
                die("Unknown operand format token: %c\n", oprFmt[i]);
        }

        program.push_back(mc);
        free(arguments_original);
        free(line_mutable_original);

        //exhaust spurious line remnants
        while (line_buffer[strlen(line_buffer) - 1] != '\n')
            if (!fgets(line_buffer, BUFFER_SIZE, fp))
                break;
    }

    return program;
}

const char* JAssembler::getOprFmt(const int opcode)
{
    const JInstruction ji = JInsTable[opcode];
    const char *oprFmt = strstr(OperandFmt_String[ji.operandFmt], "_") + 1;
    if (!strcmp(oprFmt, "NONE"))
        return "";
    return oprFmt;
}

int JAssembler::getOpcode(const char *mmn_in)
{
    char *name = strdup(mmn_in);
    const int len = strlen(name);

    //convert to upper case
    for (int i = 0; i < len; i++)
        name[i] = toupper(name[i]);

    //find opcode with matching name
    for (int i = 0; i < ISA_Size; i++)
    {
        char *mmn = makeMnemonic(i);
        bool match = strcmp(name, mmn) == 0;
        free(mmn);
        if (match)
        {
            free(name);
            return i;
        }
    }

    free(name);
    die("Illegal instruction: %s\n", name);
}

char* JAssembler::makeMnemonic(const int opcode)
{
    const JInstruction ji = JInsTable[opcode];
    const char *family = ji.xUnitCtrl == XUCTRL_HALT ?
                         "HALT" :
                         (ji.xUnitCtrl == XUCTRL_VSET ?
                          "VSET" :
                          GET_REAL_ENUM_NAME(XUnitOp_String[ji.xUnitOp]));
    char *variant;
    asprintf(&variant,
             "%s%s%s",
             ji.xUnitCtrl == XUCTRL_RELV ? "R" : "",
             family,
             ji.xUnitCtrl == XUCTRL_IMDV ? "I" : "");
    return variant;
}

void JAssembler::testClass()
{
    raw("------------------------------------------------------------\n");
    raw("Program Size (Number of JMachineCode structs): % ld\n", myProgram.size());
    raw("%-10s%-10s%-10s%-10s%-10s%-10s\n", "Mnemonic", "Opcode", "Op1", "Op2", "Op3", "Immediate");
    raw("------------------------------------------------------------\n");
    for (size_t i = 0; i < myProgram.size(); i++)
    {
        JMachineCode mc = myProgram.at(i);
        raw("%-10s0x%-8x0x%-8x0x%-8x0x%-8x%-8d\n",
            makeMnemonic(mc.opcode), mc.opcode,
            mc.operands[0], mc.operands[1],
            mc.operands[2], mc.immediate);
    }
}

JAssembler::~JAssembler()
{
}

JAssembler::JAssembler(const char *jasmFile) :
    myJasmFile(jasmFile),
    myProgram(parse(jasmFile))
{
}