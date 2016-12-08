#ifndef _FETCHER_H_
#define _FETCHER_H_

#include "bit_util.h"
#include "proc.h"

namespace Fetcher
{

typedef struct
{
    const byte *const bytes;
    const bool is32bits;
} Instr;

const Instr fetch(KrakenProc::State *const state);

} // namespace Fetcher

#endif /* include guard */