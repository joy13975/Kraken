#ifndef _ARM_UTIL_H_
#define _ARM_UTIL_H_

#include <stdint.h>
#include <sstream>

typedef uint8_t byte;
typedef uint32_t word;
typedef uint16_t hword;

#define UpperByte(instr) (((byte *) &instr)[1])

using namespace std;

inline void *addPointers(const void *p1, const void*p2)
{
    return (void*) ((uintptr_t) p1 + (uintptr_t) p2);
}

inline void *subPointers(const void *p1, const void*p2)
{
    return (void*) ((uintptr_t) p1 - (uintptr_t) p2);
}

string bitsToStr(const void *anyData, const size_t nBytes);

#endif /* include guard */