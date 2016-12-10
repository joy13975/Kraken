#ifndef _UTIL_H_
#define _UTIL_H_

#include <string>
#include <bitset>
#include <cstddef>

#include <stdint.h>

namespace Kraken
{

#define WORD_WIDTH_BITS 32
typedef uint8_t Byte;
typedef uint16_t HWord;
typedef uint32_t Word;

template<typename T>
inline T addPointers(const void *p1, const void *p2)
{
    return reinterpret_cast<T>((ptrdiff_t) p1 + (ptrdiff_t) p2);
}

template<typename T>
inline T subPointers(const void *p1, const void *p2)
{
    return reinterpret_cast<T>((ptrdiff_t) p1 - (ptrdiff_t) p2);
}

std::string leBitStr(const void *anyData, const size_t nBytes);
std::string leHexStr(const void *anyData, const size_t nBytes);

} // namespace Kraken

#endif /* include guard */