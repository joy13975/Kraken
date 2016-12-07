#include <stdio.h>
#include <string>
#include <vector>

#include "util.h"
#include "krasm.h"

using namespace std;
string inputFile = "";

DECL_ARG_CALLBACK(setInputFile) { inputFile = arg_in; }
DECL_ARG_CALLBACK(setLogLevel) { set_log_level((Log_Level) parse_long(arg_in)); }
DECL_ARG_CALLBACK(helpAndExit);

const argument_bundle argbv[] = {
    {"-i", "--input", "Set input file", true, setInputFile},
    {"-h", "--help", "Print this help text and exit", false, helpAndExit},
    {"-lg", "--loglevel", "Set log level", true, setLogLevel}
};
#define ARG_BUND_SIZE (sizeof(argbv) / sizeof(argbv[0]))

DECL_ARG_CALLBACK(helpAndExit)
{
    raw("Kraken Processor Simulator\n");
    raw("Usage: ./kraken [INPUT] [OPTIONS]\n");

    print_arg_title("INPUT:");
    print_arg_bundles(argbv, 1);
    print_arg_title("OPTIONS:");
    print_arg_bundles(argbv + 1, ARG_BUND_SIZE - 1);

    exit(1);
}


DECL_ARG_IN_FAIL_CALLBACK(argParseFail)
{
    printf("Argument parsing failed on string: \"%s\"\n", arg_in);
    exit(1);
}

void checkOptions()
{
    if (inputFile == "")
    {
        err("No input ARM assembly given. Hint: use -i <file>\n");
        exit(1);
    }
}

int main(int argc, const char *argv[])
{
    parse_args(argc, argv, ARG_BUND_SIZE, argbv, argParseFail);

    checkOptions();

    // load ARM assembly into Krasm objects
    vector<Krasm> prog = Krasm::parseFromFile(inputFile);

    // start simulation
    //KrakenProc(prog).startSimulation();

    return 0;
}