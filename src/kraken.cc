#include <stdio.h>
#include <vector>

#include "types.h"
#include "util.h"
#include "proc.h"

using namespace std;
Kraken::Options options;

DECL_ARG_CALLBACK(setInput) { options.input = arg_in; }
DECL_ARG_CALLBACK(setDataOutput) { options.dataOutput = arg_in; }
DECL_ARG_CALLBACK(setStackOutput) { options.stackOutput = arg_in; }
DECL_ARG_CALLBACK(setLogLevel) { set_log_level((Log_Level) parse_long(arg_in)); }
DECL_ARG_CALLBACK(helpAndExit);
DECL_ARG_CALLBACK(enableInteractiveMode) { options.interactive = true; }
DECL_ARG_CALLBACK(addBreakpoint) { options.bpoints.push_back(strtoul(arg_in, 0, 16)); }
DECL_ARG_CALLBACK(enablePipelining) { options.pipelined = true; }
DECL_ARG_CALLBACK(enableBrandhPrediction) {
    if (arg_in[0] == 'n')
        options.bpMode = Kraken::NoneMode;
    else if (arg_in[0] == 's')
        options.bpMode = Kraken::StaticMode;
    else if (arg_in[0] == 'd')
        options.bpMode = Kraken::DynamicMode;
    else
    {
        err("Use either \'s\' for static or \'d\' more dynamic branch prediction modes\n");
        die("Invalid argument for branch prediction mode: \"%s\"\n", arg_in);
    }
}

const argument_bundle argbv[] = {
    // necessary argument
    {"-i", "--input <file>", "Set input binary", true, setInput},
    // optional argument
    {"-h", "--help", "Print this help text and exit", false, helpAndExit},
    {"-lg", "--loglevel <0-4>", "Set log level", true, setLogLevel},
    {"-do", "--dataout <file>", "Set data section dump file", true, setDataOutput},
    {"-so", "--stackout <file>", "Set stack dump file", true, setStackOutput},
    {"-im", "--interactivemode", "Enable interactive mode", false, enableInteractiveMode},
    {"-b", "--breakat <hex addr>", "Set breakpoint at address", true, addBreakpoint},
    // processor features
    {   "-pl",
        "--pipeline",
        "Enable pipelining mode",
        false,
        enablePipelining
    },
    {   "-bp",
        "--branchpredict <n/s/d>",
        "Enable static branch prediction; n=none, s=static, d=dynamic",
        true,
        enableBrandhPrediction
    },
};
#define ARG_BUND_SIZE (sizeof(argbv) / sizeof(argbv[0]))

DECL_ARG_CALLBACK(helpAndExit)
{
    raw("Kraken Processor Simulator\n");
    raw("Usage: ./kraken [INPUT] [OPTIONS]\n");

    print_arg_title("INPUT:");
    print_arg_bundles(argbv, 1);
    print_arg_title("OPTIONS:");
    print_arg_bundles(argbv + 1, 6);
    print_arg_title("FEATURES:");
    print_arg_bundles(argbv + 7, ARG_BUND_SIZE - 1);

    exit(1);
}


DECL_ARG_IN_FAIL_CALLBACK(argParseFail)
{
    printf("Argument parsing failed on string: \"%s\"\n", arg_in);
    helpAndExit("");
    exit(1);
}

void checkOptions()
{
    if (options.input == "")
    {
        err("No input executable given. Hint: use -i <file>\n");
        exit(1);
    }
}

int main(int argc, const char *argv[])
{
    parse_args(argc, argv, ARG_BUND_SIZE, argbv, argParseFail);

    checkOptions();

    msg("Using input binary \"%s\"\n", options.input.c_str());

    // start simulation
    Kraken::Proc(options).startSimulation();

    return 0;
}