#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

#include "util.h"
#include "config.h"
#include "state.h"
#include "clock.h"

void propagate_signals();
void do_simulation();
void parse_program(WORD **program, size_t *num_words);
void initialise();
void finalise();
void print_help();
void parse_arguments(int argc, char *argv[]);

char *asm_file                  = NULL;
bool pipeline_enabled           = false;
const char *arg_asm[2]          = {"-a", "--asm"};
const char *arg_help[2]         = {"-h", "--help"};
const char *arg_pipeline[2]     = {"-p", "--pipeline"};

int main(int argc, char *argv[])
{
    parse_arguments(argc, argv);
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
    while (1)
    {
        // before clock changes state
        if (!get_clock_state())
        {
            // rising edge: propagate data from inpute buses to input buses
            propagate_state();
        }
        else
        {
            // falling edge: do nothing
        }

        // clock flips state
        clock_advance();

        // update components (concurrently) if clock is high
        if (get_clock_state())
        {
            propagate_signals();
        }

        clock_delay();
    }
}

void propagate_signals()
{
    advance_stage();

    const WORD stage_flag = get_stage_flag();

    if (pipeline_enabled || stage_flag & FETCH_STAGE_FLAG)
    {
        dbg("Fetch stage\n");
        fetch_instruction();
        dbg("\n");
    }

    if (pipeline_enabled || stage_flag & DECODE_STAGE_FLAG)
    {
        dbg("Decode stage\n");

        dbg("\n");
    }

    if (pipeline_enabled || stage_flag & EXECUTE_STAGE_FLAG)
    {
        dbg("Execute stage\n");

        dbg("\n");
    }

    if (pipeline_enabled || stage_flag & WRITEBACK_STAGE_FLAG)
    {
        dbg("Write back stage\n");
        write_back();
        dbg("\n");
    }
}

void parse_program(WORD **program, size_t *num_words)
{
    if (!asm_file)
    {
        err("No assembly file specified.\n");
        print_help();
        exit(1);
    }

    FILE *fp = fopen(asm_file, "r");
    if (!fp)
    {
        err("Assembly file could not be opened (%s).\n",
            get_error_string());
        print_help();
        exit(1);
    }
}

void initialise()
{
    WORD *program;
    size_t num_words;
    parse_program(&program, &num_words);
    create_state(program, num_words);
}

void finalise()
{
    destroy_state();
}

void print_help()
{
    raw("sim: JProcessor Simulator\n");
    raw("Usage: ./sim [INPUT] [OPTIONS]\n");
    raw("   INPUT: \n");
    raw("       %s, %s <FILE>\n", arg_asm[0], arg_asm[1]);
    raw("           Specify input assembly file\n");
    raw("   OPTIONS: \n");
    raw("       % s, % s\n", arg_help[0], arg_help[1]);
    raw("           Print this help message, then exit\n");
    raw("       % s, % s\n", arg_pipeline[0], arg_pipeline[1]);
    raw("           Turn on pipelining - default is off\n");
}

void parse_arguments(int argc, char *argv[])
{
    if (argc < 3)
    {
        print_help();
        exit(1);
    }

    for (int i = 1; i < argc; i++)
    {
        if (check_arg(argv[i], arg_asm))
        {
            asm_file = argv[++i];
        }

        if (check_arg(argv[i], arg_help))
        {
            print_help();
        }

        if (check_arg(argv[i], arg_pipeline))
        {
            pipeline_enabled = true;
        }
    }
}