#ifndef _SCRIBE_H_
#define _SCRIBE_H_

#include "util.h"
#include "proc.h"

namespace Scribe
{

class Scripture
{
public:
    Scripture() {};
    virtual ~Scripture() {};

private:
};

void write(Scripture script, KrakenProc::State *const state);

} // namespace Scribe

#endif /* include guard */