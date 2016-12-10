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

    typedef struct ProgramInfo
    {
        const size_t stackAndHeapSize = 4096;
        size_t binSize;
        size_t totalMemSize;
        Word * entry;
        Word * textStart;
        Word * textEnd;
    } ProgramInfo;

    const ProgramInfo progInfo;

    //memory
    Word * memory;

    // special purpose registers
    Word * pc;

    // general purpose registers

    uintptr_t getPcOffset() const;

private:
    ProgramInfo inspectProgram(std::ifstream & binStream);
    size_t getBinSize(std::ifstream & binStream) const;
    Word * initMemory(std::ifstream & binStream) const;
    Word * getEntryPoint() const;
    Word * getTextBoundary(bool end) const;
};

class KrakenInstr
{
public:
    KrakenInstr(const Word *const _word);
    virtual ~KrakenInstr() {};

    bool matchPattern(const short offset,
                      const short bits,
                      const Byte mask) const;

    const Word word;
    std::string toString() const;
private:
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