#ifndef _ARM_UTIL_H_
#define _ARM_UTIL_H_

#include <string>
#include <bitset>

#include <stdint.h>

#define KRAKEN_WORD_BITS 32
typedef uint8_t Byte;
typedef uint16_t HWord;
typedef uint32_t Word;
// typedef std::bitset<KRAKEN_WORD_BITS> KrakenWord;

#define UpperByte(instr) (((Byte *) &instr)[1])

inline void *addPointers(const void *p1, const void*p2)
{
    return (void*) ((uintptr_t) p1 + (uintptr_t) p2);
}

inline void *subPointers(const void *p1, const void*p2)
{
    return (void*) ((uintptr_t) p1 - (uintptr_t) p2);
}

std::string leBitStr(const void *anyData, const size_t nBytes);
std::string leHexStr(const void *anyData, const size_t nBytes);

inline Byte revByte(Byte b) {
    b = (b & 0xF0) >> 4 | (b & 0x0F) << 4;
    b = (b & 0xCC) >> 2 | (b & 0x33) << 2;
    b = (b & 0xAA) >> 1 | (b & 0x55) << 1;
    return b;
}

#endif /* include guard */