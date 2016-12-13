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

#include "vixl/a64/logic-regs-a64.h"

namespace Kraken
{

typedef struct
{
    std::string inputFile           = "";
    std::string outputFile          = "dump.bin";
    bool interactive                = false;
    bool pipelined                  = false;
    short n_superscalar             = 1;
    std::vector<uintptr_t> bpoints;
} Options;

#define ADRP_ALIGNMMENT 4096

class ProgramInfo
{
public:
    const size_t            stackAndHeapSize = 0; // logic takes care
    const Word *const       image_;
    const Elf64_Ehdr        elf_;
    const size_t            imgSize_;
    const Word *const       entry_;
    const Word *const       textStart_;
    const Word *const       textEnd_;
    const Word *const       dataStart_;
    const Word *const       dataEnd_;

    ProgramInfo(std::ifstream &&binStream);
    virtual ~ProgramInfo() { delete imgBaseRoot_; }

    static size_t getImgSize(std::ifstream &binStream);
    template<typename T>
    T offset(const void* ptr) const
    { return subPointers<T>(ptr, image_); }
private:
    Elf64_Ehdr elfPriv_;
    size_t imgSizePriv_;
    Byte * imgBaseRoot_;

    template<typename T>
    T loadImage(std::ifstream &binStream)
    {
        // get the elf header
        binStream.seekg(0, std::ios::beg);
        if (!binStream.read((char*) &elfPriv_, sizeof(elfPriv_)))
            die("Could not load Elf header\n");

        // do some elf checks
#define checkField(field, expectedVal, name) \
    if(field != expectedVal) \
        die("ELF failure (%s): expected 0x%x but got 0x%x\n", \
    name, expectedVal, field)

        // check elf magic
        checkField(elfPriv_.e_ident[EI_MAG0], ELFMAG0, "Magic-0");

        checkField(elfPriv_.e_ident[EI_MAG1], ELFMAG1, "Magic-1");
        checkField(elfPriv_.e_ident[EI_MAG2], ELFMAG2, "Magic-2");
        checkField(elfPriv_.e_ident[EI_MAG3], ELFMAG3, "Magic-3");

        // check elf info
        checkField(elfPriv_.e_ident[EI_CLASS], ELFCLASS64, "64-bit");
        checkField(elfPriv_.e_ident[EI_DATA], ELFDATA2LSB, "little-endian");
        checkField(elfPriv_.e_ident[EI_VERSION], EV_CURRENT, "version");
        checkField(elfPriv_.e_machine, EM_AARCH64, "A64");
        if (elfPriv_.e_type != ET_REL && elfPriv_.e_type != ET_EXEC)
            die("ELF failure (%s): expected 0x%x or 0x%x but got 0x%x\n",
                "tpye", ET_REL, ET_EXEC, elfPriv_.e_type);
#undef checkField

        // get program headers
        binStream.seekg(elfPriv_.e_phoff, std::ios::beg);

        imgSizePriv_ = 0;
        std::vector<Elf64_Phdr> phList;
        for (int i = 0; i < elfPriv_.e_phnum; i++)
        {
            Elf64_Phdr phdr;
            if (!binStream.read((char*) &phdr, sizeof(phdr)))
                die("Could not Elf program header.\n");

            if (phdr.p_type == PT_LOAD)
            {
                phList.push_back(phdr);
                if (phdr.p_vaddr + phdr.p_memsz > imgSizePriv_)
                    imgSizePriv_ = phdr.p_vaddr + phdr.p_memsz;
            }
        }

        // now we know the max image address, create the space
        imgBaseRoot_ = new Byte[imgSizePriv_ + ADRP_ALIGNMMENT];
        memset(imgBaseRoot_, 0, imgSizePriv_ + ADRP_ALIGNMMENT);
        Byte * imgBase = addPointers<Byte*>(imgBaseRoot_,
                                            (void*) (ADRP_ALIGNMMENT - (((uintptr_t) imgBaseRoot_) % ADRP_ALIGNMMENT)));

        for (Elf64_Phdr phdr : phList)
        {
            dbg("Program section: p_type(%.4d) p_flags(%.4d) p_offset(%.8x) p_vaddr(%.8x) p_paddr(%.8x) p_filesz(%.4d) p_memsz(%.4d) p_align(%.4d)\n",
                phdr.p_type,
                phdr.p_flags,
                phdr.p_offset,
                phdr.p_vaddr,
                phdr.p_paddr,
                phdr.p_filesz,
                phdr.p_memsz,
                phdr.p_align
               );

            binStream.seekg(phdr.p_offset, std::ios::beg);
            uintptr_t imgPtr = (uintptr_t) addPointers<Byte*>(imgBase,
                               (void*) phdr.p_vaddr);

            if (!binStream.read((char*) imgPtr, phdr.p_memsz))
                die("Could not load Elf program section.\n");
            dbg("Loaded %ld bytes at %p; base: %p\n",
                phdr.p_memsz, imgPtr, imgBase);
        }

        return  reinterpret_cast<T>(imgBase);
    }

    template<typename T>
    T getBoundary(std::ifstream &binStream, const std::string &name, bool end) const
    {
        // read in all bytes and work on the buffer instead
        Elf64_Shdr shdrs[elf_.e_shnum];
        binStream.seekg(elf_.e_shoff, std::ios::beg);
        if (!binStream.read((char*) shdrs, elf_.e_shnum * sizeof(Elf64_Shdr)))
            die("Could not load section headers.\n");

        Elf64_Shdr strTblHdr = shdrs[elf_.e_shstrndx];

        Byte strTbl[strTblHdr.sh_size];
        binStream.seekg(strTblHdr.sh_offset, std::ios::beg);
        if (!binStream.read((char*) strTbl, strTblHdr.sh_size))
            die("Could not load Section String Table.\n");

        for (int i = 0; i < elf_.e_shnum; i++)
        {
            const char * sname = (char*) strTbl + shdrs[i].sh_name;
            if (name == sname)
                return reinterpret_cast<T>(
                           end ?
                           shdrs[i].sh_addr + shdrs[i].sh_size
                           :
                           shdrs[i].sh_addr
                       );
        }

        die("Could not find section named \"%s\" (sections=%d)\n",
            name.c_str(), elf_.e_shnum);
    }
};

} // namespace

#endif /* include guard */