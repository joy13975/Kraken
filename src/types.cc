#include <elf.h>
#include <string.h>

#include "types.h"
#include "util.h"

using namespace std;

KrakenState::KrakenState(ifstream & binStream)
    : binSize(getBinSize(binStream)), totalMemSize(binSize + stackAndHeapSize),
      memory(initMemory(binStream)), entry(getEntryPoint()),
      textStart(getTextBoundary(false)), textEnd(getTextBoundary(true))
{
};

uintptr_t KrakenState::getPcOffset() const
{
    return (uintptr_t) subPointers(pc, memory);
};

byte * KrakenState::initMemory(ifstream & binStream)
{
    byte * mem = new byte[totalMemSize];

    binStream.seekg(0, ios::beg);
    if (!binStream.read((char*) mem, binSize))
        die("Could not load binary file into memory.\n");
    msg("Binary loaded: %d bytes\n", binSize);

    return mem;
}

size_t KrakenState::getBinSize(ifstream & binStream) const
{
    binStream.seekg(0, ios::end);
    size_t s = (size_t) binStream.tellg();
    binStream.seekg(0, ios::beg);
    return s;
}

hword * KrakenState::getEntryPoint() const
{
    const Elf32_Ehdr * hdr = (Elf32_Ehdr*) memory;

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
    checkField(hdr->e_ident[EI_CLASS], ELFCLASS32, "32-bit");
    checkField(hdr->e_ident[EI_DATA], ELFDATA2LSB, "little-endian");
    checkField(hdr->e_ident[EI_VERSION], EV_CURRENT, "version");
    checkField(hdr->e_machine, EM_ARM, "arm");
    if (hdr->e_type != ET_REL && hdr->e_type != ET_EXEC)
        die("ELF failure (%s): expected 0x%x or 0x%x but got 0x%x\n",
            "tpye", ET_REL, ET_EXEC, hdr->e_type);
#undef checkField

    // check Thumb entry address - should be odd number
    const hword *elfEntryPoint = (hword*) (uintptr_t)
                                 ((Elf32_Ehdr*) memory)->e_entry;
    if (((uintptr_t) elfEntryPoint) % 2 != 1)
        die("Entry point is not odd - this is not a Thumb binary.\n");
    msg("Program entry: 0x%x\n", elfEntryPoint);

    return (hword*) addPointers(
               addPointers(memory, elfEntryPoint),
               (void*) 1);
}

byte * KrakenState::getTextBoundary(bool end) const
{
    const Elf32_Ehdr * ehdr = (Elf32_Ehdr*) memory;
    Elf32_Shdr * shdr       = (Elf32_Shdr*) (memory + ehdr->e_shoff);
    Elf32_Shdr * sh_strtab  = &shdr[ehdr->e_shstrndx];
    const char *const sh_strtab_p = (char*) (memory + sh_strtab->sh_offset);

    for (int i = 0; i < ehdr->e_shnum; i++)
        if (0 == strcmp(sh_strtab_p + shdr[i].sh_name, ".text"))
            return (byte*) (end ?
                            (uintptr_t) (shdr[i].sh_addr + shdr[i].sh_size) :
                            (uintptr_t) shdr[i].sh_addr);

    die("Could not find .text section in the binary\n");
}


KrakenInstr::KrakenInstr(const byte *const _bytes)
    : isT32(checkT32(_bytes)), rawBits(getRawBits(_bytes))
{
}

bool KrakenInstr::matchPattern(const short offset,
                               const short bits,
                               const byte pattern) const
{
    const KrakenWord shifted = (rawBits << (KRAKEN_WORD_SIZE - offset - 1))
                               >> (KRAKEN_WORD_SIZE - offset - 1)
                               >> (offset - bits + 1);
    const KrakenWord mask = KrakenWord(pattern);
    // dbg("shifted(%.2d,%.2d): %s\n", offset, bits, shifted.to_string().c_str());
    // dbg("mask:           %s\n", mask.to_string().c_str());
    return shifted == mask;
}

string KrakenInstr::toString() const
{
    string s = rawBits.to_string();

    // space insertion black magic
    for (int i = 0; i < 8; i++)
        s.insert(4 * (i + 1) + i + (i > 3 ? 1 : 0),
                 i == 3 ? 2 : 1, ' ');

    if (!isT32)
        s = s.substr(0, s.length() / 2);

    return s;
}

bool KrakenInstr::checkT32(const byte *const _bytes)
{
    return (_bytes[1] >> 5) == 0b111 &&
           ((_bytes[1] >> 3) & 0b11) != 0b00;
}

KrakenWord KrakenInstr::getRawBits(const byte *const bytes)
{
    KrakenWord bits = KrakenWord(*((hword*) bytes)) << (sizeof(hword) * 8);

    if (isT32)
        bits |= KrakenWord(*(((hword*) bytes) + 1));

    return bits;
}