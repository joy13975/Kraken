#ifndef _TYPES_H_
#define _TYPES_H_

#include <string>
#include <vector>
#include <fstream>
#include <cstddef>

#include <elf.h>
#include <string.h>

#include "bit_util.h"
#include "util.h"

namespace Kraken
{

typedef struct
{
    std::string inputFile           = "";
    bool interactive                = false;
    std::vector<uintptr_t> bpoints;
} Options;

class ProgramInfo
{
public:
    const size_t            stackAndHeapSize = 8 * 1024;
    const size_t            binSize_;
    const Word *const       binary_;
    const Elf64_Ehdr *const elf_;
    const Word *const       entry_;
    const Word *const       textStart_;
    const Word *const       textEnd_;

    ProgramInfo(std::ifstream &&binStream);
    virtual ~ProgramInfo() {
        delete binary_;
    };

    static size_t getBinSize(std::ifstream &binStream);
private:
    template<typename T>
    T * getBinary(std::ifstream &binStream)
    {
        T * bin = reinterpret_cast<T*>(new Byte[binSize_]);
        binStream.seekg(0, std::ios::beg);

        if (!binStream.read((char*) bin, binSize_))
            die("Could not load binary into memory.\n");

        return bin;
    }

    template<typename T>
    T getEntryPoint() const
    {
        // do some elf checks before getting entry
#define checkField(field, expectedVal, name) \
    if(field != expectedVal) \
        die("ELF failure (%s): expected 0x%x but got 0x%x\n", \
    name, expectedVal, field)

        // check elf magic
        checkField(elf_->e_ident[EI_MAG0], ELFMAG0, "Magic-0");

        checkField(elf_->e_ident[EI_MAG1], ELFMAG1, "Magic-1");
        checkField(elf_->e_ident[EI_MAG2], ELFMAG2, "Magic-2");
        checkField(elf_->e_ident[EI_MAG3], ELFMAG3, "Magic-3");

        // check elf info
        checkField(elf_->e_ident[EI_CLASS], ELFCLASS64, "64-bit");
        checkField(elf_->e_ident[EI_DATA], ELFDATA2LSB, "little-endian");
        checkField(elf_->e_ident[EI_VERSION], EV_CURRENT, "version");
        checkField(elf_->e_machine, EM_AARCH64, "A64");
        if (elf_->e_type != ET_REL && elf_->e_type != ET_EXEC)
            die("ELF failure (%s): expected 0x%x or 0x%x but got 0x%x\n",
                "tpye", ET_REL, ET_EXEC, elf_->e_type);
#undef checkField

        return reinterpret_cast<T>(elf_->e_entry);
    }

    template<typename T>
    T getTextBoundary(bool end) const
    {
        const Elf64_Shdr *const shdr =
            addPointers<Elf64_Shdr*>(binary_, (void*) elf_->e_shoff);

        const Elf64_Shdr *const sh_strtab =
            &shdr[elf_->e_shstrndx];

        const char *const sh_strtab_p =
            addPointers<char*>(binary_, (void*)sh_strtab->sh_offset);

        for (int i = 0; i < elf_->e_shnum; i++)
        {
            const char * sname = (char*) sh_strtab_p + shdr[i].sh_name;
            if (0 == strcmp(sname, ".text"))
                return reinterpret_cast<T>(
                           end ?
                           shdr[i].sh_offset + shdr[i].sh_size
                           :
                           shdr[i].sh_offset
                       );
        }

        die("Could not find .text section in the binary (sections=%d)\n",
            elf_->e_shnum);
    }
};

class State
{
public:
    State(const ProgramInfo &pi);
    virtual ~State()
    {
        delete baseAddr_;
    };

    //memory
    const Word * baseAddr_;

    // special purpose registers
    const Word * pc_;

    // general purpose registers

    ptrdiff_t getPcOffset() const;

    template<typename T>
    T * memAt(const T * offset) const
    {
        return addPointers<T*>(baseAddr_, offset);
    }

private:
    template<typename T>
    T * initMemory(const ProgramInfo &pi) const
    {
        T * mem = new T[pi.binSize_ + pi.stackAndHeapSize];

        memcpy(mem, pi.binary_, pi.binSize_);

        return mem;
    }
};

typedef void (*Action)();

class Scripture
{
public:
    Scripture() {};
    virtual ~Scripture() {};

private:
};

} // namespace

#endif /* include guard */