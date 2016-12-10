#include <sstream>

#include "bit_util.h"

using namespace std;
string leBitStr(const void *const anyData, const size_t nBytes)
{
    const Byte *const data = (const Byte * const) anyData;

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

string leHexStr(const void *anyData, const size_t nBytes)
{
    const Byte *const data = (const Byte * const) anyData;

    stringstream ss;
    for (int i = nBytes - 1; i > -1; i--)
    {
        ss << hex << data[i];
        // if (i % 2 == 0)
        //     ss << " ";
    }

    return ss.str();
}