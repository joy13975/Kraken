//C headers
#include <stdio.h>

//CPP headers
#include <algorithm>
#include "Clock.hh"

void Clock::Clockable::checkClocked()
{
    std::vector<Clockable*> v = myClock->myClockables;

    bool found = false;
    for (int i = 0; i < v.size(); i++)
        if (v[i] == this)
            found = true;

    if (!found)
        die("Not clocked!!! Clockable %p, Clock %p\n",
            this, myClock);
}

Clock::Clockable::~Clockable()
{
    myClock->removeClockable(this);
}

void Clock::advanceState()
{
    if (myState == CLOCK_LOW || myState == CLOCK_HIGH)
    {
        if (frequency == 0 && myState == CLOCK_LOW)
        {
            fflush(stdout);
            raw("Hit enter to advance clock (cycle #%d)...\n",
                myCycles);
            fflush(stdout);
            while (getchar() != '\n') {}
        }
        else
        {
            //delay half a clock cycle
            nsleep(periodNS / 2.0f);
        }
    }
    myState = (ClockState) ((myState + 1) % (CLOCK_FALLING + 1));
}

void Clock::pause()
{
    shouldStop = true;
}

void Clock::tick()
{
    #pragma omp parallel
    {
        #pragma omp single nowait
        {
            dbg("Current clock state: %s\n", ClockState_String[myState]);

            if (myState == CLOCK_RISING)
                raw("_________________________/--------------------------\n");

            for (std::vector<Clockable*>::iterator i = myClockables.begin(); i != myClockables.end(); ++i)
                #pragma omp task
            {
                Clockable *c = *i;
                switch (myState)
                {
                case CLOCK_LOW:
                    c->onClockLow();
                    break;
                case CLOCK_RISING:
                    c->onClockRising();
                    break;
                case CLOCK_HIGH:
                    c->onClockHigh();
                    break;
                case CLOCK_FALLING:
                    c->onClockFalling();
                    break;
                default:
                    die("Unknown ClockState: %s\n", ClockState_String[myState]);
                    break;
                }
            }
        }

        //wait for all committing tasks to finish
        #pragma omp taskwait

        #pragma omp barrier
        #pragma omp single
        {
            if (myState == CLOCK_FALLING)
                myCycles++;
            advanceState();
        }
    }
}

void Clock::autoTick()
{
    shouldStop = false;

    while (!shouldStop)
        tick();
}

void Clock::removeClockable(Clockable const *c)
{
    myClockables.erase(std::remove(
                           myClockables.begin(),
                           myClockables.end(),
                           c),
                       myClockables.end());
}

int Clock::getClockableIndex()
{
    return myClockables.size();
}

void Clock::addClockable(Clockable *c)
{
    myClockables.push_back(c);
}

void Clock::testClass()
{
    // die("Unimplemented\n");
    if (frequency != 1e9 / periodNS)
        die("Clock period calculation test failed: %.2f instead of %.2f",
            periodNS, 1e9 * (1.0f / frequency));

    wrn("Clock unit test is incomplete\n");
}

Clock::~Clock()
{
}

Clock::Clock(const double& frequency) :
    frequency(frequency),
    periodNS(1e9 * (1.0f / frequency))
{
    if (frequency < 0)
        die("Tried to make a clock of negative frequency %.4f\n", frequency);
}