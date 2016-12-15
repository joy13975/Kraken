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

#ifndef _DECODER_VISITOR_A64_H_
#define _DECODER_VISITOR_A64_H_

#include "visits.h"

namespace vixl
{

// The Visitor interface. Disassembler and simulator (and other tools)
// must provide implementations for all of these functions.
class DecoderVisitor {
public:
    enum VisitorConstness { kConstVisitor, kNonConstVisitor };
    explicit DecoderVisitor(VisitorConstness constness = kConstVisitor)
        : constness_(constness) {}

    virtual ~DecoderVisitor() {}

#define DECLARE(A) virtual void Visit##A(const Instruction* instr) = 0;
    VISITOR_LIST(DECLARE)
#undef DECLARE

    bool IsConstVisitor() const { return constness_ == kConstVisitor; }
    Instruction* MutableInstruction(const Instruction* instr) {
        VIXL_ASSERT(!IsConstVisitor());
        return const_cast<Instruction*>(instr);
    }

private:
    const VisitorConstness constness_;
};

} // namespace vixl

#endif /* include guard */