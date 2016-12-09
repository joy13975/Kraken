#ifndef _KRAKEN_TYPES_H_
#define _KRAKEN_TYPES_H_

#include <string>
#include <vector>
#include <fstream>

#include "bit_util.h"

typedef struct
{
    std::string inputFile           = "";
    bool interactive                = false;
    std::vector<uintptr_t> bpoints;
} KrakenOptions;

class KrakenState
{
public:
    KrakenState(std::ifstream & binStream);

    virtual ~KrakenState()
    {
        delete memory;
    };

    const size_t stackAndHeapSize = 4096;

    const size_t        binSize;
    const size_t        totalMemSize;
    byte *const         memory;
    hword *const        entry;
    const byte *const   textStart;
    const byte *const   textEnd;

    // special purpose registers
    hword *pc;

    // general purpose registers

    uintptr_t getPcOffset() const;

private:
    byte * initMemory(std::ifstream & binStream);
    size_t getBinSize(std::ifstream & binStream) const;
    hword * getEntryPoint() const;
    byte * getTextBoundary(bool end) const;
};

class KrakenInstr
{
public:
    KrakenInstr(const byte *const _bytes);
    virtual ~KrakenInstr() {};

    bool matchPattern(const short offset,
                      const short bits,
                      const byte mask) const;

    const bool isT32;
    const KrakenWord rawBits;
    std::string toString() const;
private:
    bool checkT32(const byte *const _bytes);
    KrakenWord getRawBits(const byte *const _bytes);
};

typedef void (*KrakenAction)();

class KrakenScripture
{
public:
    KrakenScripture() {};
    virtual ~KrakenScripture() {};

private:
};

#endif /* include guard */