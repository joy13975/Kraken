#ifndef _JPROC_DEFS_HH_
#define _JPROC_DEFS_HH_

//C Headers
#include <stdint.h>
#include <stddef.h>

//CPP Headers
#include <vector>
#include "UtilCpp.hh"

#ifndef DEFAULT_CLOCK_FREQ
#define DEFAULT_CLOCK_FREQ          1.0f
#endif /* def guard for DEFAULT_CLOCK_FREQ */

#ifndef Word
#define Word                        int32_t
#endif /* def guard for WORD */

using Memory = std::vector<Word>;

#ifndef Byte
#define Byte                        int8_t
#endif /* def guard for BYTE */

#define WordLength                  (sizeof(Word)/sizeof(Byte))

#ifndef DEFAULT_REG_FILE_SIZE
#define DEFAULT_REG_FILE_SIZE       32
#endif /* def guard for DEFAULT_REG_FILE_SIZE */

#ifndef DEFAULT_DMEM_SIZE
#define DEFAULT_DMEM_SIZE           4096
#endif /* def guard for DEFAULT_DMEM_SIZE */

#ifndef N_EXEC_UNITS
#define N_EXEC_UNITS                1
#endif /* def guard for N_EXEC_UNITS */

#define FOREACH_StageID(MACRO) \
    MACRO(STAGE_FETCH) \
    MACRO(STAGE_DECODE) \
    MACRO(STAGE_EXEC) \
    MACRO(STAGE_MEMACC) \
    MACRO(STAGE_WTBACK)
DECL_ENUM_AND_STRING(StageID, FOREACH_StageID);

#ifndef N_STAGES
#define N_STAGES                    (STAGE_WTBACK + 1)
#endif /* def guard for N_STAGES */

#ifndef PIPELINED
#define PIPELINED                   0
#endif /* def guard for PIPELINED */

#endif /* include guard */