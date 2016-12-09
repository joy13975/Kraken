#include "decoder.h"

#include "util.h"
#include <bitset>
namespace Decoder
{

#define DECL_T16_FUNC(num) \
    inline KrakenAction T16Format##num(const KrakenInstr &instr)
DECL_T16_FUNC(1)
{
    dbg("Shift by imm; mov reg:\n");
}

DECL_T16_FUNC(2)
{
    dbg("Add/Sub reg:\n");
}

DECL_T16_FUNC(3)
{
    dbg("Add/Sub imm:\n");
}

DECL_T16_FUNC(4)
{
    dbg("Mov/Cmp/Add/Sub imm:\n");
}

DECL_T16_FUNC(5)
{
    dbg("Data processing reg:\n");
}

DECL_T16_FUNC(6)
{
    dbg("Special data processing\n");
}

DECL_T16_FUNC(7)
{
    dbg("Branch/exchange\n");
}

DECL_T16_FUNC(8)
{
    dbg("Load from literal pool\n");
}

DECL_T16_FUNC(9)
{
    dbg("Load/store reg offset\n");
}

DECL_T16_FUNC(10)
{
    dbg("Load/store word/byte imm offset\n");
}

DECL_T16_FUNC(11)
{
    dbg("Load/store halfword imm offset\n");
}

DECL_T16_FUNC(12)
{
    dbg("Load/store stack\n");
}

DECL_T16_FUNC(13)
{
    dbg("Add to SP or PC\n");
    if (instr.matchPattern(27, 1, 0b0))
    {
        dbg("   Add Rd, PC, #Imm\n");
    }
    else
    {
        dbg("   Add Rd, SP, #Imm\n");
    }
}

DECL_T16_FUNC(14)
{
    dbg("Misc\n");
}

DECL_T16_FUNC(15)
{
    dbg("Load/store multiple\n");
}

DECL_T16_FUNC(16)
{
    dbg("Conditional branch\n");

    // check invalid cond
    if (instr.matchPattern(27, 4, 0b1110))
        T16Format16(instr);


}

DECL_T16_FUNC(17)
{
    // literally says undefined in documentation
    die("Undefined instruction\n");
}

DECL_T16_FUNC(18)
{
    dbg("System call\n");
}

DECL_T16_FUNC(19)
{
    dbg("Unconditional branch\n");
}
#undef DECL_T16_FUNC


inline KrakenAction decodeT16(const KrakenInstr &instr)
{   const short hdr = (instr.rawBits >> 29).to_ulong();

#define callT16Format(num) \
        do{ return T16Format##num(instr); } while(0)
#define badInstr() \
        die("Unknown instruction\n")

    switch (hdr)
    {
    case 0b000:
        if (!instr.matchPattern(28, 2, 0b11))
            callT16Format(1);
        else if (!instr.matchPattern(26, 1, 0b0))
            callT16Format(2);
        else
            callT16Format(3);
    case 0b001:
        callT16Format(4);
    case 0b010:
        if (instr.matchPattern(28, 3, 0b000))
            callT16Format(5);
        else if (instr.matchPattern(28, 3, 0b001))
            if (!instr.matchPattern(25, 2, 0b11))
                callT16Format(6);
            else
                callT16Format(7);
        else if (instr.matchPattern(28, 2, 0b01))
            callT16Format(8);
        else if (instr.matchPattern(28, 1, 0b1))
            callT16Format(9);
        else
            badInstr();
    case 0b011:
        callT16Format(10);
    case 0b100:
        if (instr.matchPattern(28, 1, 0b0))
            callT16Format(11);
        else
            callT16Format(12);
    case 0b101:
        if (instr.matchPattern(28, 1, 0b0))
            callT16Format(13);
        else
            callT16Format(14);
    case 0b110:
        if (instr.matchPattern(28, 1, 0b0))
            callT16Format(15);
        else if (!instr.matchPattern(27, 4, 0b1111))
            callT16Format(16);
        else // 17 is within 16
            callT16Format(18);
    case 0b111:
        if (instr.matchPattern(28, 2, 0b00))
            callT16Format(19);
        else
            badInstr();
    default:
        die("Unreachable switch default: % x\n", hdr);
    }
#undef callT16Format
#undef badInstr
}


#define DECL_T32_FUNC(num) \
    inline KrakenAction T32Format##num(const KrakenInstr &instr)
DECL_T32_FUNC(1)
{
    dbg("Data processing: imm including bitfield and saturate\n");
}

DECL_T32_FUNC(2)
{
    dbg("Branch misc ctrl\n");
}

DECL_T32_FUNC(3)
{
    dbg("Data processing: no imm\n");
}

DECL_T32_FUNC(4)
{
    dbg("Load store single; mem hint\n");
}

DECL_T32_FUNC(5)
{
    dbg("Load store; double and exclusive; table branch\n");
}

DECL_T32_FUNC(6)
{
    dbg("Load store multiple; RFE and SRS\n");
}

DECL_T32_FUNC(7)
{
    dbg("Coprocessor\n");
}
#undef DECL_T32_FUNC


inline KrakenAction decodeT32(const KrakenInstr &instr)
{
#define callT32Format(num) \
        do{ return T32Format##num(instr); } while(0)
#define badInstr() \
        die("Unknown instruction\n")
    if (instr.matchPattern(28, 2, 0b10))
        if (instr.matchPattern(15, 1, 0b0))
            callT32Format(1);
        else
            callT32Format(2);
    else if (instr.matchPattern(27, 3, 0b101))
        callT32Format(3);
    else if (instr.matchPattern(28, 4, 0b1100))
        callT32Format(4);
    else if (instr.matchPattern(28, 4, 0b0100))
        if (instr.matchPattern(21, 1, 0b1))
            callT32Format(5);
        else
            callT32Format(6);
    else if (instr.matchPattern(27, 4, 0b111))
        callT32Format(7);
    else
        badInstr();
#undef callT32Format
#undef badInstr
}

KrakenAction decode(const KrakenInstr &instr)
{
    dbg("Decoding %.4x (%s): %s\n",
        instr.rawBits,
        instr.isT32 ? "T32" : "T16",
        instr.toString().c_str());

    KrakenAction ka;

    if (instr.isT32)
        return decodeT32(instr);
    else
        return decodeT16(instr);
}

}