#ifndef _clock_component_h
#define _clock_component_h

struct
{
    int state;
    long long ticks;
    double current_timestamp_us;
} clock_component;

void clock_tick();
void clock_reset();
void clock_wait();
double get_timestamp_us();

#endif /* include guard */