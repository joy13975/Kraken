#include "logger.h"
#include "components.h"

debug_level_t debug_level = DBG_ALL;

void parse_arguments();
void reset_components();
void do_simulation();

int main(int argc, char *argv[])
{
    parse_arguments();
    reset_components();

    //simulation loop
    while (1)
    {
        do_simulation();
    }

    return 0;
}

void do_simulation()
{
    clock_tick();

    //simulate clock signal being propagated to components
    update_components(clock_component.state);

    //clock shall wait for its period to end before ticking again
    clock_wait();
}

void parse_arguments()
{
    //set default parameters

    //TODO: read command line arguments
}

void reset_components()
{
    clock_reset();
}