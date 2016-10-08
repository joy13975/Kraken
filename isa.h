#ifndef _ISA_H
#define _ISA_H

#include "config.h"

#define ISA_HALT    0x0
#define ISA_ADD     0x1
#define ISA_ADDI    0x2
#define ISA_CMP     0x3
#define ISA_CMPI    0x4
#define ISA_MOV     0x5
#define ISA_LD      0x6
#define ISA_LDI     0x7
#define ISA_ST      0x8
#define ISA_STI     0x9
#define ISA_B       0xa
#define ISA_RB      0xb
#define ISA_BLT     0xc
#define ISA_RBLT    0xd
#define ISA_BZ      0xe

typedef struct
{
    BYTE opcode;
    BYTE dst;
    BYTE src1;
    BYTE src2;
    WORD imd;
} execution_info;

#endif