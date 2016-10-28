
#############################################################
##                                                         ##
##       Joy's (Simple Scalar) Processor Simulator         ##
##                                                         ##
#############################################################

Description:
    This process is a simple scalar implementation of the
    5-stage RISC processor. The stages are:
        1 Fetch
        2 Decode
        3 Memory Read     (LOAD)
        4 Arithmatics     (ALU)
        5 Memory Write    (STORE)

    There is no pipeline nor out-of-order execution in the
    current implementation. Hence, each instruction takes
    exactly 5 cycles to process. The instruction set is
    explained in accompanying slides.

--------------------------------------------------------------
To compile:
    Simply do "make". The output should be identical to
    Appendix [1]. It requires a minimum support of C++11,
    and compiles on both Linux and **MacOSX**.

    Compile Note: Lab machines *should* have g++ 4.8.5
    installed, which has support for C++11. For example,
    the node with hostname "Paris" compiles this simulator
    successfully.

--------------------------------------------------------------
To execute:
    [1]
    To list arguments accepted by the program, do:

    "./sim"  or "./sim -h"

--------------------------------------------------------------
    [2]
    To watch the processor advance cycle by cycle at a
    default frequency of 1Hz, do:

    "./sim -a tests/counting.jasm"

    This is just a program counting from 0 to 500. The output
    should be identical to  Appendix [2]. Due to the many
    stages per instruction and high counting number, this can
    take a long time to finish on Lab machines.

--------------------------------------------------------------
    [3]
    To step through the cycles by hand (by hitting the Return
    key), do:

    "./sim -a tests/counting.jasm -f 0"

    Where "-f 0" means no frequency; manual mode.

--------------------------------------------------------------
    [4]
    To make the program finish executing faster automatically,
    do:


#############################################################
                        Appendices
#############################################################
[1] Example compilation output:
    it025971:JProcessor$ make
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/util.o -c util.c
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/UtilCpp.o -c UtilCpp.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/JAssembler.o -c JAssembler.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/Register.o -c Register.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/Clock.o -c Clock.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/ProcStage.o -c ProcStage.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/Fetcher.o -c Fetcher.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/XOut.o -c XOut.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/Decoder.o -c Decoder.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/DMemer.o -c DMemer.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/XInOut.o -c XInOut.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/RegFiler.o -c RegFiler.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/MemReader.o -c MemReader.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/IntALU.o -c IntALU.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/MemWriter.o -c MemWriter.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/JProcessor.o -c JProcessor.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp  -o .hidden/sim.o -c sim.cc
    g++  -MMD -O3 -std=c++11 -g -fopenmp   .hidden/util.o .hidden/UtilCpp.o .hidden/JAssembler.o .hidden/Register.o .hidden/Clock.o .hidden/ProcStage.o .hidden/Fetcher.o .hidden/XOut.o .hidden/Decoder.o .hidden/DMemer.o .hidden/XInOut.o .hidden/RegFiler.o .hidden/MemReader.o .hidden/IntALU.o .hidden/MemWriter.o .hidden/JProcessor.o .hidden/sim.o  -o sim

[2] Example execution output:
     it025971:JProcessor$ ./sim -a tests/counting.jasm
     +----------------------------------------------------------+
     |                   JProcessor Simulator                   |
     +----------------------------------------------------------+
     Running unit tests...
    [WRN] Clock unit test is incomplete
    [WRN] Fetcher has no unit test
    [WRN] Decoder has no unit test
    [WRN] MemReader has no unit test
    [WRN] IntALU has no unit test
    [WRN] MemWriter has no unit test
     Tests passed
     Starting JProcessor
     ___________C(  -1)____________/------------C(   0)-----------
        STAGE_FETCH: IMEM[0]: SUB      { 0  0  0 } { 0 }
     ___________C(   0)____________/------------C(   1)-----------
       STAGE_DECODE: XUOP_SUB      XUCTRL_NONE     OPRFMT_RRR
     ___________C(   1)____________/------------C(   2)-----------
       STAGE_MEMRDR: Skipping non-load instruction: XUOP_SUB
     ___________C(   2)____________/------------C(   3)-----------
       STAGE_INTALU: R0(0) <- R0(0) - R0(0) = 0
     ___________C(   3)____________/------------C(   4)-----------
       STAGE_MEMWTR: Skipping non-store instruction: XUOP_SUB
     ___________C(   4)____________/------------C(   5)-----------
        STAGE_FETCH: IMEM[1]: STI      { 0  0  0 } { 0 }
     ___________C(   5)____________/------------C(   6)-----------
       STAGE_DECODE: XUOP_ST       XUCTRL_IMDV     OPRFMT_IR
     ___________C(   6)____________/------------C(   7)-----------
       STAGE_MEMRDR: Skipping non-load instruction: XUOP_ST