#include "decoder.h"

//masks
#define t32Mask         0b111

//opcodes
#define ocUncondBr      0x11100

namespace Decoder
{

bool is32bitInstr(const byte &ub)
{
    return (ub >> 3) != ocUncondBr &&
           ((ub >> 5) & t32Mask) == t32Mask;
}

Enactor::Action decode(const Fetcher::Instr &instr)
{
    dbg("Decoding %.2hx%.2hx : %s\n", instr.bytes[1], instr.bytes[0], bitsToStr(&instr, 2).c_str());

    if (instr.is32bits)
        dbg("         %.2hx%.2hx : %s\n", instr.bytes[3], instr.bytes[2], bitsToStr(((hword *) &instr) + 1, 2).c_str());

    wrn("Todo: decode()\n");
    return Enactor::Action();
}

}