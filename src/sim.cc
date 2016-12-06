
#include "vixl/a64/simulator-a64.h"
#include "vixl/a64/debugger-a64.h"
#include "vixl/a64/macro-assembler-a64.h"
#include <vector>

#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

using namespace vixl;
using namespace std;

#define BUF_SIZE (4096)
#define __ masm->

void GenerateAbs(MacroAssembler* masm) {
    // int64_t abs(int64_t x)
    // Argument location:
    //   x -> x0

    // This example uses a conditional instruction (cneg) to compute the
    // absolute value of an integer.
    __ Cmp(x0, 0);
    __ Cneg(x0, x0, mi);
    __ Ret();
}

#define handle_error(msg) \
           do { perror(msg); exit(EXIT_FAILURE); } while (0)

void mapFile(string path, uint32_t* &ptr, size_t &fileLen)
{
    int fd = open(path.c_str(), O_RDONLY);
    if (fd == -1)
        handle_error("open");

    struct stat sb;
    if (fstat(fd, &sb) == -1)           /* To obtain file size */
        handle_error("fstat");

    fileLen = sb.st_size;
    ptr = (uint32_t*) mmap(NULL, fileLen, PROT_READ,
                           MAP_PRIVATE, fd, 0);

    if (ptr == MAP_FAILED)
        handle_error("mmap");

    const size_t nInsns = fileLen / 4;
    printf("File size: %d bytes, %d insns\n", fileLen, nInsns);

    // prog = vector<Instruction>(nInsns);
    // for (int i = 0; i < nInsns; i++)
    // {
    //     const uint32_t beBinary = *(addr + i);
    //     uint8_t *bytes = (uint8_t*) &beBinary;
    //     printf("[%d] %8x ", i, beBinary);
    //     // const uint32_t leBinary = bytes[3] | (bytes[2] << 8) | (bytes[1] << 16) | (bytes[0] << 24);
    //     // printf("%8x ", leBinary);

    //     // if ((i + 1) % 4 == 0)
    //     //     printf("\n");

    //     prog[i].SetInstructionBits(i);

    //     if (i > 0)
    //         printf(": 0x%08" PRIx32 " : 0x%08" PRIx32 "\n",
    //                prog[i].InstructionBits(), prog[i - 1].InstructionBits());
    // }

    // printf("-------------------------\n");
    // for (int i = 0; i < nInsns; i++)
    //     printf("[%d] : 0x%08" PRIx32 "\n", i,
    //            prog[i].InstructionBits());

    // munmap(addr, fileLen);
    // close(fd);

    // exit(1);
}

vector<uint32_t> getProgram(uint32_t* const &ptr, const size_t len)
{
    vector<uint32_t> prog = vector<uint32_t>(len / 4);
    for (int i = 0; i < len/4; i++)
    {
        uint8_t *bytes = (uint8_t*) (ptr + i);
        prog[i] = *(ptr + i); //bytes[3] | (bytes[2] << 8) | (bytes[1] << 16) | (bytes[0] << 24);
    }

    return prog;
}

int main(void) {
    // Create and initialize the assembler and the simulator.
    byte assm_buf[BUF_SIZE];
    MacroAssembler masm(assm_buf, BUF_SIZE);
    Decoder decoder;
    Simulator simulator(&decoder);

    uint32_t *progData;
    size_t fileLen;
    mapFile("bmarks/vadd.o", progData, fileLen);
    vector<uint32_t> program = getProgram(progData, fileLen);

    simulator.set_xreg(0, 0);
    simulator.RunFrom((Instruction*) &(program[13]));

    // Generate the code for the example function.
    Label abs;
    masm.Bind(&abs);
    GenerateAbs(&masm);
    masm.FinalizeCode();

    // Run the example function.
    int64_t input_value = -42;
    simulator.set_xreg(0, input_value);
    simulator.RunFrom(masm.GetLabelAddress<Instruction*>(&abs));
    printf("abs(%" PRId64 ") = %" PRId64 "\n", input_value, simulator.xreg(0));

    return 0;
}
