#ifndef _TYPES_H_
#define _TYPES_H_

#include <string>
#include <vector>
#include <fstream>
#include <cstddef>
#include <deque>

#include <elf.h>
#include <string.h>

#include "bit_util.h"
#include "util.h"

#include "vixl/a64/logic-regs-a64.h"
#include "visits.h"

namespace Kraken
{

typedef const vixl::Instruction* InstrPtr;

struct State
{
    InstrPtr pc = 0;
    vixl::SimRegister               regs[vixl::kNumberOfRegisters];
    vixl::SimVRegister              vregs[vixl::kNumberOfVRegisters];
    vixl::SimSystemRegister         nzcv;
    vixl::SimSystemRegister         fpcr;
};

struct DecodedInstr
{
    ActionCode ac;
    InstrPtr instr;
    DecodedInstr(const ActionCode & _ac,
                 const InstrPtr & _instr)
        : ac(_ac), instr(_instr) {}
};

class RobEntry
{
public:
    enum Status
    {
        Idle,
        Waiting,
        InProgress,
        Done,
        Invalid
    };

    RobEntry()
        : decInstr((ActionCode) 0, 0),
          status(Invalid),
          successor(0) {}
    RobEntry(const DecodedInstr _decInstr)
        : decInstr(_decInstr) {}
    RobEntry(const RobEntry & other)
        : decInstr(other.decInstr),
          status(other.status),
          successor(other.successor),
          scriptureList(other.scriptureList) {}
    RobEntry& operator=(const RobEntry& other)
    {
        if (this == &other)
            return *this;

        decInstr = other.decInstr;
        status = other.status;
        successor = other.successor;
        scriptureList = other.scriptureList;

        return *this;
    }
    virtual ~RobEntry() {};

    void setScriptureList(const std::vector<Scripture> & s)
    {
        scriptureList = s;
    }
    const std::vector<Scripture> & getScriptureList() const
    {
        return scriptureList;
    }

    DecodedInstr decInstr;
    Status status = Idle;
    RobEntry * successor = 0;

private:
    std::vector<Scripture> scriptureList;
};

typedef std::deque<RobEntry *> ReservationStation;

#define FOREACH_BRANCH_PREDICTION_MODE(MACRO) \
    MACRO(NoneMode) \
    MACRO(StaticMode) \
    MACRO(DynamicMode)
GEN_ENUM_AND_STRING(BranchPredictionMode, BranchPredictionModeString, FOREACH_BRANCH_PREDICTION_MODE);

typedef struct
{
    // options
    std::string input               = "";
    std::string dataOutput          = "data.bin";
    std::string stackOutput         = "stack.bin";

    // features
    bool interactive                = false;
    bool pipelined                  = false;
    bool simExecLatency             = false;

    short nBPBits                   = 5;
    BranchPredictionMode bpMode     = NoneMode;

    short nSuperscalar              = 1;
    std::vector<uintptr_t> bpoints;
} Options;

class BranchRecords
{
public:
    BranchRecords(BranchPredictionMode _mode,
                  unsigned short _maxLen,
                  const InstrPtr _textEnd)
        : mode(_mode),
          maxLen(_maxLen),
          textEnd(_textEnd)
    {}

    virtual ~BranchRecords() {};

    void updateRecord(const InstrPtr instr,
                      const InstrPtr branchDest);
    void clearRecords();
    InstrPtr predict(const InstrPtr _instr) const;
    InstrPtr fixedPredict(const InstrPtr _instr) const;


    const BranchPredictionMode mode;
    const unsigned short maxLen;
    const InstrPtr textEnd;
private:
    class Record
    {
    public:
        Record(const unsigned short maxLen,
               const InstrPtr instr,
               const InstrPtr branchDest);

        virtual ~Record() {};
        void update(bool branchTaken);
        InstrPtr staticPredict() const;
        InstrPtr dynamicPredict() const;
        int getHistSize() { return history.size(); }

        const unsigned short maxLen;
        const InstrPtr instr;
        const InstrPtr branchDest;

    private:
        std::deque<bool> history;
    };

    std::vector<Record> records;
};

#define ADRP_ALIGNMMENT 4096

class ProgramInfo
{
public:
    const size_t            stackAndHeapSize = 0; // logic takes care
    const Word *const       image;
    const Elf64_Ehdr        elf;
    const size_t            imgSize;
    const Word *const       entry;
    const Word *const       textStart;
    const Word *const       textEnd;
    const Word *const       dataStart;
    const Word *const       dataEnd;

    ProgramInfo(std::ifstream && binStream);
    virtual ~ProgramInfo() { delete imgBaseRoot; }

    static size_t getImgSize(std::ifstream & binStream);
    template<typename T>
    T offset(const void* ptr) const
    { return addPointers<T>(image, ptr); }

    template<typename T>
    T fromBase(const void* ptr) const
    { return subPointers<T>(ptr, image); }

private:
    Elf64_Ehdr elfPriv;
    size_t imgSizePriv;
    Byte * imgBaseRoot;

    template<typename T>
    T loadImage(std::ifstream &binStream)
    {
        // get the elf header
        binStream.seekg(0, std::ios::beg);
        if (!binStream.read((char*) &elfPriv, sizeof(elfPriv)))
            die("Could not load Elf header\n");

        // do some elf checks
#define checkField(field, expectedVal, name) \
    if(field != expectedVal) \
        die("ELF failure (%s): expected 0x%x but got 0x%x\n", \
    name, expectedVal, field)

        // check elf magic
        checkField(elfPriv.e_ident[EI_MAG0], ELFMAG0, "Magic-0");

        checkField(elfPriv.e_ident[EI_MAG1], ELFMAG1, "Magic-1");
        checkField(elfPriv.e_ident[EI_MAG2], ELFMAG2, "Magic-2");
        checkField(elfPriv.e_ident[EI_MAG3], ELFMAG3, "Magic-3");

        // check elf info
        checkField(elfPriv.e_ident[EI_CLASS], ELFCLASS64, "64-bit");
        checkField(elfPriv.e_ident[EI_DATA], ELFDATA2LSB, "little-endian");
        checkField(elfPriv.e_ident[EI_VERSION], EV_CURRENT, "version");
        checkField(elfPriv.e_machine, EM_AARCH64, "A64");
        if (elfPriv.e_type != ET_REL && elfPriv.e_type != ET_EXEC)
            die("ELF failure (%s): expected 0x%x or 0x%x but got 0x%x\n",
                "tpye", ET_REL, ET_EXEC, elfPriv.e_type);
#undef checkField

        // get program headers
        binStream.seekg(elfPriv.e_phoff, std::ios::beg);

        imgSizePriv = 0;
        std::vector<Elf64_Phdr> phList;
        for (int i = 0; i < elfPriv.e_phnum; i++)
        {
            Elf64_Phdr phdr;
            if (!binStream.read((char*) &phdr, sizeof(phdr)))
                die("Could not Elf program header.\n");

            if (phdr.p_type == PT_LOAD)
            {
                phList.push_back(phdr);
                if (phdr.p_vaddr + phdr.p_memsz > imgSizePriv)
                    imgSizePriv = phdr.p_vaddr + phdr.p_memsz;
            }
        }

        // now we know the max image address, create the space
        imgBaseRoot = new Byte[imgSizePriv + ADRP_ALIGNMMENT];
        memset(imgBaseRoot, 0, imgSizePriv + ADRP_ALIGNMMENT);
        Byte * imgBase = addPointers<Byte*>(imgBaseRoot,
                                            (void*) (ADRP_ALIGNMMENT - (((uintptr_t) imgBaseRoot) % ADRP_ALIGNMMENT)));

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

            if (!binStream.read((char*) imgPtr, phdr.p_filesz))
            {
                err("Could not load Elf program section\n");
                die("Error: %s; phdr.p_memsz = %ld\n",
                    get_error_string(), phdr.p_memsz);
            }
            dbg("Loaded %ld bytes at %p; base: %p\n",
                phdr.p_memsz, imgPtr, imgBase);
        }

        return  reinterpret_cast<T>(imgBase);
    }

    template<typename T>
    T getBoundary(std::ifstream &binStream, const std::string &name, bool end) const
    {
        // read in all bytes and work on the buffer instead
        Elf64_Shdr shdrs[elf.e_shnum];
        binStream.seekg(elf.e_shoff, std::ios::beg);
        if (!binStream.read((char*) shdrs, elf.e_shnum * sizeof(Elf64_Shdr)))
            die("Could not load section headers.\n");

        Elf64_Shdr strTblHdr = shdrs[elf.e_shstrndx];

        Byte strTbl[strTblHdr.sh_size];
        binStream.seekg(strTblHdr.sh_offset, std::ios::beg);
        if (!binStream.read((char*) strTbl, strTblHdr.sh_size))
            die("Could not load Section String Table.\n");

        for (int i = 0; i < elf.e_shnum; i++)
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

        wrn("Could not find section named \"%s\" (sections=%d)\n",
            name.c_str(), elf.e_shnum);

        return 0;
    }
};

} // namespace

#endif /* include guard */