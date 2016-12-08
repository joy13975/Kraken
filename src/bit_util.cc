#include "bit_util.h"

string bitsToStr(const void *anyData, const size_t nBytes)
{
    byte* data = (byte*) anyData;

    stringstream ss;
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