#ifndef _ENACTOR_H_
#define _ENACTOR_H_

#include "util.h"
#include "enactor.h"
#include "scribe.h"
#include "proc.h"

namespace Enactor
{

typedef void (*Action)();
Scribe::Scripture enact(const Action &action, const KrakenProc::State *const state);

} // namespace Enactor

#endif /* include guard */