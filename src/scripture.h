#ifndef _SCRIPTURE_H_
#define _SCRIPTURE_H_

#include "util.h"

namespace Kraken
{

#define FOREACH_DESTTYPE(V) \
    V(NZCV) \
    V(FPCR) \
    V(PC) \
    V(Reg) \
    V(VReg) \
    V(Mem)

GEN_ENUM_AND_STRING(DestType, DestTypeString, FOREACH_DESTTYPE);

class Scripture
{
public:

    Scripture() {};

    Scripture(const DestType & _type,
              const uint64_t & _addr,
              const size_t & _szBytes)
        : type(_type),
          addr(_addr),
          szBytes(_szBytes),
          value(new uint8_t[_szBytes])
    {}


    Scripture(const Scripture & other)
        : Scripture(other.type,
                    other.addr,
                    other.szBytes)
    {
        fill(other.value);
    }

    Scripture& operator=(const Scripture & other)
    {
        if (this == &other)
            return *this;

        type = other.type;
        addr = other.addr;

        if (szBytes)
            delete value;

        szBytes = other.szBytes;
        fill(other.value);
    }

    virtual ~Scripture() {
        if (szBytes)
            delete value;
    }

    void fill(const uint8_t *val)
    {
        memcpy(value, val, szBytes);
    }

    DestType type;
    uint64_t addr;
    size_t szBytes;
    uint8_t * value;
private:
};

} // namespace Kraken

#endif /* include guard */