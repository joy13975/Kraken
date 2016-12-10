// Copyright 2015, ARM Limited
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions are met:
//
//   * Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//   * Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//   * Neither the name of ARM Limited nor the names of its contributors may be
//     used to endorse or promote products derived from this software without
//     specific prior written permission.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS CONTRIBUTORS "AS IS" AND
// ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
// WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
// DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
// FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
// DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
// SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
// OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

#ifndef _INST_HELPER_A64_H_
#define _INST_HELPER_A64_H_

namespace vixl
{

typedef uint64_t RegList;
static const int kRegListSizeInBits = sizeof(RegList) * 8;

// Registers.

// Some CPURegister methods can return Register or VRegister types, so we need
// to declare them in advance.
class Register;
class VRegister;

class CPURegister {
public:
    enum RegisterType {
        // The kInvalid value is used to detect uninitialized static instances,
        // which are always zero-initialized before any constructors are called.
        kInvalid = 0,
        kRegister,
        kVRegister,
        kFPRegister = kVRegister,
        kNoRegister
    };

    CPURegister() : code_(0), size_(0), type_(kNoRegister) {
        VIXL_ASSERT(!IsValid());
        VIXL_ASSERT(IsNone());
    }

    CPURegister(unsigned code, unsigned size, RegisterType type)
        : code_(code), size_(size), type_(type) {
        VIXL_ASSERT(IsValidOrNone());
    }

    unsigned code() const {
        VIXL_ASSERT(IsValid());
        return code_;
    }

    RegisterType type() const {
        VIXL_ASSERT(IsValidOrNone());
        return type_;
    }

    RegList Bit() const {
        VIXL_ASSERT(code_ < (sizeof(RegList) * 8));
        return IsValid() ? (static_cast<RegList>(1) << code_) : 0;
    }

    unsigned size() const {
        VIXL_ASSERT(IsValid());
        return size_;
    }

    int SizeInBytes() const {
        VIXL_ASSERT(IsValid());
        VIXL_ASSERT(size() % 8 == 0);
        return size_ / 8;
    }

    int SizeInBits() const {
        VIXL_ASSERT(IsValid());
        return size_;
    }

    bool Is8Bits() const {
        VIXL_ASSERT(IsValid());
        return size_ == 8;
    }

    bool Is16Bits() const {
        VIXL_ASSERT(IsValid());
        return size_ == 16;
    }

    bool Is32Bits() const {
        VIXL_ASSERT(IsValid());
        return size_ == 32;
    }

    bool Is64Bits() const {
        VIXL_ASSERT(IsValid());
        return size_ == 64;
    }

    bool Is128Bits() const {
        VIXL_ASSERT(IsValid());
        return size_ == 128;
    }

    bool IsValid() const {
        if (IsValidRegister() || IsValidVRegister()) {
            VIXL_ASSERT(!IsNone());
            return true;
        } else {
            // This assert is hit when the register has not been properly initialized.
            // One cause for this can be an initialisation order fiasco. See
            // https://isocpp.org/wiki/faq/ctors#static-init-order for some details.
            VIXL_ASSERT(IsNone());
            return false;
        }
    }

    bool IsValidRegister() const {
        return IsRegister() && ((size_ == kWRegSize) || (size_ == kXRegSize)) &&
               ((code_ < kNumberOfRegisters) || (code_ == kSPRegInternalCode));
    }

    bool IsValidVRegister() const {
        return IsVRegister() && ((size_ == kBRegSize) || (size_ == kHRegSize) ||
                                 (size_ == kSRegSize) || (size_ == kDRegSize) ||
                                 (size_ == kQRegSize)) &&
               (code_ < kNumberOfVRegisters);
    }

    bool IsValidFPRegister() const {
        return IsFPRegister() && (code_ < kNumberOfVRegisters);
    }

    bool IsNone() const {
        // kNoRegister types should always have size 0 and code 0.
        VIXL_ASSERT((type_ != kNoRegister) || (code_ == 0));
        VIXL_ASSERT((type_ != kNoRegister) || (size_ == 0));

        return type_ == kNoRegister;
    }

    bool Aliases(const CPURegister& other) const {
        VIXL_ASSERT(IsValidOrNone() && other.IsValidOrNone());
        return (code_ == other.code_) && (type_ == other.type_);
    }

    bool Is(const CPURegister& other) const {
        VIXL_ASSERT(IsValidOrNone() && other.IsValidOrNone());
        return Aliases(other) && (size_ == other.size_);
    }

    bool IsZero() const {
        VIXL_ASSERT(IsValid());
        return IsRegister() && (code_ == kZeroRegCode);
    }

    bool IsSP() const {
        VIXL_ASSERT(IsValid());
        return IsRegister() && (code_ == kSPRegInternalCode);
    }

    bool IsRegister() const { return type_ == kRegister; }

    bool IsVRegister() const { return type_ == kVRegister; }

    bool IsFPRegister() const { return IsS() || IsD(); }

    bool IsW() const { return IsValidRegister() && Is32Bits(); }
    bool IsX() const { return IsValidRegister() && Is64Bits(); }

    // These assertions ensure that the size and type of the register are as
    // described. They do not consider the number of lanes that make up a vector.
    // So, for example, Is8B() implies IsD(), and Is1D() implies IsD, but IsD()
    // does not imply Is1D() or Is8B().
    // Check the number of lanes, ie. the format of the vector, using methods such
    // as Is8B(), Is1D(), etc. in the VRegister class.
    bool IsV() const { return IsVRegister(); }
    bool IsB() const { return IsV() && Is8Bits(); }
    bool IsH() const { return IsV() && Is16Bits(); }
    bool IsS() const { return IsV() && Is32Bits(); }
    bool IsD() const { return IsV() && Is64Bits(); }
    bool IsQ() const { return IsV() && Is128Bits(); }

    const Register& W() const;
    const Register& X() const;
    const VRegister& V() const;
    const VRegister& B() const;
    const VRegister& H() const;
    const VRegister& S() const;
    const VRegister& D() const;
    const VRegister& Q() const;

    bool IsSameSizeAndType(const CPURegister& other) const {
        return (size_ == other.size_) && (type_ == other.type_);
    }

protected:
    unsigned code_;
    unsigned size_;
    RegisterType type_;

private:
    bool IsValidOrNone() const { return IsValid() || IsNone(); }
};


class Register : public CPURegister {
public:
    Register() : CPURegister() {}
    explicit Register(const CPURegister& other)
        : CPURegister(other.code(), other.size(), other.type()) {
        VIXL_ASSERT(IsValidRegister());
    }
    Register(unsigned code, unsigned size) : CPURegister(code, size, kRegister) {}

    bool IsValid() const {
        VIXL_ASSERT(IsRegister() || IsNone());
        return IsValidRegister();
    }

    static const Register& WRegFromCode(unsigned code);
    static const Register& XRegFromCode(unsigned code);

private:
    static const Register wregisters[];
    static const Register xregisters[];
};


class VRegister : public CPURegister {
public:
    VRegister() : CPURegister(), lanes_(1) {}
    explicit VRegister(const CPURegister& other)
        : CPURegister(other.code(), other.size(), other.type()), lanes_(1) {
        VIXL_ASSERT(IsValidVRegister());
        VIXL_ASSERT(IsPowerOf2(lanes_) && (lanes_ <= 16));
    }
    VRegister(unsigned code, unsigned size, unsigned lanes = 1)
        : CPURegister(code, size, kVRegister), lanes_(lanes) {
        VIXL_ASSERT(IsPowerOf2(lanes_) && (lanes_ <= 16));
    }
    VRegister(unsigned code, VectorFormat format)
        : CPURegister(code, RegisterSizeInBitsFromFormat(format), kVRegister),
          lanes_(IsVectorFormat(format) ? LaneCountFromFormat(format) : 1) {
        VIXL_ASSERT(IsPowerOf2(lanes_) && (lanes_ <= 16));
    }

    bool IsValid() const {
        VIXL_ASSERT(IsVRegister() || IsNone());
        return IsValidVRegister();
    }

    static const VRegister& BRegFromCode(unsigned code);
    static const VRegister& HRegFromCode(unsigned code);
    static const VRegister& SRegFromCode(unsigned code);
    static const VRegister& DRegFromCode(unsigned code);
    static const VRegister& QRegFromCode(unsigned code);
    static const VRegister& VRegFromCode(unsigned code);

    VRegister V8B() const { return VRegister(code_, kDRegSize, 8); }
    VRegister V16B() const { return VRegister(code_, kQRegSize, 16); }
    VRegister V4H() const { return VRegister(code_, kDRegSize, 4); }
    VRegister V8H() const { return VRegister(code_, kQRegSize, 8); }
    VRegister V2S() const { return VRegister(code_, kDRegSize, 2); }
    VRegister V4S() const { return VRegister(code_, kQRegSize, 4); }
    VRegister V2D() const { return VRegister(code_, kQRegSize, 2); }
    VRegister V1D() const { return VRegister(code_, kDRegSize, 1); }

    bool Is8B() const { return (Is64Bits() && (lanes_ == 8)); }
    bool Is16B() const { return (Is128Bits() && (lanes_ == 16)); }
    bool Is4H() const { return (Is64Bits() && (lanes_ == 4)); }
    bool Is8H() const { return (Is128Bits() && (lanes_ == 8)); }
    bool Is2S() const { return (Is64Bits() && (lanes_ == 2)); }
    bool Is4S() const { return (Is128Bits() && (lanes_ == 4)); }
    bool Is1D() const { return (Is64Bits() && (lanes_ == 1)); }
    bool Is2D() const { return (Is128Bits() && (lanes_ == 2)); }

    // For consistency, we assert the number of lanes of these scalar registers,
    // even though there are no vectors of equivalent total size with which they
    // could alias.
    bool Is1B() const {
        VIXL_ASSERT(!(Is8Bits() && IsVector()));
        return Is8Bits();
    }
    bool Is1H() const {
        VIXL_ASSERT(!(Is16Bits() && IsVector()));
        return Is16Bits();
    }
    bool Is1S() const {
        VIXL_ASSERT(!(Is32Bits() && IsVector()));
        return Is32Bits();
    }

    bool IsLaneSizeB() const { return LaneSizeInBits() == kBRegSize; }
    bool IsLaneSizeH() const { return LaneSizeInBits() == kHRegSize; }
    bool IsLaneSizeS() const { return LaneSizeInBits() == kSRegSize; }
    bool IsLaneSizeD() const { return LaneSizeInBits() == kDRegSize; }

    int lanes() const { return lanes_; }

    bool IsScalar() const { return lanes_ == 1; }

    bool IsVector() const { return lanes_ > 1; }

    bool IsSameFormat(const VRegister& other) const {
        return (size_ == other.size_) && (lanes_ == other.lanes_);
    }

    unsigned LaneSizeInBytes() const { return SizeInBytes() / lanes_; }

    unsigned LaneSizeInBits() const { return LaneSizeInBytes() * 8; }

private:
    static const VRegister bregisters[];
    static const VRegister hregisters[];
    static const VRegister sregisters[];
    static const VRegister dregisters[];
    static const VRegister qregisters[];
    static const VRegister vregisters[];
    int lanes_;
};

// Backward compatibility for FPRegisters.
typedef VRegister FPRegister;

// No*Reg is used to indicate an unused argument, or an error case. Note that
// these all compare equal (using the Is() method). The Register and VRegister
// variants are provided for convenience.
const Register NoReg;
const VRegister NoVReg;
const FPRegister NoFPReg;  // For backward compatibility.
const CPURegister NoCPUReg;

// Lists of registers.
class CPURegList {
public:
    explicit CPURegList(CPURegister reg1,
                        CPURegister reg2 = NoCPUReg,
                        CPURegister reg3 = NoCPUReg,
                        CPURegister reg4 = NoCPUReg)
        : list_(reg1.Bit() | reg2.Bit() | reg3.Bit() | reg4.Bit()),
          size_(reg1.size()),
          type_(reg1.type()) {
        VIXL_ASSERT(AreSameSizeAndType(reg1, reg2, reg3, reg4));
        VIXL_ASSERT(IsValid());
    }

    CPURegList(CPURegister::RegisterType type, unsigned size, RegList list)
        : list_(list), size_(size), type_(type) {
        VIXL_ASSERT(IsValid());
    }

    CPURegList(CPURegister::RegisterType type,
               unsigned size,
               unsigned first_reg,
               unsigned last_reg)
        : size_(size), type_(type) {
        VIXL_ASSERT(
            ((type == CPURegister::kRegister) && (last_reg < kNumberOfRegisters)) ||
            ((type == CPURegister::kVRegister) &&
             (last_reg < kNumberOfVRegisters)));
        VIXL_ASSERT(last_reg >= first_reg);
        list_ = (UINT64_C(1) << (last_reg + 1)) - 1;
        list_ &= ~((UINT64_C(1) << first_reg) - 1);
        VIXL_ASSERT(IsValid());
    }

    CPURegister::RegisterType type() const {
        VIXL_ASSERT(IsValid());
        return type_;
    }

    // Combine another CPURegList into this one. Registers that already exist in
    // this list are left unchanged. The type and size of the registers in the
    // 'other' list must match those in this list.
    void Combine(const CPURegList& other) {
        VIXL_ASSERT(IsValid());
        VIXL_ASSERT(other.type() == type_);
        VIXL_ASSERT(other.RegisterSizeInBits() == size_);
        list_ |= other.list();
    }

    // Remove every register in the other CPURegList from this one. Registers that
    // do not exist in this list are ignored. The type and size of the registers
    // in the 'other' list must match those in this list.
    void Remove(const CPURegList& other) {
        VIXL_ASSERT(IsValid());
        VIXL_ASSERT(other.type() == type_);
        VIXL_ASSERT(other.RegisterSizeInBits() == size_);
        list_ &= ~other.list();
    }

    // Variants of Combine and Remove which take a single register.
    void Combine(const CPURegister& other) {
        VIXL_ASSERT(other.type() == type_);
        VIXL_ASSERT(other.size() == size_);
        Combine(other.code());
    }

    void Remove(const CPURegister& other) {
        VIXL_ASSERT(other.type() == type_);
        VIXL_ASSERT(other.size() == size_);
        Remove(other.code());
    }

    // Variants of Combine and Remove which take a single register by its code;
    // the type and size of the register is inferred from this list.
    void Combine(int code) {
        VIXL_ASSERT(IsValid());
        VIXL_ASSERT(CPURegister(code, size_, type_).IsValid());
        list_ |= (UINT64_C(1) << code);
    }

    void Remove(int code) {
        VIXL_ASSERT(IsValid());
        VIXL_ASSERT(CPURegister(code, size_, type_).IsValid());
        list_ &= ~(UINT64_C(1) << code);
    }

    static CPURegList Union(const CPURegList& list_1, const CPURegList& list_2) {
        VIXL_ASSERT(list_1.type_ == list_2.type_);
        VIXL_ASSERT(list_1.size_ == list_2.size_);
        return CPURegList(list_1.type_, list_1.size_, list_1.list_ | list_2.list_);
    }
    static CPURegList Union(const CPURegList& list_1,
                            const CPURegList& list_2,
                            const CPURegList& list_3);
    static CPURegList Union(const CPURegList& list_1,
                            const CPURegList& list_2,
                            const CPURegList& list_3,
                            const CPURegList& list_4);

    static CPURegList Intersection(const CPURegList& list_1,
                                   const CPURegList& list_2) {
        VIXL_ASSERT(list_1.type_ == list_2.type_);
        VIXL_ASSERT(list_1.size_ == list_2.size_);
        return CPURegList(list_1.type_, list_1.size_, list_1.list_ & list_2.list_);
    }
    static CPURegList Intersection(const CPURegList& list_1,
                                   const CPURegList& list_2,
                                   const CPURegList& list_3);
    static CPURegList Intersection(const CPURegList& list_1,
                                   const CPURegList& list_2,
                                   const CPURegList& list_3,
                                   const CPURegList& list_4);

    bool Overlaps(const CPURegList& other) const {
        return (type_ == other.type_) && ((list_ & other.list_) != 0);
    }

    RegList list() const {
        VIXL_ASSERT(IsValid());
        return list_;
    }

    void set_list(RegList new_list) {
        VIXL_ASSERT(IsValid());
        list_ = new_list;
    }

    // Remove all callee-saved registers from the list. This can be useful when
    // preparing registers for an AAPCS64 function call, for example.
    void RemoveCalleeSaved();

    CPURegister PopLowestIndex();
    CPURegister PopHighestIndex();

    // AAPCS64 callee-saved registers.
    static CPURegList GetCalleeSaved(unsigned size = kXRegSize);
    static CPURegList GetCalleeSavedV(unsigned size = kDRegSize);

    // AAPCS64 caller-saved registers. Note that this includes lr.
    // TODO(all): Determine how we handle d8-d15 being callee-saved, but the top
    // 64-bits being caller-saved.
    static CPURegList GetCallerSaved(unsigned size = kXRegSize);
    static CPURegList GetCallerSavedV(unsigned size = kDRegSize);

    bool IsEmpty() const {
        VIXL_ASSERT(IsValid());
        return list_ == 0;
    }

    bool IncludesAliasOf(const CPURegister& other) const {
        VIXL_ASSERT(IsValid());
        return (type_ == other.type()) && ((other.Bit() & list_) != 0);
    }

    bool IncludesAliasOf(int code) const {
        VIXL_ASSERT(IsValid());
        return ((code & list_) != 0);
    }

    int Count() const {
        VIXL_ASSERT(IsValid());
        return CountSetBits(list_);
    }

    unsigned RegisterSizeInBits() const {
        VIXL_ASSERT(IsValid());
        return size_;
    }

    unsigned RegisterSizeInBytes() const {
        int size_in_bits = RegisterSizeInBits();
        VIXL_ASSERT((size_in_bits % 8) == 0);
        return size_in_bits / 8;
    }

    unsigned TotalSizeInBytes() const {
        VIXL_ASSERT(IsValid());
        return RegisterSizeInBytes() * Count();
    }

private:
    RegList list_;
    unsigned size_;
    CPURegister::RegisterType type_;

    bool IsValid() const;
};


// AAPCS64 callee-saved registers.
extern const CPURegList kCalleeSaved;
extern const CPURegList kCalleeSavedV;


// AAPCS64 caller-saved registers. Note that this includes lr.
extern const CPURegList kCallerSaved;
extern const CPURegList kCallerSavedV;

// Code generation helpers.

// Register encoding.
class CodeGen
{
public:
    CodeGen();
    virtual ~CodeGen() {};

    static Instr Rd(CPURegister rd) {
        VIXL_ASSERT(rd.code() != kSPRegInternalCode);
        return rd.code() << Rd_offset;
    }

    static Instr Rn(CPURegister rn) {
        VIXL_ASSERT(rn.code() != kSPRegInternalCode);
        return rn.code() << Rn_offset;
    }

    static Instr Rm(CPURegister rm) {
        VIXL_ASSERT(rm.code() != kSPRegInternalCode);
        return rm.code() << Rm_offset;
    }

    static Instr RmNot31(CPURegister rm) {
        VIXL_ASSERT(rm.code() != kSPRegInternalCode);
        VIXL_ASSERT(!rm.IsZero());
        return Rm(rm);
    }

    static Instr Ra(CPURegister ra) {
        VIXL_ASSERT(ra.code() != kSPRegInternalCode);
        return ra.code() << Ra_offset;
    }

    static Instr Rt(CPURegister rt) {
        VIXL_ASSERT(rt.code() != kSPRegInternalCode);
        return rt.code() << Rt_offset;
    }

    static Instr Rt2(CPURegister rt2) {
        VIXL_ASSERT(rt2.code() != kSPRegInternalCode);
        return rt2.code() << Rt2_offset;
    }

    static Instr Rs(CPURegister rs) {
        VIXL_ASSERT(rs.code() != kSPRegInternalCode);
        return rs.code() << Rs_offset;
    }

// These encoding functions allow the stack pointer to be encoded, and
// disallow the zero register.
    static Instr RdSP(Register rd) {
        VIXL_ASSERT(!rd.IsZero());
        return (rd.code() & kRegCodeMask) << Rd_offset;
    }

    static Instr RnSP(Register rn) {
        VIXL_ASSERT(!rn.IsZero());
        return (rn.code() & kRegCodeMask) << Rn_offset;
    }

// Flags encoding.
    static Instr Flags(FlagsUpdate S) {
        if (S == SetFlags) {
            return 1 << FlagsUpdate_offset;
        } else if (S == LeaveFlags) {
            return 0 << FlagsUpdate_offset;
        }
        VIXL_UNREACHABLE();
        return 0;
    }

    static Instr Cond(Condition cond) { return cond << Condition_offset; }

// PC-relative address encoding.
    static Instr ImmPCRelAddress(int imm21) {
        VIXL_ASSERT(is_int21(imm21));
        Instr imm = static_cast<Instr>(truncate_to_int21(imm21));
        Instr immhi = (imm >> ImmPCRelLo_width) << ImmPCRelHi_offset;
        Instr immlo = imm << ImmPCRelLo_offset;
        return (immhi & ImmPCRelHi_mask) | (immlo & ImmPCRelLo_mask);
    }

// Branch encoding.
    static Instr ImmUncondBranch(int imm26) {
        VIXL_ASSERT(is_int26(imm26));
        return truncate_to_int26(imm26) << ImmUncondBranch_offset;
    }

    static Instr ImmCondBranch(int imm19) {
        VIXL_ASSERT(is_int19(imm19));
        return truncate_to_int19(imm19) << ImmCondBranch_offset;
    }

    static Instr ImmCmpBranch(int imm19) {
        VIXL_ASSERT(is_int19(imm19));
        return truncate_to_int19(imm19) << ImmCmpBranch_offset;
    }

    static Instr ImmTestBranch(int imm14) {
        VIXL_ASSERT(is_int14(imm14));
        return truncate_to_int14(imm14) << ImmTestBranch_offset;
    }

    static Instr ImmTestBranchBit(unsigned bit_pos) {
        VIXL_ASSERT(is_uint6(bit_pos));
        // Subtract five from the shift offset, as we need bit 5 from bit_pos.
        unsigned b5 = bit_pos << (ImmTestBranchBit5_offset - 5);
        unsigned b40 = bit_pos << ImmTestBranchBit40_offset;
        b5 &= ImmTestBranchBit5_mask;
        b40 &= ImmTestBranchBit40_mask;
        return b5 | b40;
    }

// Data Processing encoding.
    static Instr SF(Register rd) {
        return rd.Is64Bits() ? SixtyFourBits : ThirtyTwoBits;
    }

    static Instr ImmAddSub(int imm) {
        VIXL_ASSERT(IsImmAddSub(imm));
        if (is_uint12(imm)) {  // No shift required.
            imm <<= ImmAddSub_offset;
        } else {
            imm = ((imm >> 12) << ImmAddSub_offset) | (1 << ShiftAddSub_offset);
        }
        return imm;
    }

    static Instr ImmS(unsigned imms, unsigned reg_size) {
        VIXL_ASSERT(((reg_size == kXRegSize) && is_uint6(imms)) ||
                    ((reg_size == kWRegSize) && is_uint5(imms)));
        USE(reg_size);
        return imms << ImmS_offset;
    }

    static Instr ImmR(unsigned immr, unsigned reg_size) {
        VIXL_ASSERT(((reg_size == kXRegSize) && is_uint6(immr)) ||
                    ((reg_size == kWRegSize) && is_uint5(immr)));
        USE(reg_size);
        VIXL_ASSERT(is_uint6(immr));
        return immr << ImmR_offset;
    }

    static Instr ImmSetBits(unsigned imms, unsigned reg_size) {
        VIXL_ASSERT((reg_size == kWRegSize) || (reg_size == kXRegSize));
        VIXL_ASSERT(is_uint6(imms));
        VIXL_ASSERT((reg_size == kXRegSize) || is_uint6(imms + 3));
        USE(reg_size);
        return imms << ImmSetBits_offset;
    }

    static Instr ImmRotate(unsigned immr, unsigned reg_size) {
        VIXL_ASSERT((reg_size == kWRegSize) || (reg_size == kXRegSize));
        VIXL_ASSERT(((reg_size == kXRegSize) && is_uint6(immr)) ||
                    ((reg_size == kWRegSize) && is_uint5(immr)));
        USE(reg_size);
        return immr << ImmRotate_offset;
    }

    static Instr ImmLLiteral(int imm19) {
        VIXL_ASSERT(is_int19(imm19));
        return truncate_to_int19(imm19) << ImmLLiteral_offset;
    }

    static Instr BitN(unsigned bitn, unsigned reg_size) {
        VIXL_ASSERT((reg_size == kWRegSize) || (reg_size == kXRegSize));
        VIXL_ASSERT((reg_size == kXRegSize) || (bitn == 0));
        USE(reg_size);
        return bitn << BitN_offset;
    }

    static Instr ShiftDP(Shift shift) {
        VIXL_ASSERT(shift == LSL || shift == LSR || shift == ASR || shift == ROR);
        return shift << ShiftDP_offset;
    }

    static Instr ImmDPShift(unsigned amount) {
        VIXL_ASSERT(is_uint6(amount));
        return amount << ImmDPShift_offset;
    }

    static Instr ExtendMode(Extend extend) { return extend << ExtendMode_offset; }

    static Instr ImmExtendShift(unsigned left_shift) {
        VIXL_ASSERT(left_shift <= 4);
        return left_shift << ImmExtendShift_offset;
    }

    static Instr ImmCondCmp(unsigned imm) {
        VIXL_ASSERT(is_uint5(imm));
        return imm << ImmCondCmp_offset;
    }

    static Instr Nzcv(StatusFlags nzcv) {
        return ((nzcv >> Flags_offset) & 0xf) << Nzcv_offset;
    }

// MemOperand offset encoding.
    static Instr ImmLSUnsigned(int imm12) {
        VIXL_ASSERT(is_uint12(imm12));
        return imm12 << ImmLSUnsigned_offset;
    }

    static Instr ImmLS(int imm9) {
        VIXL_ASSERT(is_int9(imm9));
        return truncate_to_int9(imm9) << ImmLS_offset;
    }

    static Instr ImmLSPair(int imm7, unsigned access_size) {
        VIXL_ASSERT(((imm7 >> access_size) << access_size) == imm7);
        int scaled_imm7 = imm7 >> access_size;
        VIXL_ASSERT(is_int7(scaled_imm7));
        return truncate_to_int7(scaled_imm7) << ImmLSPair_offset;
    }

    static Instr ImmShiftLS(unsigned shift_amount) {
        VIXL_ASSERT(is_uint1(shift_amount));
        return shift_amount << ImmShiftLS_offset;
    }

    static Instr ImmPrefetchOperation(int imm5) {
        VIXL_ASSERT(is_uint5(imm5));
        return imm5 << ImmPrefetchOperation_offset;
    }

    static Instr ImmException(int imm16) {
        VIXL_ASSERT(is_uint16(imm16));
        return imm16 << ImmException_offset;
    }

    static Instr ImmSystemRegister(int imm15) {
        VIXL_ASSERT(is_uint15(imm15));
        return imm15 << ImmSystemRegister_offset;
    }

    static Instr ImmHint(int imm7) {
        VIXL_ASSERT(is_uint7(imm7));
        return imm7 << ImmHint_offset;
    }

    static Instr CRm(int imm4) {
        VIXL_ASSERT(is_uint4(imm4));
        return imm4 << CRm_offset;
    }

    static Instr CRn(int imm4) {
        VIXL_ASSERT(is_uint4(imm4));
        return imm4 << CRn_offset;
    }

    static Instr SysOp(int imm14) {
        VIXL_ASSERT(is_uint14(imm14));
        return imm14 << SysOp_offset;
    }

    static Instr ImmSysOp1(int imm3) {
        VIXL_ASSERT(is_uint3(imm3));
        return imm3 << SysOp1_offset;
    }

    static Instr ImmSysOp2(int imm3) {
        VIXL_ASSERT(is_uint3(imm3));
        return imm3 << SysOp2_offset;
    }

    static Instr ImmBarrierDomain(int imm2) {
        VIXL_ASSERT(is_uint2(imm2));
        return imm2 << ImmBarrierDomain_offset;
    }

    static Instr ImmBarrierType(int imm2) {
        VIXL_ASSERT(is_uint2(imm2));
        return imm2 << ImmBarrierType_offset;
    }

// Move immediates encoding.
    static Instr ImmMoveWide(uint64_t imm) {
        VIXL_ASSERT(is_uint16(imm));
        return static_cast<Instr>(imm << ImmMoveWide_offset);
    }

    static Instr ShiftMoveWide(int64_t shift) {
        VIXL_ASSERT(is_uint2(shift));
        return static_cast<Instr>(shift << ShiftMoveWide_offset);
    }

// FP Immediates.
    static Instr ImmFP32(float imm);
    static Instr ImmFP64(double imm);

// FP register type.
    static Instr FPType(FPRegister fd) { return fd.Is64Bits() ? FP64 : FP32; }

    static Instr FPScale(unsigned scale) {
        VIXL_ASSERT(is_uint6(scale));
        return scale << FPScale_offset;
    }

// Immediate field checking helpers.
    static bool IsImmAddSub(int64_t immediate);
    static bool IsImmConditionalCompare(int64_t immediate);
    static bool IsImmFP32(float imm);
    static bool IsImmFP64(double imm);
    static bool IsImmLogical(uint64_t value,
                             unsigned width,
                             unsigned* n = NULL,
                             unsigned* imm_s = NULL,
                             unsigned* imm_r = NULL);
    static bool IsImmLSPair(int64_t offset, unsigned access_size);
    static bool IsImmLSScaled(int64_t offset, unsigned access_size);
    static bool IsImmLSUnscaled(int64_t offset);
    static bool IsImmMovn(uint64_t imm, unsigned reg_size);
    static bool IsImmMovz(uint64_t imm, unsigned reg_size);

// Instruction bits for vector format in data processing operations.
    static Instr VFormat(VRegister vd) {
        if (vd.Is64Bits()) {
            switch (vd.lanes()) {
            case 2:
                return NEON_2S;
            case 4:
                return NEON_4H;
            case 8:
                return NEON_8B;
            default:
                return 0xffffffff;
            }
        } else {
            VIXL_ASSERT(vd.Is128Bits());
            switch (vd.lanes()) {
            case 2:
                return NEON_2D;
            case 4:
                return NEON_4S;
            case 8:
                return NEON_8H;
            case 16:
                return NEON_16B;
            default:
                return 0xffffffff;
            }
        }
    }

// Instruction bits for vector format in floating point data processing
// operations.
    static Instr FPFormat(VRegister vd) {
        if (vd.lanes() == 1) {
            // Floating point scalar formats.
            VIXL_ASSERT(vd.Is32Bits() || vd.Is64Bits());
            return vd.Is64Bits() ? FP64 : FP32;
        }

        // Two lane floating point vector formats.
        if (vd.lanes() == 2) {
            VIXL_ASSERT(vd.Is64Bits() || vd.Is128Bits());
            return vd.Is128Bits() ? NEON_FP_2D : NEON_FP_2S;
        }

        // Four lane floating point vector format.
        VIXL_ASSERT((vd.lanes() == 4) && vd.Is128Bits());
        return NEON_FP_4S;
    }

// Instruction bits for vector format in load and store operations.
    static Instr LSVFormat(VRegister vd) {
        if (vd.Is64Bits()) {
            switch (vd.lanes()) {
            case 1:
                return LS_NEON_1D;
            case 2:
                return LS_NEON_2S;
            case 4:
                return LS_NEON_4H;
            case 8:
                return LS_NEON_8B;
            default:
                return 0xffffffff;
            }
        } else {
            VIXL_ASSERT(vd.Is128Bits());
            switch (vd.lanes()) {
            case 2:
                return LS_NEON_2D;
            case 4:
                return LS_NEON_4S;
            case 8:
                return LS_NEON_8H;
            case 16:
                return LS_NEON_16B;
            default:
                return 0xffffffff;
            }
        }
    }

// Instruction bits for scalar format in data processing operations.
    static Instr SFormat(VRegister vd) {
        VIXL_ASSERT(vd.lanes() == 1);
        switch (vd.SizeInBytes()) {
        case 1:
            return NEON_B;
        case 2:
            return NEON_H;
        case 4:
            return NEON_S;
        case 8:
            return NEON_D;
        default:
            return 0xffffffff;
        }
    }

    static Instr ImmNEONHLM(int index, int num_bits) {
        int h, l, m;
        if (num_bits == 3) {
            VIXL_ASSERT(is_uint3(index));
            h = (index >> 2) & 1;
            l = (index >> 1) & 1;
            m = (index >> 0) & 1;
        } else if (num_bits == 2) {
            VIXL_ASSERT(is_uint2(index));
            h = (index >> 1) & 1;
            l = (index >> 0) & 1;
            m = 0;
        } else {
            VIXL_ASSERT(is_uint1(index) && (num_bits == 1));
            h = (index >> 0) & 1;
            l = 0;
            m = 0;
        }
        return (h << NEONH_offset) | (l << NEONL_offset) | (m << NEONM_offset);
    }

    static Instr ImmNEONExt(int imm4) {
        VIXL_ASSERT(is_uint4(imm4));
        return imm4 << ImmNEONExt_offset;
    }

    static Instr ImmNEON5(Instr format, int index) {
        VIXL_ASSERT(is_uint4(index));
        int s = LaneSizeInBytesLog2FromFormat(static_cast<VectorFormat>(format));
        int imm5 = (index << (s + 1)) | (1 << s);
        return imm5 << ImmNEON5_offset;
    }

    static Instr ImmNEON4(Instr format, int index) {
        VIXL_ASSERT(is_uint4(index));
        int s = LaneSizeInBytesLog2FromFormat(static_cast<VectorFormat>(format));
        int imm4 = index << s;
        return imm4 << ImmNEON4_offset;
    }

    static Instr ImmNEONabcdefgh(int imm8) {
        VIXL_ASSERT(is_uint8(imm8));
        Instr instr;
        instr = ((imm8 >> 5) & 7) << ImmNEONabc_offset;
        instr |= (imm8 & 0x1f) << ImmNEONdefgh_offset;
        return instr;
    }

    static Instr NEONCmode(int cmode) {
        VIXL_ASSERT(is_uint4(cmode));
        return cmode << NEONCmode_offset;
    }

    static Instr NEONModImmOp(int op) {
        VIXL_ASSERT(is_uint1(op));
        return op << NEONModImmOp_offset;
    }
private:
};
} // namespace vixl

#endif /* include guard */