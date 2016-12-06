#ifndef _CLOCK_HH_
#define _CLOCK_HH_

//CPP header
#include <vector>
#include "UtilCpp.hh"
#include "JProcDefs.hh"

#define FOREACH_ClockState(MACRO) \
    MACRO(CLOCK_LOW) \
    MACRO(CLOCK_RISING) \
    MACRO(CLOCK_HIGH) \
    MACRO(CLOCK_FALLING)
DECL_ENUM_AND_STRING(ClockState, FOREACH_ClockState);

class Clock : public Testable
{
public:
    class Clockable
    {
        friend class Clock;
    public:
        Clockable(Clock &clock) :
            myClock(&clock)
        {
            clock.addClockable(this);
        }
        virtual ~Clockable();
        virtual void onClockRising() {};
        virtual void onClockHigh() {};
        virtual void onClockFalling() {};
        virtual void onClockLow() {};

        void checkClocked();
    protected:
        Clock *myClock;
    };

    const double frequency, periodNS;
    Clock(const double& frequency);
    ~Clock();
    void testClass();
    void addClockable(Clockable *c);
    void removeClockable(Clockable const *c);
    int getClockableIndex();
    void autoTick();
    void tick();
    void pause();

private:
    volatile bool shouldStop = true;
    ClockState myState = CLOCK_LOW;
    int myCycles = 0;
    std::vector<Clockable*> myClockables;


    Clock() = delete;
    void advanceState();
};

#endif /* include guard */