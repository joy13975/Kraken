#ifndef _CONFIG_H
#define _CONFIG_H

#include <stdint.h>
#include <stddef.h>

#define DEFAULT_CLOCK_FREQ      1.0f        // Hertz

#define DEFAULT_IMEM_SIZE       1024        // 1 KBytes
#define DEFAULT_DMEM_SIZE       1024        // 1 KBytes
#define WORD                    uint32_t    // Each register is 32 Bytes
#define DEFAULT_REG_FILE_SIZE   16          // 16 Registers

#define NUM_STAGES              4           // Fetch Decode Execute Write-Back
#define FETCH_STAGE_FLAG        0x0
#define DECODE_STAGE_FLAG       0x1
#define EXECUTE_STAGE_FLAG      0x2
#define WRITEBACK_STAGE_FLAG    0x3

#endif