#ifndef _SCRIPTURE_H_
#define _SCRIPTURE_H_

#include "util.h"

namespace Kraken
{

#define FOREACH_SINKTYPE(V) \
    V(NZCV) \
    V(FPCR) \
    V(PC) \
    V(Reg) \
    V(VReg) \
    V(Mem)

GEN_ENUM_AND_STRING(SinkType, SinkTypeString, FOREACH_SINKTYPE);

#define FOREACH_SPTMODE(V) \
    V(Read) \
    V(Write)

GEN_ENUM_AND_STRING(SPTMode, SPTModeString, FOREACH_SPTMODE);

class Scripture
{
public:

    Scripture() {};

    Scripture(const SinkType & _type,
              const uint64_t & _addr,
              const SPTMode & _mode,
              const size_t & _szBytes)
        : type(_type),
          addr(_addr),
          mode(_mode),
          szBytes(_szBytes),
          value(_szBytes ? new uint8_t[_szBytes] : 0)
    {}

    Scripture(const Scripture & other)
        : Scripture(other.type,
                    other.addr,
                    other.mode,
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

    SinkType    type;
    uint64_t    addr;
    SPTMode     mode;
    size_t      szBytes;
    uint8_t *   value;
    bool        ready;
private:
};

} // namespace Kraken

#endif /* include guard */