#include <elf.h>
#include <string.h>

#include "types.h"
#include "util.h"

using namespace std;

KrakenState::KrakenState(ifstream & binStream)
    : progInfo(inspectProgram(binStream))
{};

uintptr_t KrakenState::getPcOffset() const
{
    return (uintptr_t) subPointers(pc, memory);
};

KrakenState::ProgramInfo KrakenState::inspectProgram(ifstream & binStream)
{
    ProgramInfo pi;

    pi.binSize              = getBinSize(binStream);
    pi.totalMemSize         = pi.binSize + pi.stackAndHeapSize;
    memory                  = initMemory(binStream);
    Word * elfEntryPoint    = getEntryPoint();
    pi.entry                = (Word*) addPointers(memory, elfEntryPoint);
    pi.textStart    = getTextBoundary(false);
    pi.textEnd      = getTextBoundary(true);

    return pi;
}

size_t KrakenState::getBinSize(ifstream & binStream) const
{
    binStream.seekg(0, ios::end);
    size_t s = (size_t) binStream.tellg();
    binStream.seekg(0, ios::beg);
    return s;
}

Word * KrakenState::initMemory(ifstream & binStream) const
{
    Word * mem = new Word[progInfo.totalMemSize];

    binStream.seekg(0, ios::beg);
    if (!binStream.read((char*) mem, progInfo.binSize))
        die("Could not load binary file into memory.\n");
    msg("Binary loaded: %d bytes\n", progInfo.binSize);

    return mem;
}

Word * KrakenState::getEntryPoint() const
{
    const Elf64_Ehdr * hdr = (Elf64_Ehdr*) memory;

    // do some elf checks before getting entry
#define checkField(field, expectedVal, name) \
    if(field != expectedVal) \
        die("ELF failure (%s): expected 0x%x but got 0x%x\n", \
    name, expectedVal, field)

    // check elf magic
    checkField(hdr->e_ident[EI_MAG0], ELFMAG0, "Magic-0");
    checkField(hdr->e_ident[EI_MAG1], ELFMAG1, "Magic-1");
    checkField(hdr->e_ident[EI_MAG2], ELFMAG2, "Magic-2");
    checkField(hdr->e_ident[EI_MAG3], ELFMAG3, "Magic-3");

    // check elf info
    checkField(hdr->e_ident[EI_CLASS], ELFCLASS64, "64-bit");
    checkField(hdr->e_ident[EI_DATA], ELFDATA2LSB, "little-endian");
    checkField(hdr->e_ident[EI_VERSION], EV_CURRENT, "version");
    checkField(hdr->e_machine, EM_AARCH64, "A64");
    if (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
        die("ELF failure (%s): expected 0x%x or 0x%x but got 0x%x\n",
            "tpye", ET_REL, ET_EXEC, hdr->e_type);
#undef checkField

    const Word *elfEntryPoint = (Word*) (uintptr_t)
                                ((Elf64_Ehdr*) memory)->e_entry;

    msg("Program entry: 0x%x\n", elfEntryPoint);

    return (Word*)elfEntryPoint;
}

Word * KrakenState::getTextBoundary(bool end) const
{
    const Elf64_Ehdr * ehdr = (Elf64_Ehdr*) memory;
    Elf64_Shdr * shdr       = (Elf64_Shdr*) addPointers(memory,
                              (void*) ehdr->e_shoff);
    Elf64_Shdr * sh_strtab  = &shdr[ehdr->e_shstrndx];
    const char *const sh_strtab_p = (char*) addPointers(memory,
                                    (void*)sh_strtab->sh_offset);

    for (int i = 0; i < ehdr->e_shnum; i++)
    {
        const char * sname = (char*) sh_strtab_p + shdr[i].sh_name;
        // dbg("Section %d/%d (%s,%p,%p)\n",
        //     i, ehdr->e_shnum, sname, shdr[i].sh_offset, shdr[i].sh_size);
        if (0 == strcmp(sname, ".text"))
            return (Word*) (end ?
                                (uintptr_t) (shdr[i].sh_offset + shdr[i].sh_size) :
                                (uintptr_t) shdr[i].sh_offset);
    }

    die("Could not find .text section in the binary (sections=%d)\n",
        ehdr->e_shnum);
}


KrakenInstr::KrakenInstr(const Word *const _word)
    : word(__builtin_bswap32(*_word))
{
}

bool KrakenInstr::matchPattern(const short offset,
                               const short bits,
                               const Byte pattern) const
{
    const Word shifted = (word << (KRAKEN_WORD_BITS - offset - 1))
                         >> (KRAKEN_WORD_BITS - offset - 1)
                         >> (offset - bits + 1);
    // dbg("shifted(%.2d,%.2d): %s\n", offset, bits, shifted.to_string().c_str());
    // dbg("mask:           %s\n", mask.to_string().c_str());
    return shifted == (Word) pattern;
}

string KrakenInstr::toString() const
{
    string s = leBitStr(&word, sizeof(Word));
    return s;
}