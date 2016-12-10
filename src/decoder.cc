#include "decoder.h"
#include "util.h"
#include "bit_util.h"

namespace Decoder
{

KrakenAction decode(const KrakenInstr &instr)
{
    dbg("Decoding %s : %s\n",
        leHexStr(&(instr.word), sizeof(Word)).c_str(),
        instr.toString().c_str());

    KrakenAction ka;
}

}