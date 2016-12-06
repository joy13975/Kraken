#ifndef _JMACHINECODE_HH_
#define _JMACHINECODE_HH_

//CPP Headers
#include <vector>
#include "JProcDefs.hh"

typedef struct
{
    Byte opcode;
    Byte operands[3];
    Word immediate;
} JMachineCode; /* size of 2 WORDs */

using JProgram = std::vector<JMachineCode>;

#endif /* include guard */