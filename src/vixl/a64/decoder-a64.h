// Copyright 2014, ARM Limited
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

#ifndef VIXL_A64_DECODER_A64_H_
#define VIXL_A64_DECODER_A64_H_

#include <list>

#include "vixl/globals.h"
#include "vixl/a64/instructions-a64.h"

#include "visits.h"
#include "component_base.h"
#include "util.h"
#include "fetcher.h"

namespace Kraken
{
class Fetcher;
}

#define DECODER_BUFFER_SIZE 32

namespace vixl
{

class Decoder : public Kraken::ComponentBase {

protected:
    virtual void hardResetComponent();
    virtual void softResetComponent();
    virtual void updateComponent();

public:
    const Instruction * consumeInstr();
    const Instruction * peekInstr() { return buffer.front().instr; }

    void setFetcher(Kraken::Fetcher * _fetcher) {
        fetcher = _fetcher;
        connect((ComponentBase*) _fetcher, this);
    }

    Kraken::DecodedInstr consumeDecInstr();

    virtual void computeComponent() final;

    // Top-level wrappers around the actual decoding function.
    // void Decode(const Instruction* instr) {
    //     std::list<DecoderVisitor*>::iterator it;
    //     for (it = visitors_.begin(); it != visitors_.end(); it++) {
    //         VIXL_ASSERT((*it)->IsConstVisitor());
    //     }
    //     DecodeInstruction(instr);
    // }

    static bool isBranch(const Instruction* instr)
    {
        if (!instr)
            return false;

        const Kraken::ActionCode ac = DecodeInstruction(instr);
        switch (ac)
        {
        case Kraken::AC_UnconditionalBranch:
        case Kraken::AC_UnconditionalBranchToRegister:
        case Kraken::AC_CompareBranch:
        case Kraken::AC_TestBranch:
        case Kraken::AC_ConditionalBranch:
            return true;
        default:
            return false;
        }
    }

    Decoder() {}

    // Register a new visitor class with the decoder.
    // Decode() will call the corresponding visitor method from all registered
    // visitor classes when decoding reaches the leaf node of the instruction
    // decode tree.
    // Visitors are called in order.
    // A visitor can be registered multiple times.
    //
    //   d.AppendVisitor(V1);
    //   d.AppendVisitor(V2);
    //   d.PrependVisitor(V2);
    //   d.AppendVisitor(V3);
    //
    //   d.Decode(i);
    //
    // will call in order visitor methods in V2, V1, V2, V3.
    void AppendVisitor(DecoderVisitor* visitor);
    void PrependVisitor(DecoderVisitor* visitor);
    // These helpers register `new_visitor` before or after the first instance of
    // `registered_visiter` in the list.
    // So if
    //   V1, V2, V1, V2
    // are registered in this order in the decoder, calls to
    //   d.InsertVisitorAfter(V3, V1);
    //   d.InsertVisitorBefore(V4, V2);
    // will yield the order
    //   V1, V3, V4, V2, V1, V2
    //
    // For more complex modifications of the order of registered visitors, one can
    // directly access and modify the list of visitors via the `visitors()'
    // accessor.
    void InsertVisitorBefore(DecoderVisitor* new_visitor,
                             DecoderVisitor* registered_visitor);
    void InsertVisitorAfter(DecoderVisitor* new_visitor,
                            DecoderVisitor* registered_visitor);

    // Remove all instances of a previously registered visitor class from the list
    // of visitors stored by the decoder.
    void RemoveVisitor(DecoderVisitor* visitor);

#define DECLARE(A) static Kraken::ActionCode Visit##A(const Instruction* instr);
    VISITOR_LIST(DECLARE)
#undef DECLARE


    std::list<DecoderVisitor*>* visitors() { return &visitors_; }

private:
    Kraken::Fetcher * fetcher = 0;

    std::deque<Kraken::DecodedInstr> tmpBuffer;
    std::deque<Kraken::DecodedInstr> buffer;

    // std::deque<InstrPtr> tmpBuffer;
    // std::deque<InstrPtr> buffer;

    // Decodes an instruction and calls the visitor functions registered with the
    // Decoder class.
    static Kraken::ActionCode DecodeInstruction(const Instruction* instr);

    // Decode the PC relative addressing instruction, and call the corresponding
    // visitors.
    // On entry, instruction bits 27:24 = 0x0.
    static Kraken::ActionCode DecodePCRelAddressing(const Instruction* instr);

    // Decode the add/subtract immediate instruction, and call the correspoding
    // visitors.
    // On entry, instruction bits 27:24 = 0x1.
    static Kraken::ActionCode DecodeAddSubImmediate(const Instruction* instr);

    // Decode the branch, system command, and exception generation parts of
    // the instruction tree, and call the corresponding visitors.
    // On entry, instruction bits 27:24 = {0x4, 0x5, 0x6, 0x7}.
    static Kraken::ActionCode DecodeBranchSystemException(const Instruction* instr);

    // Decode the load and store parts of the instruction tree, and call
    // the corresponding visitors.
    // On entry, instruction bits 27:24 = {0x8, 0x9, 0xC, 0xD}.
    static Kraken::ActionCode DecodeLoadStore(const Instruction* instr);

    // Decode the logical immediate and move wide immediate parts of the
    // instruction tree, and call the corresponding visitors.
    // On entry, instruction bits 27:24 = 0x2.
    static Kraken::ActionCode DecodeLogical(const Instruction* instr);

    // Decode the bitfield and extraction parts of the instruction tree,
    // and call the corresponding visitors.
    // On entry, instruction bits 27:24 = 0x3.
    static Kraken::ActionCode DecodeBitfieldExtract(const Instruction* instr);

    // Decode the data processing parts of the instruction tree, and call the
    // corresponding visitors.
    // On entry, instruction bits 27:24 = {0x1, 0xA, 0xB}.
    static Kraken::ActionCode DecodeDataProcessing(const Instruction* instr);

    // Decode the floating point parts of the instruction tree, and call the
    // corresponding visitors.
    // On entry, instruction bits 27:24 = {0xE, 0xF}.
    static Kraken::ActionCode DecodeFP(const Instruction* instr);

    // Decode the Advanced SIMD (NEON) load/store part of the instruction tree,
    // and call the corresponding visitors.
    // On entry, instruction bits 29:25 = 0x6.
    static Kraken::ActionCode DecodeNEONLoadStore(const Instruction* instr);

    // Decode the Advanced SIMD (NEON) vector data processing part of the
    // instruction tree, and call the corresponding visitors.
    // On entry, instruction bits 28:25 = 0x7.
    static Kraken::ActionCode DecodeNEONVectorDataProcessing(const Instruction* instr);

    // Decode the Advanced SIMD (NEON) scalar data processing part of the
    // instruction tree, and call the corresponding visitors.
    // On entry, instruction bits 28:25 = 0xF.
    static Kraken::ActionCode DecodeNEONScalarDataProcessing(const Instruction* instr);

private:
    // Visitors are registered in a list.
    std::list<DecoderVisitor*> visitors_;
};

}  // namespace vixl

#endif  // VIXL_A64_DECODER_A64_H_
