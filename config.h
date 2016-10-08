#ifndef _CONFIG_H
#define _CONFIG_H

#include <stdint.h>
#include <stddef.h>

#define DEFAULT_CLOCK_FREQ      1.0f        // Hertz

#define DEFAULT_DMEM_SIZE       1024        // 1K WORDs
#define WORD                    uint32_t    // Each register is 32 Bytes
#define BYTE                    uint8_t     // Byte used for generic signals
#define DEFAULT_REG_FILE_SIZE   32          // 32 Registers

#define NUM_STAGES              4           // Fetch Decode Execute Write-Back
#define FETCH_STAGE_FLAG        (0x1U << 0)
#define DECODE_STAGE_FLAG       (0x1U << 1)
#define EXECUTE_STAGE_FLAG      (0x1U << 2)
#define WRITEBACK_STAGE_FLAG    (0x1U << 3)


#endif