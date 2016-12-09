#ifndef _ENACTOR_H_
#define _ENACTOR_H_

#include "util.h"
#include "types.h"
#include "enactor.h"
#include "proc.h"

namespace Enactor
{

KrakenScripture enact(const KrakenAction &action,
                      const KrakenState *const state);

} // namespace Enactor

#endif /* include guard */