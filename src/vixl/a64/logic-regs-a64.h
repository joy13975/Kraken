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

// Code migrated from simulator-a64.h (now logic-a64.h)

#ifndef _LOGIC_REGS_A64_H_
#define _LOGIC_REGS_A64_H_

#include "vixl/a64/logic-constants-a64.h"
#include "vixl/a64/logic-memory-a64.h"
#include "vixl/a64/instructions-a64.h"
#include "scripture.h"
#include "types.h"
#include "util.h"

namespace Kraken
{
class RobEntry;
}

namespace vixl
{

class Memory;

class ScribeReg
{
public:
    ScribeReg() : written_since_last_log_(false) {}

    // TODO: Make this return a map of updated bytes, so that we can highlight
    // updated lanes for load-and-insert. (That never happens for scalar code, but
    // NEON has some instructions that can update individual lanes.)
    bool WrittenSinceLastLog() const {
        return written_since_last_log_;
    }

    void NotifyRegisterLogged() {
        written_since_last_log_ = false;
    }

    int id;
    Memory *memory;
    std::vector<Kraken::Scripture> * scriptureList = 0;
    bool * consultMode = 0;
    Kraken::RobEntry ** consultorPtr = 0;
    Kraken::Scripture * lastWriteSpt = 0;

    void clearLastSpt()
    {
        lastWriteSpt = 0;
    }

protected:
    bool written_since_last_log_;

    virtual Kraken::Scripture * makeScripture(const Kraken::SPTMode & sptMode) = 0;
    virtual void fillScripture(Kraken::Scripture * s) = 0;

    virtual void appearAs(const Kraken::Scripture * s) = 0;

    void realWrite()
    {
        // if it's ResetState(), lastWriteSpt should be null
        if (!lastWriteSpt)
            return;

        using namespace Kraken;
        written_since_last_log_ = true;

        bool foundSelf = false;
        for (Scripture *& s : (*consultorPtr)->outList)
        {
            if (s->type != SinkType::Mem && s->addr == id)
            {
                foundSelf = true;
                fillScripture(s);
                s->ready = true;
                dbg("Write R%d (%p) = %p; marked ready\n",
                    id, s, *((uint64_t*) s->value));
            }
        }

        // if (!foundSelf) // there are multi-assignment instructions
        //     die("Could not find self (%d) in outList of %p\n",
        //         id, (*consultorPtr)->decInstr.instr);
    }
    void realRead()
    {
        using namespace Kraken;

        bool foundSelf = false;
        for (Scripture * s : (*consultorPtr)->inList)
        {
            if (s->type != SinkType::Mem && s->addr == id)
            {
                foundSelf = true;
                appearAs(s);
                s->ready = true;
                dbg("Read R%d (%p) = %p\n",
                    id, s, *((uint32_t*) s->value));
            }
        }

        // if (!foundSelf) // probably print disasm
        // {
        //     die("Could not find self (%d) in inList of %p\n",
        //         id, (*consultorPtr)->decInstr.instr);
        // }
    }

    void consultRead()
    {
        using namespace Kraken;

        if (!lastWriteSpt)
        {
            // can read now; make spt and give
            Scripture *s = makeScripture(SPTMode::Read);
            fillScripture(s);
            s->ready = true;
            (*consultorPtr)->inList.push_back(s);

            dbg("Added R%d (new %p) to inList of %p\n",
                id, s, (*consultorPtr)->decInstr.instr);
        }
        else
        {
            // forward that wspt and wait for it to finish
            (*consultorPtr)->inList.push_back(lastWriteSpt);

            dbg("Added R%d (linked %p) to inList of %p\n",
                id, lastWriteSpt, (*consultorPtr)->decInstr.instr);
        }
    }

    void consultWrite()
    {
        using namespace Kraken;

        // just write on this new piece of spt
        Scripture *s = makeScripture(SPTMode::Write);
        s->ready = false;
        (*consultorPtr)->outList.push_back(s);
        lastWriteSpt = s;

        dbg("Added R%d (writeSpt %p) to outList of %p\n",
            id, lastWriteSpt, (*consultorPtr)->decInstr.instr);
    }
};

// Represent a register (r0-r31, v0-v31).
template <int kSizeInBytes>
class SimRegisterBase : public ScribeReg {
public:
    SimRegisterBase() : ScribeReg() {
    }

    // Write the specified value. The value is zero-extended if necessary.
    template <typename T>
    void Set(T new_value) {
        if (!consultMode || !*consultMode)
        {
            VIXL_STATIC_ASSERT(sizeof(new_value) <= kSizeInBytes);
            if (sizeof(new_value) < kSizeInBytes) {
                // All AArch64 registers are zero-extending.
                memset(value_ + sizeof(new_value), 0, kSizeInBytes - sizeof(new_value));
            }
            memcpy(value_, &new_value, sizeof(new_value));
            realWrite();
        }
        else
        {
            consultWrite();
        }
    }

    // Insert a typed value into a register, leaving the rest of the register
    // unchanged. The lane parameter indicates where in the register the value
    // should be inserted, in the range [ 0, sizeof(value_) / sizeof(T) ), where
    // 0 represents the least significant bits.
    template <typename T>
    void Insert(int lane, T new_value) {
        if (!consultMode || !*consultMode)
        {
            VIXL_ASSERT(lane >= 0);
            VIXL_ASSERT((sizeof(new_value) + (lane * sizeof(new_value))) <=
                        kSizeInBytes);
            memcpy(&value_[lane * sizeof(new_value)], &new_value, sizeof(new_value));
            realWrite();
        }
        else
        {
            consultWrite();
        }
    }

    // Read the value as the specified type. The value is truncated if necessary.
    template <typename T>
    T Get(int lane = 0) {
        T result;
        VIXL_ASSERT(lane >= 0);
        VIXL_ASSERT((sizeof(result) + (lane * sizeof(result))) <= kSizeInBytes);

        if (consultMode && *consultMode)
            consultRead();
        else
            realRead();

        memcpy(&result, &value_[lane * sizeof(result)], sizeof(result));
        return result;
    }

protected:
    uint8_t value_[kSizeInBytes];

    Kraken::Scripture * makeScripture(const Kraken::SPTMode & sptMode)
    {
        using namespace Kraken;

        return new Scripture(
                   kSizeInBytes == 8 ?
                   SinkType::Reg :
                   SinkType::VReg,
                   id,
                   sptMode,
                   kSizeInBytes
               );
    }

    void fillScripture(Kraken::Scripture * s)
    {
        s->fill(value_);
    }

    void appearAs(const Kraken::Scripture * s)
    {
        memcpy(value_, s->value, s->szBytes);
    }
};
typedef SimRegisterBase<kXRegSizeInBytes> SimRegister;   // r0-r31
typedef SimRegisterBase<kQRegSizeInBytes> SimVRegister;  // v0-v31


// The proper way to initialize a simulated system register (such as NZCV) is as
// follows:
//  SimSystemRegister nzcv = SimSystemRegister::DefaultValueFor(NZCV);
class SimSystemRegister : public ScribeReg {
public:
    // The default constructor represents a register which has no writable bits.
    // It is not possible to set its value to anything other than 0.
    SimSystemRegister()
        : value_(0), write_ignore_mask_(0xffffffff) { }

    uint32_t RawValue() {
        if (consultMode && *consultMode)
            consultRead();
        else
            realRead();
        return value_;
    }

    void SetRawValue(uint32_t new_value) {
        if (!consultMode || !*consultMode)
        {
            value_ = (value_ & write_ignore_mask_) | (new_value & ~write_ignore_mask_);
            realWrite();
        }
        else
        {
            consultWrite();
        }
    }

    uint32_t Bits(int msb, int lsb) {

        if (consultMode && *consultMode)
            consultRead();
        else
            realRead();
        return unsigned_bitextract_32(msb, lsb, value_);
    }

    int32_t SignedBits(int msb, int lsb) {

        if (consultMode && *consultMode)
            consultRead();
        else
            realRead();
        return signed_bitextract_32(msb, lsb, value_);
    }

    void SetBits(int msb, int lsb, uint32_t bits) {
        if (!consultMode || !*consultMode)
        {
            int width = msb - lsb + 1;
            VIXL_ASSERT(is_uintn(width, bits) || is_intn(width, bits));

            bits <<= lsb;
            uint32_t mask = ((1 << width) - 1) << lsb;
            VIXL_ASSERT((mask & write_ignore_mask_) == 0);

            value_ = (value_ & ~mask) | (bits & mask);
            realWrite();
        }
        else
        {
            consultWrite();
        }
    }

    // Default system register values.
    static SimSystemRegister DefaultValueFor(SystemRegister id);

#define DEFINE_GETTER(Name, HighBit, LowBit, Func) \
    uint32_t Name() { \
        if (consultMode && *consultMode) \
            consultRead(); \
        else \
            realRead(); \
        return Func(HighBit, LowBit); \
    } \
  void Set##Name(uint32_t bits) { \
        if (!consultMode || !*consultMode) \
        { \
            SetBits(HighBit, LowBit, bits); \
            realWrite(); \
        } \
        else \
        { \
            consultWrite(); \
        } \
    }
#define DEFINE_WRITE_IGNORE_MASK(Name, Mask) \
  static const uint32_t Name##WriteIgnoreMask = ~static_cast<uint32_t>(Mask);

    SYSTEM_REGISTER_FIELDS_LIST(DEFINE_GETTER, DEFINE_WRITE_IGNORE_MASK)

#undef DEFINE_ZERO_BITS
#undef DEFINE_GETTER

    std::vector<Kraken::Scripture> * scriptureList;
protected:
// Most system registers only implement a few of the bits in the word. Other
// bits are "read-as-zero, write-ignored". The write_ignore_mask argument
// describes the bits which are not modifiable.
    SimSystemRegister(uint32_t value, uint32_t write_ignore_mask)
        : value_(value), write_ignore_mask_(write_ignore_mask) {}

    uint32_t value_;
    uint32_t write_ignore_mask_;

    Kraken::Scripture * makeScripture(const Kraken::SPTMode & sptMode)
    {
        using namespace Kraken;
        return new Scripture(
                   id == -1 ?
                   SinkType::NZCV :
                   SinkType::FPCR,
                   id,
                   sptMode,
                   sizeof(uint32_t)
               );
    }

    void fillScripture(Kraken::Scripture * s)
    {
        s->fill((uint8_t*) &value_);
    }

    void appearAs(const Kraken::Scripture * s)
    {
        wrn("R%d: was %d, appear as %d\n", id, value_, *((uint32_t*) s->value));
        memcpy(&value_, s->value, s->szBytes);
    }
};


class SimExclusiveLocalMonitor {
public:
    SimExclusiveLocalMonitor() : kSkipClearProbability(8), seed_(0x87654321) {
        Clear();
    }

    // Clear the exclusive monitor (like clrex).
    void Clear() {
        address_ = 0;
        size_ = 0;
    }

    // Clear the exclusive monitor most of the time.
    void MaybeClear() {
        if ((seed_ % kSkipClearProbability) != 0) {
            Clear();
        }

        // Advance seed_ using a simple linear congruential generator.
        seed_ = (seed_ * 48271) % 2147483647;
    }

    // Mark the address range for exclusive access (like load-exclusive).
    void MarkExclusive(uint64_t address, size_t size) {
        address_ = address;
        size_ = size;
    }

    // Return true if the address range is marked (like store-exclusive).
    // This helper doesn't implicitly clear the monitor.
    bool IsExclusive(uint64_t address, size_t size) {
        VIXL_ASSERT(size > 0);
        // Be pedantic: Require both the address and the size to match.
        return (size == size_) && (address == address_);
    }

private:
    uint64_t address_;
    size_t size_;

    const int kSkipClearProbability;
    uint32_t seed_;
};


// We can't accurate simulate the global monitor since it depends on external
// influences. Instead, this implementation occasionally causes accesses to
// fail, according to kPassProbability.
class SimExclusiveGlobalMonitor {
public:
    SimExclusiveGlobalMonitor() : kPassProbability(8), seed_(0x87654321) {}

    bool IsExclusive(uint64_t address, size_t size) {
        USE(address, size);

        bool pass = (seed_ % kPassProbability) != 0;
        // Advance seed_ using a simple linear congruential generator.
        seed_ = (seed_ * 48271) % 2147483647;
        return pass;
    }

private:
    const int kPassProbability;
    uint32_t seed_;
};


// Representation of a vector register, with typed getters and setters for lanes
// and additional information to represent lane state.
class LogicVRegister {
public:
    inline LogicVRegister(SimVRegister& other)  // NOLINT
        : register_(other) {
        for (unsigned i = 0; i < sizeof(saturated_) / sizeof(saturated_[0]); i++) {
            saturated_[i] = kNotSaturated;
        }
        for (unsigned i = 0; i < sizeof(round_) / sizeof(round_[0]); i++) {
            round_[i] = 0;
        }
    }

    int64_t Int(VectorFormat vform, int index) const {
        int64_t element;
        switch (LaneSizeInBitsFromFormat(vform)) {
        case 8:
            element = register_.Get<int8_t>(index);
            break;
        case 16:
            element = register_.Get<int16_t>(index);
            break;
        case 32:
            element = register_.Get<int32_t>(index);
            break;
        case 64:
            element = register_.Get<int64_t>(index);
            break;
        default:
            VIXL_UNREACHABLE();
            return 0;
        }
        return element;
    }

    uint64_t Uint(VectorFormat vform, int index) const {
        uint64_t element;
        switch (LaneSizeInBitsFromFormat(vform)) {
        case 8:
            element = register_.Get<uint8_t>(index);
            break;
        case 16:
            element = register_.Get<uint16_t>(index);
            break;
        case 32:
            element = register_.Get<uint32_t>(index);
            break;
        case 64:
            element = register_.Get<uint64_t>(index);
            break;
        default:
            VIXL_UNREACHABLE();
            return 0;
        }
        return element;
    }

    int64_t IntLeftJustified(VectorFormat vform, int index) const {
        return Int(vform, index) << (64 - LaneSizeInBitsFromFormat(vform));
    }

    uint64_t UintLeftJustified(VectorFormat vform, int index) const {
        return Uint(vform, index) << (64 - LaneSizeInBitsFromFormat(vform));
    }

    void SetInt(VectorFormat vform, int index, int64_t value) const {
        switch (LaneSizeInBitsFromFormat(vform)) {
        case 8:
            register_.Insert(index, static_cast<int8_t>(value));
            break;
        case 16:
            register_.Insert(index, static_cast<int16_t>(value));
            break;
        case 32:
            register_.Insert(index, static_cast<int32_t>(value));
            break;
        case 64:
            register_.Insert(index, static_cast<int64_t>(value));
            break;
        default:
            VIXL_UNREACHABLE();
            return;
        }
    }

    void SetUint(VectorFormat vform, int index, uint64_t value) const {
        switch (LaneSizeInBitsFromFormat(vform)) {
        case 8:
            register_.Insert(index, static_cast<uint8_t>(value));
            break;
        case 16:
            register_.Insert(index, static_cast<uint16_t>(value));
            break;
        case 32:
            register_.Insert(index, static_cast<uint32_t>(value));
            break;
        case 64:
            register_.Insert(index, static_cast<uint64_t>(value));
            break;
        default:
            VIXL_UNREACHABLE();
            return;
        }
    }

    void ReadUintFromMem(VectorFormat vform, int index, uint64_t addr) const;

    void WriteUintToMem(VectorFormat vform, int index, uint64_t addr, Memory *memory) const;

    template <typename T>
    T Float(int index) const {
        return register_.Get<T>(index);
    }

    template <typename T>
    void SetFloat(int index, T value) const {
        register_.Insert(index, value);
    }

    // When setting a result in a register of size less than Q, the top bits of
    // the Q register must be cleared.
    void ClearForWrite(VectorFormat vform) const {
        unsigned size = RegisterSizeInBytesFromFormat(vform);
        for (unsigned i = size; i < kQRegSizeInBytes; i++) {
            SetUint(kFormat16B, i, 0);
        }
    }

    // Saturation state for each lane of a vector.
    enum Saturation {
        kNotSaturated = 0,
        kSignedSatPositive = 1 << 0,
        kSignedSatNegative = 1 << 1,
        kSignedSatMask = kSignedSatPositive | kSignedSatNegative,
        kSignedSatUndefined = kSignedSatMask,
        kUnsignedSatPositive = 1 << 2,
        kUnsignedSatNegative = 1 << 3,
        kUnsignedSatMask = kUnsignedSatPositive | kUnsignedSatNegative,
        kUnsignedSatUndefined = kUnsignedSatMask
    };

    // Getters for saturation state.
    Saturation GetSignedSaturation(int index) {
        return static_cast<Saturation>(saturated_[index] & kSignedSatMask);
    }

    Saturation GetUnsignedSaturation(int index) {
        return static_cast<Saturation>(saturated_[index] & kUnsignedSatMask);
    }

    // Setters for saturation state.
    void ClearSat(int index) { saturated_[index] = kNotSaturated; }

    void SetSignedSat(int index, bool positive) {
        SetSatFlag(index, positive ? kSignedSatPositive : kSignedSatNegative);
    }

    void SetUnsignedSat(int index, bool positive) {
        SetSatFlag(index, positive ? kUnsignedSatPositive : kUnsignedSatNegative);
    }

    void SetSatFlag(int index, Saturation sat) {
        saturated_[index] = static_cast<Saturation>(saturated_[index] | sat);
        VIXL_ASSERT((sat & kUnsignedSatMask) != kUnsignedSatUndefined);
        VIXL_ASSERT((sat & kSignedSatMask) != kSignedSatUndefined);
    }

    // Saturate lanes of a vector based on saturation state.
    LogicVRegister& SignedSaturate(VectorFormat vform) {
        for (int i = 0; i < LaneCountFromFormat(vform); i++) {
            Saturation sat = GetSignedSaturation(i);
            if (sat == kSignedSatPositive) {
                SetInt(vform, i, MaxIntFromFormat(vform));
            } else if (sat == kSignedSatNegative) {
                SetInt(vform, i, MinIntFromFormat(vform));
            }
        }
        return *this;
    }

    LogicVRegister& UnsignedSaturate(VectorFormat vform) {
        for (int i = 0; i < LaneCountFromFormat(vform); i++) {
            Saturation sat = GetUnsignedSaturation(i);
            if (sat == kUnsignedSatPositive) {
                SetUint(vform, i, MaxUintFromFormat(vform));
            } else if (sat == kUnsignedSatNegative) {
                SetUint(vform, i, 0);
            }
        }
        return *this;
    }

    // Getter for rounding state.
    bool GetRounding(int index) { return round_[index]; }

    // Setter for rounding state.
    void SetRounding(int index, bool round) { round_[index] = round; }

    // Round lanes of a vector based on rounding state.
    LogicVRegister& Round(VectorFormat vform) {
        for (int i = 0; i < LaneCountFromFormat(vform); i++) {
            SetInt(vform, i, Int(vform, i) + (GetRounding(i) ? 1 : 0));
        }
        return *this;
    }

    // Unsigned halve lanes of a vector, and use the saturation state to set the
    // top bit.
    LogicVRegister& Uhalve(VectorFormat vform) {
        for (int i = 0; i < LaneCountFromFormat(vform); i++) {
            uint64_t val = Uint(vform, i);
            SetRounding(i, (val & 1) == 1);
            val >>= 1;
            if (GetUnsignedSaturation(i) != kNotSaturated) {
                // If the operation causes unsigned saturation, the bit shifted into the
                // most significant bit must be set.
                val |= (MaxUintFromFormat(vform) >> 1) + 1;
            }
            SetInt(vform, i, val);
        }
        return *this;
    }

    // Signed halve lanes of a vector, and use the carry state to set the top bit.
    LogicVRegister& Halve(VectorFormat vform) {
        for (int i = 0; i < LaneCountFromFormat(vform); i++) {
            int64_t val = Int(vform, i);
            SetRounding(i, (val & 1) == 1);
            val >>= 1;
            if (GetSignedSaturation(i) != kNotSaturated) {
                // If the operation causes signed saturation, the sign bit must be
                // inverted.
                val ^= (MaxUintFromFormat(vform) >> 1) + 1;
            }
            SetInt(vform, i, val);
        }
        return *this;
    }

private:
    SimVRegister& register_;

    // Allocate one saturation state entry per lane; largest register is type Q,
    // and lanes can be a minimum of one byte wide.
    Saturation saturated_[kQRegSizeInBytes];

    // Allocate one rounding state entry per lane.
    bool round_[kQRegSizeInBytes];
};

} // namespace vixl

#endif /* include guard */