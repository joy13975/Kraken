#include <stdlib.h>
#include <stdio.h>

#include "omp.h"

#include "util.h"
#include "config.h"
#include "register_unit.h"

double clock_freq_hz            = DEFAULT_CLOCK_FREQ;
int clock_state                 = 0;
size_t imem_size                = DEFAULT_IMEM_SIZE;
size_t dmem_size                = DEFAULT_DMEM_SIZE;
size_t reg_file_size            = DEFAULT_REG_FILE_SIZE;

typedef uint8_t byte;
byte *dmem;                     // data memory
byte *imem;                     // instruction memory

struct
{
    register_unit *rf;          // register file
    register_unit ir;           // instruction register
    register_unit pc;           // program counter
    register_unit mar;          // memory address register
    register_unit mdr;          // memory data register
} registers = {0};

void clock_wait_half_period();
void do_simulation();
void initialise();
void finalise();
void parse_arguments();

int main(int argc, char *argv[])
{
    parse_arguments();
    initialise();
    do_simulation();
    finalise();
    return 0;
}

/*
 * The main thread simulates the reset signal, the clock unit, and all "cache"
 * registers that store inputs to any arbitrary unit as clock goes rising
 * edge.
 */
void do_simulation()
{
    long half_periods = 0;
    #pragma omp parallel
    {
        // There seems to be a bug where the program hangs if
        // some threads enter omp sections region before all
        // threads have been spawned. Barrier after omp parallel
        // solves this.
        #pragma omp barrier

        while (1)
        {
            // before clock changes state
            if (!clock_state)
            {
                // rising edge: propagate data from inpute buses to input buses
                #pragma omp sections
                {
                    #pragma omp section /* register file */
                    {
                        propagate_registers(registers.rf, reg_file_size);
                    }

                    #pragma omp section /* inst reg */
                    {
                        propagate_register(&(registers.ir));
                    }

                    #pragma omp section /* pc reg */
                    {
                        propagate_register(&(registers.pc));
                    }

                    #pragma omp section /* mem addr reg */
                    {
                        propagate_register(&(registers.mar));
                    }

                    #pragma omp section /* mem data reg */
                    {
                        propagate_register(&(registers.mdr));
                    }
                }
            }
            else
            {
                // falling edge: do nothing
            }

            #pragma omp single
            {
                // clock changes state
                clock_state ^= 0x1U;
                half_periods++;
            }

            // update components concurrently
            #pragma omp sections
            {
                #pragma omp section /* clock */
                {
                    clock_wait_half_period();
                }

                #pragma omp section /* inst. cache */
                {
                    // fetch
                    set_register(&(registers.ir), imem[registers.pc.output]);
                }

                #pragma omp section /* decoder */
                {
                }
            }

            // all components settle and wait for clock (half) period to end
            exit(1);
        }
    }
}

void clock_wait_half_period()
{
    const double clock_half_period_us = 1e6 * (1.0f / clock_freq_hz) / 2.0f;
    dbg("clock_wait_half_period() - freq: %.0f hz, half period: %.0f us\n",
        clock_freq_hz, clock_half_period_us);
    fflush(stdout);
    nsleep(clock_half_period_us * 1e3);
}

void initialise()
{
    imem = calloc(1, imem_size);
    dmem = calloc(1, dmem_size);
    registers.rf = calloc(1, reg_file_size * sizeof(register_unit));
}

void finalise()
{
    free(imem);
    free(dmem);
    free(registers.rf);
}

void parse_arguments()
{
}