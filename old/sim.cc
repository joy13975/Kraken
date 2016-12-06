//C headers
#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include "util.h"

//CPP headers
#include <cstdlib>
#include <vector>
#include "JProcDefs.hh"
#include "JProcessor.hh"
#include "JAssembler.hh"
#include "JMachineCode.hh"

char *jasmFile                     = NULL;
bool testJasm                      = false;
bool pipelineEnabled               = false;
double clockFreq                   = DEFAULT_CLOCK_FREQ;
const argument_format af_asm       = {"-a", "--asm",            1, "Specify input JAssembly file"};
const argument_format af_jasm      = {"-ja", "--jasm",          0, "Print JAssembly output"};
const argument_format af_help      = {"-h", "--help",           0, "Print this help message, then exit"};
const argument_format af_pipeline  = {"-p", "--pipeline",       0, "Turn on pipelining - default is off"};
const argument_format af_freq      = {"-f", "--frequency",      1, "Set clock frequency in hertz (0=manual)"};
const argument_format af_loglv     = {"-l", "--loglevel",       1, "Set log level"};

void print_help_and_exit()
{
    raw("JProcessor Simulator\n");
    raw("Usage: ./sim [INPUT] [OPTIONS]\n");
    set_leading_spaces(8);
    raw("INPUT: \n");
    print_help_arguement(af_asm);
    raw("OPTIONS:\n");
    print_help_arguement(af_help);
    print_help_arguement(af_freq);
    print_help_arguement(af_pipeline);
    print_help_arguement(af_loglv);
    print_help_arguement(af_jasm);
    set_leading_spaces(0);

    exit(1);
}

void parseArguments(int argc, char *argv[])
{
    init_args(argc, argv);
    bool test_jasm = false;
    while (have_next_arg())
    {
        if (next_arg_matches(af_asm))
        {
            jasmFile = next_arg();

            FILE * fp;
            if (!(fp = fopen(jasmFile, "r")))
            {
                err("JAssembly file \"%s\" could not be opened (%s).\n",
                    jasmFile, get_error_string());
                print_help_and_exit();
            }
        }
        else if (next_arg_matches(af_jasm))
        {
            testJasm = true;
        }
        else if (next_arg_matches(af_help))
        {
            print_help_and_exit();
        }
        else if (next_arg_matches(af_pipeline))
        {
            pipelineEnabled = true;
        }
        else if (next_arg_matches(af_freq))
        {
            clockFreq = parse_long(next_arg());
        }
        else if (next_arg_matches(af_loglv))
        {
            set_log_level(static_cast<Log_Level>(parse_long(next_arg())));
        }
        else
        {
            err("Unknown argument: %s\n", next_arg());
            print_help_and_exit();
        }
    }

    if (!jasmFile)
    {
        err("Jasm file input must be spacified\n");
        print_help_and_exit();
    }
}

int main(int argc, char *argv[])
{
    parseArguments(argc, argv);


    JAssembler jasmr(jasmFile);
    if (testJasm)
        jasmr.testClass();

    //parse program from ASCII JAssembly into MachineCode classes
    JProgram program = jasmr.getProgram();

    JProcessor jproc = JProcessor(clockFreq, program);
    raw("Running unit tests... \n");
    jproc.testClass();
    raw("Tests passed\n");
    jproc.run();

    return EXIT_SUCCESS;
}