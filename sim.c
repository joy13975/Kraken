#include <stdlib.h>
#include <stdio.h>

#include "omp.h"

#include "util.h"
#include "config.h"
#include "register_unit.h"

double clock_freq_hz            = DEFAULT_CLOCK_FREQ;
int clock_state                 = 0;
long clock_half_periods_elapsed = 0;

size_t imem_size                = DEFAULT_IMEM_SIZE;
size_t dmem_size                = DEFAULT_DMEM_SIZE;
size_t reg_file_size            = DEFAULT_REG_FILE_SIZE;

typedef uint8_t byte;
byte *dmem;                     // data memory
byte *imem;                     // instruction memory

struct
{
    register_unit *reg_file;          // register file
    register_unit inst;        // instruction register
    register_unit prog_cntr;        // program counter
    register_unit mem_addr;        // memory address register
    register_unit mem_data;        // memory data register
    register_unit stage_flag;        // stage flag register
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
    #pragma omp parallel
    {
        while (1)
        {
            // before clock changes state
            #pragma omp single
            {
                if (!clock_state)
                {
                    // rising edge: propagate data from inpute buses to input buses
                    #pragma omp task /* register file */
                    {
                        prf("task: propagate register file\n");
                        propagate_registers(registers.reg_file, reg_file_size);
                    }

                    #pragma omp task /* inst reg */
                    {
                        prf("task: propagate instruction register\n");
                        propagate_register(&(registers.inst));
                    }

                    #pragma omp task /* pc reg */
                    {
                        prf("task: propagate program counter\n");
                        propagate_register(&(registers.prog_cntr));
                    }

                    #pragma omp task /* mem addr reg */
                    {
                        prf("task: propagate memory address register\n");
                        propagate_register(&(registers.mem_addr));
                    }

                    #pragma omp task /* mem data reg */
                    {
                        prf("task: propagate memory data register\n");
                        propagate_register(&(registers.mem_data));
                    }
                }
                else
                {
                    // falling edge: do nothing
                }

                #pragma omp taskwait

                // clock changes state
                clock_state ^= 0x1U;
                clock_half_periods_elapsed++;

                // update components concurrently
                #pragma omp task /* clock */
                {
                    clock_wait_half_period();
                }

                #pragma omp task /* inst. cache */
                {
                    // fetch
                    set_register(&(registers.inst), imem[registers.prog_cntr.output]);
                }

                #pragma omp task /* decoder */
                {
                }
            }
        }
    }
}

void clock_wait_half_period()
{
    const double clock_half_period_us = 1e6 * (1.0f / clock_freq_hz) / 2.0f;
    dbg("clock_wait_half_period()[%d] - freq: %.0f hz, half period: %.0f us, clock_state: %d, half periods elapsed: %ld\n",
        omp_get_thread_num(), clock_freq_hz, clock_half_period_us, clock_state, clock_half_periods_elapsed);
    nsleep(clock_half_period_us * 1e3);
}

void initialise()
{
    imem = calloc(1, imem_size);
    dmem = calloc(1, dmem_size);
    registers.reg_file = calloc(reg_file_size, sizeof(register_unit));
}

void finalise()
{
    free(imem);
    free(dmem);
    free(registers.reg_file);
}

void parse_arguments()
{
}