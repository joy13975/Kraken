#include "components.h"

#include "logger.h"
#include <unistd.h>
#include <sys/time.h>

extern debug_level_t debug_level;
#define clock_freq_hz 10000.0f
#define clock_freq_hz_max_mac 1000000.0f
const double clock_period_us = 1e6/clock_freq_hz;

void clock_wait()
{
    double us_diff = get_timestamp_us() - clock_component.current_timestamp_us;
    double us_left = clock_period_us - us_diff;

    dbg(DBG_ALL, "clock_wait() - freq: %.0f MHz, period: %.0f us, elapsed: %.0f us, wait: %.0f us\n",
        clock_freq_hz, clock_period_us, us_diff, us_left);

    if (us_left > 0)
        usleep(us_left);
    else
        dbg(DBG_WARN, "clock_wait() - clock lagging; consider turning off prints...\n");
}

void clock_reset()
{
    dbg(DBG_ALL, "clock_reset()\n");
    clock_component.state = 0;
    clock_component.ticks = 0;
    clock_component.current_timestamp_us = 0;
}

void clock_tick()
{
    clock_component.state = (clock_component.ticks++) % 2;
    clock_component.current_timestamp_us = get_timestamp_us();
    dbg(DBG_ALL, "Clock tick #%lld state %d\n",
        clock_component.ticks, clock_component.state);
}

double get_timestamp_us() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_usec + tv.tv_sec * 1e6;
}