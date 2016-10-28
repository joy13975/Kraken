
#############################################################
##                                                         ##
##       Joy's (Simple Scalar) Processor Simulator         ##
##                                                         ##
#############################################################

###Description:
    This processor is a simple implementation of the classic
    5-stage RISC processor. The stages are:
        1 Fetch
        2 Decode
        3 Execute
        4 Memory Access
        5 Register Write Back

    There is no pipeline nor out-of-order execution in the
    current implementation. Hence, each instruction takes
    exactly 5 cycles to process. The instruction set is
    explained in accompanying slides.

    Hint: You can view the markdown symbolic link of this file
    at README.md - it's nicer.

--------------------------------------------------------------
###To compile:
    Simply do "make". The output should be identical to
    Appendix [1]. It requires a minimum support of C++11,
    and compiles on both Linux and **MacOSX**.

    Compile Note: Lab machines *should* have g++ 4.8.5
    installed, which has support for C++11. For example,
    the node with hostname "Paris" compiles this simulator
    successfully.

--------------------------------------------------------------
###To execute:
    [1]
    To list arguments accepted by the program, do:

    "./sim"  or "./sim -h"

--------------------------------------------------------------
    [2]
    To watch the processor advance cycle by cycle at a
    default frequency of 1Hz, do:

    "./sim -a tests/counting50.jasm"

    This is just a program that counts from 0 to 50. The output
    should be identical to  Appendix [2], which covers only
    two of the instructions.

--------------------------------------------------------------
    [3]
    To step through the cycles by hand (by hitting the Return
    key), do:

    "./sim -a tests/counting50.jasm -f 0"

    Where "-f 0" means no frequency; manual mode.

--------------------------------------------------------------
    [4]
    To simulate fast execution, increase the frequency:

    "./sim -a tests/counting50.jasm -f 10000"

    When it terminates, it should show an output identical to
    Appendix [3].

--------------------------------------------------------------
    [5]
    To run the vector add example:

    "./sim -a tests/vadd.jasm -f 10000"

    The output in Appendix [4] shows some variables at the
    beginning of the Data Memory. After that, there are
    a[32], b[32], and c[32] arrays, with c being the sum of
    a and b elements.

--------------------------------------------------------------
    [6]
    To print the JAssembly output, do:

    "./sim -a tests/vadd.jasm -ja -f 0"

    The 0 frequency allows you to pause at the beginning of the
    execution.

#############################################################
##                       Appendices                        ##
#############################################################

####[1] Compilation output:
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

####[2] Execution output of countin50.jasm at 1Hz:
     it025971:JProcessor$ ./sim -a tests/counting50.jasm
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
     ___________C(   7)____________/------------C(   8)-----------
       STAGE_INTALU: Skipping non-IntALU instruction: XUOP_ST
     ___________C(   8)____________/------------C(   9)-----------
       STAGE_MEMWTR: Storing R0 (0) into DMEM[0] (0)

####[3] Termination output for counting50.jasm:
    [WRN] HALT received - clock stopped
     DMEM[0 ] = 50
     DMEM[1 ] = 50

####[4]Termination output for vadd.jasm:
    [WRN] HALT received - clock stopped
     DMEM[0 ] = 0
     DMEM[1 ] = 32
     DMEM[2 ] = 5
     DMEM[3 ] = 37
     DMEM[4 ] = 69
     DMEM[5 ] = -1337
     DMEM[6 ] = -1337
     DMEM[7 ] = -1337
     DMEM[8 ] = -1337
     DMEM[9 ] = -1337
     DMEM[10] = -1337
     DMEM[11] = -1337
     DMEM[12] = -1337
     DMEM[13] = -1337
     DMEM[14] = -1337
     DMEM[15] = -1337
     DMEM[16] = -1337
     DMEM[17] = -1337
     DMEM[18] = -1337
     DMEM[19] = -1337
     DMEM[20] = -1337
     DMEM[21] = -1337
     DMEM[22] = -1337
     DMEM[23] = -1337
     DMEM[24] = -1337
     DMEM[25] = -1337
     DMEM[26] = -1337
     DMEM[27] = -1337
     DMEM[28] = -1337
     DMEM[29] = -1337
     DMEM[30] = -1337
     DMEM[31] = -1337
     DMEM[32] = -1337
     DMEM[33] = -1337
     DMEM[34] = -1337
     DMEM[35] = -1337
     DMEM[36] = -1337
     DMEM[37] = -1337
     DMEM[38] = -1337
     DMEM[39] = -1337
     DMEM[40] = -1337
     DMEM[41] = -1337
     DMEM[42] = -1337
     DMEM[43] = -1337
     DMEM[44] = -1337
     DMEM[45] = -1337
     DMEM[46] = -1337
     DMEM[47] = -1337
     DMEM[48] = -1337
     DMEM[49] = -1337
     DMEM[50] = -1337
     DMEM[51] = -1337
     DMEM[52] = -1337
     DMEM[53] = -1337
     DMEM[54] = -1337
     DMEM[55] = -1337
     DMEM[56] = -1337
     DMEM[57] = -1337
     DMEM[58] = -1337
     DMEM[59] = -1337
     DMEM[60] = -1337
     DMEM[61] = -1337
     DMEM[62] = -1337
     DMEM[63] = -1337
     DMEM[64] = -1337
     DMEM[65] = -1337
     DMEM[66] = -1337
     DMEM[67] = -1337
     DMEM[68] = -1337
     DMEM[69] = -2674
     DMEM[70] = -2674
     DMEM[71] = -2674
     DMEM[72] = -2674
     DMEM[73] = -2674
     DMEM[74] = -2674
     DMEM[75] = -2674
     DMEM[76] = -2674
     DMEM[77] = -2674
     DMEM[78] = -2674
     DMEM[79] = -2674
     DMEM[80] = -2674
     DMEM[81] = -2674
     DMEM[82] = -2674
     DMEM[83] = -2674
     DMEM[84] = -2674
     DMEM[85] = -2674
     DMEM[86] = -2674
     DMEM[87] = -2674
     DMEM[88] = -2674
     DMEM[89] = -2674
     DMEM[90] = -2674
     DMEM[91] = -2674
     DMEM[92] = -2674
     DMEM[93] = -2674
     DMEM[94] = -2674
     DMEM[95] = -2674
     DMEM[96] = -2674
     DMEM[97] = -2674
     DMEM[98] = -2674
     DMEM[99] = -2674
     DMEM[100] = -2674