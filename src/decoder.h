#ifndef _DECODER_H_
#define _DECODER_H_

#include "bit_util.h"
#include "proc.h"
#include "fetcher.h"
#include "enactor.h"

namespace Decoder
{

bool is32bitInstr(const byte &ub);

Enactor::Action decode(const Fetcher::Instr &instr);

} // namespace Decoder

#endif /* include guard */