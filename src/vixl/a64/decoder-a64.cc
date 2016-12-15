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

#include "vixl/globals.h"
#include "vixl/utils.h"
#include "vixl/a64/decoder-a64.h"
#include "util.h"

namespace vixl {

void Decoder::hardResetComponent()
{
    fetcher = 0;
}

void Decoder::softResetComponent()
{
    dbg("   Decoder soft reset\n");
    decodedAction = Kraken::AC_Unallocated;
    cachedAction = Kraken::AC_Unallocated;
    decodedInstr = 0;
    cachedInstr = 0;
}
void Decoder::computeComponent()
{
    if (!fetcher)
        die("Decoder's fetcher pointer is not set\n");

    Decode(fetcher->consumeInstr());
}
void Decoder::updateComponent()
{
    cachedAction = decodedAction;
    dbg("   Decode cachedAction <- %d\n", decodedAction);
    cachedInstr = decodedInstr;
    dbg("   Decode cachedInstr <- %p\n", decodedInstr);
}

Kraken::ActionCode Decoder::DecodeInstruction(const Instruction* instr) {
    if (instr->Bits(28, 27) == 0) {
        return VisitUnallocated(instr);
    } else {
        switch (instr->Bits(27, 24)) {
        // 0:   PC relative addressing.
        case 0x0:
            // wrn("DecodePCRelAddressing()\n");
            return DecodePCRelAddressing(instr);

        // 1:   Add/sub immediate.
        case 0x1:
            // wrn("DecodeAddSubImmediate()\n");
            return DecodeAddSubImmediate(instr);

        // A:   Logical shifted register.
        //      Add/sub with carry.
        //      Conditional compare register.
        //      Conditional compare immediate.
        //      Conditional select.
        //      Data processing 1 source.
        //      Data processing 2 source.
        // B:   Add/sub shifted register.
        //      Add/sub extended register.
        //      Data processing 3 source.
        case 0xA:
        case 0xB:
            // wrn("DecodeDataProcessing()\n");
            return DecodeDataProcessing(instr);

        // 2:   Logical immediate.
        //      Move wide immediate.
        case 0x2:
            // wrn("DecodeLogical()\n");
            return DecodeLogical(instr);

        // 3:   Bitfield.
        //      Extract.
        case 0x3:
            // wrn("DecodeBitfieldExtract()\n");
            return DecodeBitfieldExtract(instr);

        // 4:   Unconditional branch immediate.
        //      Exception generation.
        //      Compare and branch immediate.
        // 5:   Compare and branch immediate.
        //      Conditional branch.
        //      System.
        // 6,7: Unconditional branch.
        //      Test and branch immediate.
        case 0x4:
        case 0x5:
        case 0x6:
        case 0x7:
            // wrn("DecodeBranchSystemException()\n");
            return DecodeBranchSystemException(instr);

        // 8,9: Load/store register pair post-index.
        //      Load register literal.
        //      Load/store register unscaled immediate.
        //      Load/store register immediate post-index.
        //      Load/store register immediate pre-index.
        //      Load/store register offset.
        //      Load/store exclusive.
        // C,D: Load/store register pair offset.
        //      Load/store register pair pre-index.
        //      Load/store register unsigned immediate.
        //      Advanced SIMD.
        case 0x8:
        case 0x9:
        case 0xC:
        case 0xD:
            // wrn("DecodeLoadStore()\n");
            return DecodeLoadStore(instr);

        // E:   FP fixed point conversion.
        //      FP integer conversion.
        //      FP data processing 1 source.
        //      FP compare.
        //      FP immediate.
        //      FP data processing 2 source.
        //      FP conditional compare.
        //      FP conditional select.
        //      Advanced SIMD.
        // F:   FP data processing 3 source.
        //      Advanced SIMD.
        case 0xE:
        case 0xF:
            // wrn("DecodeFP()\n");
            return DecodeFP(instr);
        }
    }
    wrn("Unknown instruction: %8x\n", instr->InstructionBits());
    return Kraken::AC_Unallocated;
}

void Decoder::AppendVisitor(DecoderVisitor* new_visitor) {
    visitors_.push_back(new_visitor);
}


void Decoder::PrependVisitor(DecoderVisitor* new_visitor) {
    visitors_.push_front(new_visitor);
}


void Decoder::InsertVisitorBefore(DecoderVisitor* new_visitor,
                                  DecoderVisitor* registered_visitor) {
    std::list<DecoderVisitor*>::iterator it;
    for (it = visitors_.begin(); it != visitors_.end(); it++) {
        if (*it == registered_visitor) {
            visitors_.insert(it, new_visitor);
            return;
        }
    }
    // We reached the end of the list. The last element must be
    // registered_visitor.
    VIXL_ASSERT(*it == registered_visitor);
    visitors_.insert(it, new_visitor);
}


void Decoder::InsertVisitorAfter(DecoderVisitor* new_visitor,
                                 DecoderVisitor* registered_visitor) {
    std::list<DecoderVisitor*>::iterator it;
    for (it = visitors_.begin(); it != visitors_.end(); it++) {
        if (*it == registered_visitor) {
            it++;
            visitors_.insert(it, new_visitor);
            return;
        }
    }
    // We reached the end of the list. The last element must be
    // registered_visitor.
    VIXL_ASSERT(*it == registered_visitor);
    visitors_.push_back(new_visitor);
}


void Decoder::RemoveVisitor(DecoderVisitor* visitor) {
    visitors_.remove(visitor);
}


Kraken::ActionCode Decoder::DecodePCRelAddressing(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(27, 24) == 0x0);
    // We know bit 28 is set, as <b28:b27> = 0 is filtered out at the top level
    // decode.
    VIXL_ASSERT(instr->Bit(28) == 0x1);
    return Kraken::AC_PCRelAddressing;
}


Kraken::ActionCode Decoder::DecodeBranchSystemException(const Instruction* instr) {
    VIXL_ASSERT((instr->Bits(27, 24) == 0x4) || (instr->Bits(27, 24) == 0x5) ||
                (instr->Bits(27, 24) == 0x6) || (instr->Bits(27, 24) == 0x7));

    switch (instr->Bits(31, 29)) {
    case 0:
    case 4: {
        return Kraken::AC_UnconditionalBranch;
        break;
    }
    case 1:
    case 5: {
        if (instr->Bit(25) == 0) {
            return Kraken::AC_CompareBranch;
        } else {
            return Kraken::AC_TestBranch;
        }
        break;
    }
    case 2: {
        if (instr->Bit(25) == 0) {
            if ((instr->Bit(24) == 0x1) ||
                    (instr->Mask(0x01000010) == 0x00000010)) {
                return Kraken::AC_Unallocated;
            } else {
                return Kraken::AC_ConditionalBranch;
            }
        } else {
            return Kraken::AC_Unallocated;
        }
        break;
    }
    case 6: {
        if (instr->Bit(25) == 0) {
            if (instr->Bit(24) == 0) {
                if ((instr->Bits(4, 2) != 0) ||
                        (instr->Mask(0x00E0001D) == 0x00200001) ||
                        (instr->Mask(0x00E0001D) == 0x00400001) ||
                        (instr->Mask(0x00E0001E) == 0x00200002) ||
                        (instr->Mask(0x00E0001E) == 0x00400002) ||
                        (instr->Mask(0x00E0001C) == 0x00600000) ||
                        (instr->Mask(0x00E0001C) == 0x00800000) ||
                        (instr->Mask(0x00E0001F) == 0x00A00000) ||
                        (instr->Mask(0x00C0001C) == 0x00C00000)) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_Exception;
                }
            } else {
                if (instr->Bits(23, 22) == 0) {
                    const Instr masked_003FF0E0 = instr->Mask(0x003FF0E0);
                    if ((instr->Bits(21, 19) == 0x4) ||
                            (masked_003FF0E0 == 0x00033000) ||
                            (masked_003FF0E0 == 0x003FF020) ||
                            (masked_003FF0E0 == 0x003FF060) ||
                            (masked_003FF0E0 == 0x003FF0E0) ||
                            (instr->Mask(0x00388000) == 0x00008000) ||
                            (instr->Mask(0x0038E000) == 0x00000000) ||
                            (instr->Mask(0x0039E000) == 0x00002000) ||
                            (instr->Mask(0x003AE000) == 0x00002000) ||
                            (instr->Mask(0x003CE000) == 0x00042000) ||
                            (instr->Mask(0x003FFFC0) == 0x000320C0) ||
                            (instr->Mask(0x003FF100) == 0x00032100) ||
                            (instr->Mask(0x003FF200) == 0x00032200) ||
                            (instr->Mask(0x003FF400) == 0x00032400) ||
                            (instr->Mask(0x003FF800) == 0x00032800) ||
                            (instr->Mask(0x0038F000) == 0x00005000) ||
                            (instr->Mask(0x0038E000) == 0x00006000)) {
                        return Kraken::AC_Unallocated;
                    } else {
                        return Kraken::AC_System;
                    }
                } else {
                    return Kraken::AC_Unallocated;
                }
            }
        } else {
            if ((instr->Bit(24) == 0x1) || (instr->Bits(20, 16) != 0x1F) ||
                    (instr->Bits(15, 10) != 0) || (instr->Bits(4, 0) != 0) ||
                    (instr->Bits(24, 21) == 0x3) || (instr->Bits(24, 22) == 0x3)) {
                return Kraken::AC_Unallocated;
            } else {
                return Kraken::AC_UnconditionalBranchToRegister;
            }
        }
        break;
    }
    case 3:
    case 7: {
        return Kraken::AC_Unallocated;
        break;
    }
    }
}


Kraken::ActionCode Decoder::DecodeLoadStore(const Instruction* instr) {
    VIXL_ASSERT((instr->Bits(27, 24) == 0x8) || (instr->Bits(27, 24) == 0x9) ||
                (instr->Bits(27, 24) == 0xC) || (instr->Bits(27, 24) == 0xD));
    // TODO(all): rearrange the tree to integrate this branch.
    if ((instr->Bit(28) == 0) && (instr->Bit(29) == 0) && (instr->Bit(26) == 1)) {
        return DecodeNEONLoadStore(instr);
    }

    if (instr->Bit(24) == 0) {
        if (instr->Bit(28) == 0) {
            if (instr->Bit(29) == 0) {
                if (instr->Bit(26) == 0) {
                    return Kraken::AC_LoadStoreExclusive;
                } else {
                    VIXL_UNREACHABLE();
                }
            } else {
                if ((instr->Bits(31, 30) == 0x3) ||
                        (instr->Mask(0xC4400000) == 0x40000000)) {
                    return Kraken::AC_Unallocated;
                } else {
                    if (instr->Bit(23) == 0) {
                        if (instr->Mask(0xC4400000) == 0xC0400000) {
                            return Kraken::AC_Unallocated;
                        } else {
                            return Kraken::AC_LoadStorePairNonTemporal;
                        }
                    } else {
                        return Kraken::AC_LoadStorePairPostIndex;
                    }
                }
            }
        } else {
            if (instr->Bit(29) == 0) {
                if (instr->Mask(0xC4000000) == 0xC4000000) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_LoadLiteral;
                }
            } else {
                if ((instr->Mask(0x84C00000) == 0x80C00000) ||
                        (instr->Mask(0x44800000) == 0x44800000) ||
                        (instr->Mask(0x84800000) == 0x84800000)) {
                    return Kraken::AC_Unallocated;
                } else {
                    if (instr->Bit(21) == 0) {
                        switch (instr->Bits(11, 10)) {
                        case 0: {
                            return Kraken::AC_LoadStoreUnscaledOffset;
                            break;
                        }
                        case 1: {
                            if (instr->Mask(0xC4C00000) == 0xC0800000) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_LoadStorePostIndex;
                            }
                            break;
                        }
                        case 2: {
                            err("TODO: Kraken::AC_LoadStoreRegisterOffsetUnpriv\n");
                            return Kraken::AC_Unimplemented;
                            break;
                        }
                        case 3: {
                            if (instr->Mask(0xC4C00000) == 0xC0800000) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_LoadStorePreIndex;
                            }
                            break;
                        }
                        }
                    } else {
                        if (instr->Bits(11, 10) == 0x2) {
                            if (instr->Bit(14) == 0) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_LoadStoreRegisterOffset;
                            }
                        } else {
                            return Kraken::AC_Unallocated;
                        }
                    }
                }
            }
        }
    } else {
        if (instr->Bit(28) == 0) {
            if (instr->Bit(29) == 0) {
                return Kraken::AC_Unallocated;
            } else {
                if ((instr->Bits(31, 30) == 0x3) ||
                        (instr->Mask(0xC4400000) == 0x40000000)) {
                    return Kraken::AC_Unallocated;
                } else {
                    if (instr->Bit(23) == 0) {
                        return Kraken::AC_LoadStorePairOffset;
                    } else {
                        return Kraken::AC_LoadStorePairPreIndex;
                    }
                }
            }
        } else {
            if (instr->Bit(29) == 0) {
                return Kraken::AC_Unallocated;
            } else {
                if ((instr->Mask(0x84C00000) == 0x80C00000) ||
                        (instr->Mask(0x44800000) == 0x44800000) ||
                        (instr->Mask(0x84800000) == 0x84800000)) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_LoadStoreUnsignedOffset;
                }
            }
        }
    }
}


Kraken::ActionCode Decoder::DecodeLogical(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(27, 24) == 0x2);

    if (instr->Mask(0x80400000) == 0x00400000) {
        return Kraken::AC_Unallocated;
    } else {
        if (instr->Bit(23) == 0) {
            return Kraken::AC_LogicalImmediate;
        } else {
            if (instr->Bits(30, 29) == 0x1) {
                return Kraken::AC_Unallocated;
            } else {
                return Kraken::AC_MoveWideImmediate;
            }
        }
    }
}


Kraken::ActionCode Decoder::DecodeBitfieldExtract(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(27, 24) == 0x3);

    if ((instr->Mask(0x80400000) == 0x80000000) ||
            (instr->Mask(0x80400000) == 0x00400000) ||
            (instr->Mask(0x80008000) == 0x00008000)) {
        return Kraken::AC_Unallocated;
    } else if (instr->Bit(23) == 0) {
        if ((instr->Mask(0x80200000) == 0x00200000) ||
                (instr->Mask(0x60000000) == 0x60000000)) {
            return Kraken::AC_Unallocated;
        } else {
            return Kraken::AC_Bitfield;
        }
    } else {
        if ((instr->Mask(0x60200000) == 0x00200000) ||
                (instr->Mask(0x60000000) != 0x00000000)) {
            return Kraken::AC_Unallocated;
        } else {
            return Kraken::AC_Extract;
        }
    }
}


Kraken::ActionCode Decoder::DecodeAddSubImmediate(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(27, 24) == 0x1);
    if (instr->Bit(23) == 1) {
        return Kraken::AC_Unallocated;
    } else {
        return Kraken::AC_AddSubImmediate;
    }
}


Kraken::ActionCode Decoder::DecodeDataProcessing(const Instruction* instr) {
    VIXL_ASSERT((instr->Bits(27, 24) == 0xA) || (instr->Bits(27, 24) == 0xB));

    if (instr->Bit(24) == 0) {
        if (instr->Bit(28) == 0) {
            if (instr->Mask(0x80008000) == 0x00008000) {
                return Kraken::AC_Unallocated;
            } else {
                return Kraken::AC_LogicalShifted;
            }
        } else {
            switch (instr->Bits(23, 21)) {
            case 0: {
                if (instr->Mask(0x0000FC00) != 0) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_AddSubWithCarry;
                }
                break;
            }
            case 2: {
                if ((instr->Bit(29) == 0) || (instr->Mask(0x00000410) != 0)) {
                    return Kraken::AC_Unallocated;
                } else {
                    if (instr->Bit(11) == 0) {
                        return Kraken::AC_ConditionalCompareRegister;
                    } else {
                        return Kraken::AC_ConditionalCompareImmediate;
                    }
                }
                break;
            }
            case 4: {
                if (instr->Mask(0x20000800) != 0x00000000) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_ConditionalSelect;
                }
                break;
            }
            case 6: {
                if (instr->Bit(29) == 0x1) {
                    return Kraken::AC_Unallocated;
                    VIXL_FALLTHROUGH();
                } else {
                    if (instr->Bit(30) == 0) {
                        if ((instr->Bit(15) == 0x1) || (instr->Bits(15, 11) == 0) ||
                                (instr->Bits(15, 12) == 0x1) ||
                                (instr->Bits(15, 12) == 0x3) ||
                                (instr->Bits(15, 13) == 0x3) ||
                                (instr->Mask(0x8000EC00) == 0x00004C00) ||
                                (instr->Mask(0x8000E800) == 0x80004000) ||
                                (instr->Mask(0x8000E400) == 0x80004000)) {
                            return Kraken::AC_Unallocated;
                        } else {
                            return Kraken::AC_DataProcessing2Source;
                        }
                    } else {
                        if ((instr->Bit(13) == 1) || (instr->Bits(20, 16) != 0) ||
                                (instr->Bits(15, 14) != 0) ||
                                (instr->Mask(0xA01FFC00) == 0x00000C00) ||
                                (instr->Mask(0x201FF800) == 0x00001800)) {
                            return Kraken::AC_Unallocated;
                        } else {
                            return Kraken::AC_DataProcessing1Source;
                        }
                    }
                    break;
                }
            }
            case 1:
            case 3:
            case 5:
            case 7:
                return Kraken::AC_Unallocated;
                break;
            }
        }
    } else {
        if (instr->Bit(28) == 0) {
            if (instr->Bit(21) == 0) {
                if ((instr->Bits(23, 22) == 0x3) ||
                        (instr->Mask(0x80008000) == 0x00008000)) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_AddSubShifted;
                }
            } else {
                if ((instr->Mask(0x00C00000) != 0x00000000) ||
                        (instr->Mask(0x00001400) == 0x00001400) ||
                        (instr->Mask(0x00001800) == 0x00001800)) {
                    return Kraken::AC_Unallocated;
                } else {
                    return Kraken::AC_AddSubExtended;
                }
            }
        } else {
            if ((instr->Bit(30) == 0x1) || (instr->Bits(30, 29) == 0x1) ||
                    (instr->Mask(0xE0600000) == 0x00200000) ||
                    (instr->Mask(0xE0608000) == 0x00400000) ||
                    (instr->Mask(0x60608000) == 0x00408000) ||
                    (instr->Mask(0x60E00000) == 0x00E00000) ||
                    (instr->Mask(0x60E00000) == 0x00800000) ||
                    (instr->Mask(0x60E00000) == 0x00600000)) {
                return Kraken::AC_Unallocated;
            } else {
                return Kraken::AC_DataProcessing3Source;
            }
        }
    }
}


Kraken::ActionCode Decoder::DecodeFP(const Instruction* instr) {
    VIXL_ASSERT((instr->Bits(27, 24) == 0xE) || (instr->Bits(27, 24) == 0xF));
    if (instr->Bit(28) == 0) {
        return DecodeNEONVectorDataProcessing(instr);
    } else {
        if (instr->Bits(31, 30) == 0x3) {
            return Kraken::AC_Unallocated;
        } else if (instr->Bits(31, 30) == 0x1) {
            return DecodeNEONScalarDataProcessing(instr);
        } else {
            if (instr->Bit(29) == 0) {
                if (instr->Bit(24) == 0) {
                    if (instr->Bit(21) == 0) {
                        if ((instr->Bit(23) == 1) || (instr->Bit(18) == 1) ||
                                (instr->Mask(0x80008000) == 0x00000000) ||
                                (instr->Mask(0x000E0000) == 0x00000000) ||
                                (instr->Mask(0x000E0000) == 0x000A0000) ||
                                (instr->Mask(0x00160000) == 0x00000000) ||
                                (instr->Mask(0x00160000) == 0x00120000)) {
                            return Kraken::AC_Unallocated;
                        } else {
                            return Kraken::AC_FPFixedPointConvert;
                        }
                    } else {
                        if (instr->Bits(15, 10) == 32) {
                            return Kraken::AC_Unallocated;
                        } else if (instr->Bits(15, 10) == 0) {
                            if ((instr->Bits(23, 22) == 0x3) ||
                                    (instr->Mask(0x000E0000) == 0x000A0000) ||
                                    (instr->Mask(0x000E0000) == 0x000C0000) ||
                                    (instr->Mask(0x00160000) == 0x00120000) ||
                                    (instr->Mask(0x00160000) == 0x00140000) ||
                                    (instr->Mask(0x20C40000) == 0x00800000) ||
                                    (instr->Mask(0x20C60000) == 0x00840000) ||
                                    (instr->Mask(0xA0C60000) == 0x80060000) ||
                                    (instr->Mask(0xA0C60000) == 0x00860000) ||
                                    (instr->Mask(0xA0C60000) == 0x00460000) ||
                                    (instr->Mask(0xA0CE0000) == 0x80860000) ||
                                    (instr->Mask(0xA0CE0000) == 0x804E0000) ||
                                    (instr->Mask(0xA0CE0000) == 0x000E0000) ||
                                    (instr->Mask(0xA0D60000) == 0x00160000) ||
                                    (instr->Mask(0xA0D60000) == 0x80560000) ||
                                    (instr->Mask(0xA0D60000) == 0x80960000)) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_FPIntegerConvert;
                            }
                        } else if (instr->Bits(14, 10) == 16) {
                            const Instr masked_A0DF8000 = instr->Mask(0xA0DF8000);
                            if ((instr->Mask(0x80180000) != 0) ||
                                    (masked_A0DF8000 == 0x00020000) ||
                                    (masked_A0DF8000 == 0x00030000) ||
                                    (masked_A0DF8000 == 0x00068000) ||
                                    (masked_A0DF8000 == 0x00428000) ||
                                    (masked_A0DF8000 == 0x00430000) ||
                                    (masked_A0DF8000 == 0x00468000) ||
                                    (instr->Mask(0xA0D80000) == 0x00800000) ||
                                    (instr->Mask(0xA0DE0000) == 0x00C00000) ||
                                    (instr->Mask(0xA0DF0000) == 0x00C30000) ||
                                    (instr->Mask(0xA0DC0000) == 0x00C40000)) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_FPDataProcessing1Source;
                            }
                        } else if (instr->Bits(13, 10) == 8) {
                            if ((instr->Bits(15, 14) != 0) || (instr->Bits(2, 0) != 0) ||
                                    (instr->Mask(0x80800000) != 0x00000000)) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_FPCompare;
                            }
                        } else if (instr->Bits(12, 10) == 4) {
                            if ((instr->Bits(9, 5) != 0) ||
                                    (instr->Mask(0x80800000) != 0x00000000)) {
                                return Kraken::AC_Unallocated;
                            } else {
                                return Kraken::AC_FPImmediate;
                            }
                        } else {
                            if (instr->Mask(0x80800000) != 0x00000000) {
                                return Kraken::AC_Unallocated;
                            } else {
                                switch (instr->Bits(11, 10)) {
                                case 1: {
                                    return Kraken::AC_FPConditionalCompare;
                                    break;
                                }
                                case 2: {
                                    if ((instr->Bits(15, 14) == 0x3) ||
                                            (instr->Mask(0x00009000) == 0x00009000) ||
                                            (instr->Mask(0x0000A000) == 0x0000A000)) {
                                        return Kraken::AC_Unallocated;
                                    } else {
                                        return Kraken::AC_FPDataProcessing2Source;
                                    }
                                    break;
                                }
                                case 3: {
                                    return Kraken::AC_FPConditionalSelect;
                                    break;
                                }
                                default:
                                    VIXL_UNREACHABLE();
                                }
                            }
                        }
                    }
                } else {
                    // Bit 30 == 1 has been handled earlier.
                    VIXL_ASSERT(instr->Bit(30) == 0);
                    if (instr->Mask(0xA0800000) != 0) {
                        return Kraken::AC_Unallocated;
                    } else {
                        return Kraken::AC_FPDataProcessing3Source;
                    }
                }
            } else {
                return Kraken::AC_Unallocated;
            }
        }
    }
}


Kraken::ActionCode Decoder::DecodeNEONLoadStore(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(29, 25) == 0x6);
    if (instr->Bit(31) == 0) {
        if ((instr->Bit(24) == 0) && (instr->Bit(21) == 1)) {
            return Kraken::AC_Unallocated;
        }

        if (instr->Bit(23) == 0) {
            if (instr->Bits(20, 16) == 0) {
                if (instr->Bit(24) == 0) {
                    return Kraken::AC_NEONLoadStoreMultiStruct;
                } else {
                    return Kraken::AC_NEONLoadStoreSingleStruct;
                }
            } else {
                return Kraken::AC_Unallocated;
            }
        } else {
            if (instr->Bit(24) == 0) {
                return Kraken::AC_NEONLoadStoreMultiStructPostIndex;
            } else {
                return Kraken::AC_NEONLoadStoreSingleStructPostIndex;
            }
        }
    } else {
        return Kraken::AC_Unallocated;
    }
}


Kraken::ActionCode Decoder::DecodeNEONVectorDataProcessing(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(28, 25) == 0x7);
    if (instr->Bit(31) == 0) {
        if (instr->Bit(24) == 0) {
            if (instr->Bit(21) == 0) {
                if (instr->Bit(15) == 0) {
                    if (instr->Bit(10) == 0) {
                        if (instr->Bit(29) == 0) {
                            if (instr->Bit(11) == 0) {
                                return Kraken::AC_NEONTable;
                            } else {
                                return Kraken::AC_NEONPerm;
                            }
                        } else {
                            return Kraken::AC_NEONExtract;
                        }
                    } else {
                        if (instr->Bits(23, 22) == 0) {
                            return Kraken::AC_NEONCopy;
                        } else {
                            return Kraken::AC_Unallocated;
                        }
                    }
                } else {
                    return Kraken::AC_Unallocated;
                }
            } else {
                if (instr->Bit(10) == 0) {
                    if (instr->Bit(11) == 0) {
                        return Kraken::AC_NEON3Different;
                    } else {
                        if (instr->Bits(18, 17) == 0) {
                            if (instr->Bit(20) == 0) {
                                if (instr->Bit(19) == 0) {
                                    return Kraken::AC_NEON2RegMisc;
                                } else {
                                    if (instr->Bits(30, 29) == 0x2) {
                                        return Kraken::AC_CryptoAES;
                                    } else {
                                        return Kraken::AC_Unallocated;
                                    }
                                }
                            } else {
                                if (instr->Bit(19) == 0) {
                                    return Kraken::AC_NEONAcrossLanes;
                                } else {
                                    return Kraken::AC_Unallocated;
                                }
                            }
                        } else {
                            return Kraken::AC_Unallocated;
                        }
                    }
                } else {
                    return Kraken::AC_NEON3Same;
                }
            }
        } else {
            if (instr->Bit(10) == 0) {
                return Kraken::AC_NEONByIndexedElement;
            } else {
                if (instr->Bit(23) == 0) {
                    if (instr->Bits(22, 19) == 0) {
                        return Kraken::AC_NEONModifiedImmediate;
                    } else {
                        return Kraken::AC_NEONShiftImmediate;
                    }
                } else {
                    return Kraken::AC_Unallocated;
                }
            }
        }
    } else {
        return Kraken::AC_Unallocated;
    }
}


Kraken::ActionCode Decoder::DecodeNEONScalarDataProcessing(const Instruction* instr) {
    VIXL_ASSERT(instr->Bits(28, 25) == 0xF);
    if (instr->Bit(24) == 0) {
        if (instr->Bit(21) == 0) {
            if (instr->Bit(15) == 0) {
                if (instr->Bit(10) == 0) {
                    if (instr->Bit(29) == 0) {
                        if (instr->Bit(11) == 0) {
                            return Kraken::AC_Crypto3RegSHA;
                        } else {
                            return Kraken::AC_Unallocated;
                        }
                    } else {
                        return Kraken::AC_Unallocated;
                    }
                } else {
                    if (instr->Bits(23, 22) == 0) {
                        return Kraken::AC_NEONScalarCopy;
                    } else {
                        return Kraken::AC_Unallocated;
                    }
                }
            } else {
                return Kraken::AC_Unallocated;
            }
        } else {
            if (instr->Bit(10) == 0) {
                if (instr->Bit(11) == 0) {
                    return Kraken::AC_NEONScalar3Diff;
                } else {
                    if (instr->Bits(18, 17) == 0) {
                        if (instr->Bit(20) == 0) {
                            if (instr->Bit(19) == 0) {
                                return Kraken::AC_NEONScalar2RegMisc;
                            } else {
                                if (instr->Bit(29) == 0) {
                                    return Kraken::AC_Crypto2RegSHA;
                                } else {
                                    return Kraken::AC_Unallocated;
                                }
                            }
                        } else {
                            if (instr->Bit(19) == 0) {
                                return Kraken::AC_NEONScalarPairwise;
                            } else {
                                return Kraken::AC_Unallocated;
                            }
                        }
                    } else {
                        return Kraken::AC_Unallocated;
                    }
                }
            } else {
                return Kraken::AC_NEONScalar3Same;
            }
        }
    } else {
        if (instr->Bit(10) == 0) {
            return Kraken::AC_NEONScalarByIndexedElement;
        } else {
            if (instr->Bit(23) == 0) {
                return Kraken::AC_NEONScalarShiftImmediate;
            } else {
                return Kraken::AC_Unallocated;
            }
        }
    }
}


// #define DEFINE_VISITOR_CALLERS(A)                               \
//   Kraken::ActionCode Decoder::Visit##A(const Instruction* instr) {            \
//     VIXL_ASSERT(instr->Mask(A##FMask) == A##Fixed);             \
//     std::list<DecoderVisitor*>::iterator it;                    \
//     for (it = visitors_.begin(); it != visitors_.end(); it++) { \
//       (*it)->Visit##A(instr);                                   \
//     }                                                           \
//   }
#define DEFINE_VISITOR_CALLERS(A)                               \
  Kraken::ActionCode Decoder::Visit##A(const Instruction* instr) {            \
    VIXL_ASSERT(instr->Mask(A##FMask) == A##Fixed);             \
    std::list<DecoderVisitor*>::iterator it;                    \
  }
VISITOR_LIST(DEFINE_VISITOR_CALLERS)
#undef DEFINE_VISITOR_CALLERS
}  // namespace vixl
