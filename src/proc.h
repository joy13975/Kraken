#ifndef _PROC_H_
#define _PROC_H_

#include <string>

#include "bit_util.h"

using namespace std;
class KrakenProc
{
public:
    class State
    {
    public:
        State(ifstream & binStream);

        virtual ~State()
        {
            delete memory;
        };

        const size_t stackAndHeapSize = 4096;

        const size_t binSize;
        const size_t totalMemSize;
        byte *const memory;
        hword *const entry;
        const size_t textSize;

        // special purpose registers
        hword *pc;

        // general purpose registers

        uintptr_t getPCOffset() const;

    private:
        byte * initMemory(ifstream & binStream);
        size_t getBinSize(ifstream & binStream) const;
        hword * getEntryPoint() const;
        size_t  getTextSize() const;
    };

    KrakenProc(const string &inFile);
    virtual ~KrakenProc()
    {
        delete state;
    };

    void startSimulation();

private:
    State *state;

    void    loadBinary(const string & inFile);
    void    resetStateRegs();
    bool    isPCSensible();
};

#endif /* include guard */