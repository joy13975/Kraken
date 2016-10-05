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
    register_unit *reg_file;    // register file
    register_unit *inst;        // instruction register
    register_unit *prog_cntr;   // program counter
    register_unit *mem_addr;    // memory address register
    register_unit *mem_data;    // memory data register
    register_unit *stage_flag;  // stage flag register
} registers = {0};

void queue_component_logic();
void queue_register_propagation();
void clock_wait_half_period();
void clock_advance();
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
 * The main thread simulates the reset signal and the clock unit
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
                    queue_register_propagation();
                }
                else
                {
                    // falling edge: do nothing
                }

                #pragma omp taskwait

                // clock flips state
                clock_advance();

                #pragma omp task /* clock */
                {
                    clock_wait_half_period();
                }

                // update components (concurrently) if clock is high
                if (clock_state)
                    queue_component_logic();
            }
        }
    }
}

void queue_component_logic()
{
    #pragma omp task /* stage counter unit */
    {
        set_register(registers.stage_flag, (get_register(registers.stage_flag) + 1) % NUM_STAGES);
        dbg("stage counter unit: set stage flag to %d\n", get_register(registers.stage_flag));
    }

    #pragma omp task /* fetch stage */
    {
        if (get_register(registers.stage_flag) == FETCH_STAGE_FLAG)
        {
            const WORD fetch_addr      = get_register(registers.prog_cntr);
            const WORD fetched_value   = *((WORD*) & (imem[fetch_addr]));
            prf("fetch stage: pc = %d, imem[pc] = %d\n", fetch_addr, fetched_value);
            set_register(registers.inst, fetched_value);
        }
    }

    #pragma omp task /* decode stage */
    {
        if (get_register(registers.stage_flag) == DECODE_STAGE_FLAG)
        {

        }
    }

    #pragma omp task /* execute stage */
    {
        if (get_register(registers.stage_flag) == EXECUTE_STAGE_FLAG)
        {

        }
    }

    #pragma omp task /* write-back stage */
    {
        if (get_register(registers.stage_flag) == WRITEBACK_STAGE_FLAG)
        {
            if (1)
            {
                const WORD current_pc = get_register(registers.prog_cntr);
                dbg("write-back stage: pc = %d, incremeting\n", current_pc);
                set_register(registers.prog_cntr, current_pc + 1);
            }
        }
    }
}

void queue_register_propagation()
{
    #pragma omp task /* register file */
    {
        prf("task: propagate register file\n");
        propagate_registers(registers.reg_file, reg_file_size);
    }

    #pragma omp task /* inst reg */
    {
        prf("task: propagate instruction register\n");
        propagate_register(registers.inst);
    }

    #pragma omp task /* pc reg */
    {
        prf("task: propagate program counter\n");
        propagate_register(registers.prog_cntr);
    }

    #pragma omp task /* mem addr reg */
    {
        prf("task: propagate memory address register\n");
        propagate_register(registers.mem_addr);
    }

    #pragma omp task /* mem data reg */
    {
        prf("task: propagate memory data register\n");
        propagate_register(registers.mem_data);
    }

    #pragma omp task /* mem data reg */
    {
        prf("task: propagate stage flag register\n");
        propagate_register(registers.stage_flag);
    }
}

void clock_wait_half_period()
{
    const double clock_half_period_us = 1e6 * (1.0f / clock_freq_hz) / 2.0f;
    dbg("clock_wait_half_period()[%d] - freq: %.0f hz, half period: %.0f us, clock_state: %d, half periods elapsed: %ld\n",
        omp_get_thread_num(), clock_freq_hz, clock_half_period_us, clock_state, clock_half_periods_elapsed);
    nsleep(clock_half_period_us * 1e3);
}

void clock_advance()
{
    clock_state ^= 0x1U;
    clock_half_periods_elapsed++;
}

void initialise()
{
    imem                    = calloc(1, imem_size);
    dmem                    = calloc(1, dmem_size);
    registers.reg_file      = create_registers(reg_file_size);
    registers.inst           = create_register();
    registers.prog_cntr      = create_register();
    registers.mem_addr       = create_register();
    registers.mem_data       = create_register();
    registers.stage_flag     = create_register();
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