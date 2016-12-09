#include <sstream>

#include "bit_util.h"

using namespace std;
string leBitsToStr(const void *const anyData, const size_t nBytes)
{
    const byte *const data = (const byte *const) anyData;

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