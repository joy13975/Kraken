#include <fstream>
#include <stdint.h>
#include <elf.h>
#include <string.h>

#include "proc.h"
#include "util.h"
#include "bit_util.h"
#include "decoder.h"
#include "fetcher.h"
#include "enactor.h"

KrakenProc::State::State(ifstream & binStream)
    : binSize(getBinSize(binStream)), totalMemSize(binSize + stackAndHeapSize),
      memory(initMemory(binStream)), entry(getEntryPoint()), textSize(getTextSize())
{
};

uintptr_t KrakenProc::State::getPCOffset() const
{
    return (uintptr_t) subPointers(pc, memory);
};

byte * KrakenProc::State::initMemory(ifstream & binStream)
{
    byte * mem = new byte[totalMemSize];

    binStream.seekg(0, ios::beg);
    if (!binStream.read((char*) mem, binSize))
        die("Could not load binary file into memory.\n");
    msg("Binary loaded: %d bytes\n", binSize);

    return mem;
}

size_t KrakenProc::State::getBinSize(ifstream & binStream) const
{
    binStream.seekg(0, ios::end);
    size_t s = (size_t) binStream.tellg();
    binStream.seekg(0, ios::beg);
    return s;
}

hword * KrakenProc::State::getEntryPoint() const
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

size_t KrakenProc::State::getTextSize() const
{
    const Elf32_Ehdr * ehdr = (Elf32_Ehdr*) memory;
    Elf32_Shdr * shdr       = (Elf32_Shdr*) (memory + ehdr->e_shoff);
    Elf32_Shdr * sh_strtab  = &shdr[ehdr->e_shstrndx];
    const char *const sh_strtab_p = (char*) (memory + sh_strtab->sh_offset);

    for (int i = 0; i < ehdr->e_shnum; i++)
        if (0 == strcmp(sh_strtab_p + shdr[i].sh_name, ".text"))
            return shdr[i].sh_size;

    die("Could not find .text section in the binary\n");
}

KrakenProc::KrakenProc(const string & inFile)
{
    loadBinary(inFile);
}

void KrakenProc::startSimulation()
{
    msg("Entering binary at %p (offset: %p/%p)\n",
        state->pc, subPointers(state->entry, state->memory), state->textSize);
    resetStateRegs();

    while (isPCSensible())
    {
        const Fetcher::Instr instr  = Fetcher::fetch(state);
        Enactor::Action action      = Decoder::decode(instr);
        Scribe::Scripture script    = Enactor::enact(action, state);
        Scribe::write(script, state);
    }

    msg("Program has exited\n");
    wrn("Todo: stats and reg status (ret code?)\n");
}

// Private functions

void KrakenProc::loadBinary(const string & inFile)
{
    ifstream binStream(inFile, ios::binary);
    state = new State(binStream);
    binStream.close();
}

void KrakenProc::resetStateRegs()
{
    state->pc = state->entry;
}

bool KrakenProc::isPCSensible()
{
    // add 2 to compensate the starting odd address
    uintptr_t fromEntry = (uintptr_t) subPointers(state->pc, state->entry) + 2;
    return fromEntry >= 0 && fromEntry < state->textSize;
}