#include <sstream>

#include "bit_util.h"

namespace Kraken
{

std::string leBitStr(const void *const anyData, const size_t nBytes)
{
    const Byte *const data = (const Byte * const) anyData;

    std::stringstream ss;
    for (int i = nBytes - 1; i > -1; i--)
    {
        for (int j = 7; j > -1; j--)
        {
            ss << ((data[i] >> j) & 1);

            if (j % 4 == 0)
                ss << " ";
        }
    }

    return ss.str();
}

#include <stdio.h>
std::string leHexStr(const void *anyData, const size_t nBytes)
{
    const Byte *const data = (const Byte * const) anyData;

    std::stringstream ss;
    for (int i = nBytes - 1; i > -1; i--)
        ss << std::hex << (int) data[i] << " ";

    return ss.str();
}

} // namespace Kraken
