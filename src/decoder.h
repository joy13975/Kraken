#ifndef _DECODER_H_
#define _DECODER_H_

#include "bit_util.h"
#include "proc.h"
#include "types.h"

namespace Decoder
{

KrakenAction decode(const KrakenInstr &instr);

} // namespace Decoder

#endif /* include guard */