#ifndef _REGISTER_HH_
#define _REGISTER_HH_

//CPP headers
#include <cstdlib>
#include <cstring>
#include <vector>
#include "JProcDefs.hh"
#include "UtilCpp.hh"
#include "Clock.hh"

using Inports   = std::vector<Byte *>;
using Outports  = std::vector<const Byte *>;

class Register;
using Registers = std::vector<Register>;

class Register : public Testable, public Clock::Clockable
{
public:
    const int byteLength;

    Register(Clock &clock, int byteLength);
    Register(Register const& o);
    Register& operator=(Register const& o);
    ~Register();

    void testClass();
    void onClockRising();
    void onClockHigh() {};
    void onClockFalling() {};
    void onClockLow() {};

    Byte *getInport();
    void readData(Byte * buffer);
    const Byte *getOutport();
    void writeData(const Byte * data);
    void clear();

    static Outports getOutports(Registers& regs);
    static Registers makeRegisters(Clock& clock, const int& n, const int& len);

private:
    Byte * in_data   = NULL;
    Byte * out_data  = NULL;
    Register() = delete;
};

#endif /* include guard */