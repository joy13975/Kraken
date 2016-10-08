#include "clock.h"
#include "util.h"

double clock_freq_hz             = DEFAULT_CLOCK_FREQ;
BYTE clock_state                 = 0;
long clock_half_periods_elapsed  = 0;

void clock_delay()
{
    const double clock_half_period_us = 1e6 * (1.0f / clock_freq_hz) / 2.0f;
    dbg("clock_delay() - freq: %.0f hz, half period: %.0f us, clock_state: %d, half periods elapsed: %ld\n",
        clock_freq_hz, clock_half_period_us, clock_state, clock_half_periods_elapsed);
    nsleep(clock_half_period_us * 1e3);
}

void clock_advance()
{
    clock_state ^= 0x1U;
    clock_half_periods_elapsed++;
}

BYTE get_clock_state()
{
    return clock_state;
}