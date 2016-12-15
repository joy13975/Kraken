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

// Below macro is from decoder-a64.h of vixl

#ifndef _VISITS_H_
#define _VISITS_H_

#define VISITOR_LIST_THAT_RETURN(V)     \
  V(PCRelAddressing)                    \
  V(AddSubImmediate)                    \
  V(LogicalImmediate)                   \
  V(MoveWideImmediate)                  \
  V(Bitfield)                           \
  V(Extract)                            \
  V(UnconditionalBranch)                \
  V(UnconditionalBranchToRegister)      \
  V(CompareBranch)                      \
  V(TestBranch)                         \
  V(ConditionalBranch)                  \
  V(System)                             \
  V(Exception)                          \
  V(LoadStorePairPostIndex)             \
  V(LoadStorePairOffset)                \
  V(LoadStorePairPreIndex)              \
  V(LoadStorePairNonTemporal)           \
  V(LoadLiteral)                        \
  V(LoadStoreUnscaledOffset)            \
  V(LoadStorePostIndex)                 \
  V(LoadStorePreIndex)                  \
  V(LoadStoreRegisterOffset)            \
  V(LoadStoreUnsignedOffset)            \
  V(LoadStoreExclusive)                 \
  V(LogicalShifted)                     \
  V(AddSubShifted)                      \
  V(AddSubExtended)                     \
  V(AddSubWithCarry)                    \
  V(ConditionalCompareRegister)         \
  V(ConditionalCompareImmediate)        \
  V(ConditionalSelect)                  \
  V(DataProcessing1Source)              \
  V(DataProcessing2Source)              \
  V(DataProcessing3Source)              \
  V(FPCompare)                          \
  V(FPConditionalCompare)               \
  V(FPConditionalSelect)                \
  V(FPImmediate)                        \
  V(FPDataProcessing1Source)            \
  V(FPDataProcessing2Source)            \
  V(FPDataProcessing3Source)            \
  V(FPIntegerConvert)                   \
  V(FPFixedPointConvert)                \
  V(Crypto2RegSHA)                      \
  V(Crypto3RegSHA)                      \
  V(CryptoAES)                          \
  V(NEON2RegMisc)                       \
  V(NEON3Different)                     \
  V(NEON3Same)                          \
  V(NEONAcrossLanes)                    \
  V(NEONByIndexedElement)               \
  V(NEONCopy)                           \
  V(NEONExtract)                        \
  V(NEONLoadStoreMultiStruct)           \
  V(NEONLoadStoreMultiStructPostIndex)  \
  V(NEONLoadStoreSingleStruct)          \
  V(NEONLoadStoreSingleStructPostIndex) \
  V(NEONModifiedImmediate)              \
  V(NEONScalar2RegMisc)                 \
  V(NEONScalar3Diff)                    \
  V(NEONScalar3Same)                    \
  V(NEONScalarByIndexedElement)         \
  V(NEONScalarCopy)                     \
  V(NEONScalarPairwise)                 \
  V(NEONScalarShiftImmediate)           \
  V(NEONShiftImmediate)                 \
  V(NEONTable)                          \
  V(NEONPerm)

#define VISITOR_LIST_THAT_DONT_RETURN(V) \
  V(Unallocated)                         \
  V(Unimplemented)

#define VISITOR_LIST(V)       \
  VISITOR_LIST_THAT_RETURN(V) \
  VISITOR_LIST_THAT_DONT_RETURN(V)

// separate Kraken stuff from vixl
namespace Kraken
{

#define GENERATE_AC_ENUM(ITEM) AC_##ITEM,
typedef enum {
    VISITOR_LIST(GENERATE_AC_ENUM)
} ActionCode;
#undef GENERATE_AC_ENUM

#define GENERATE_AC_STRING(STRING) #STRING,
static const char *ActionCodeString[] = {
    VISITOR_LIST(GENERATE_AC_STRING)
};
#undef GENERATE_AC_STRING

static const short ActionCodeCycles[] = {
    1, // PCRelAddressing
    1, // AddSubImmediate
    1, // LogicalImmediate
    1, // MoveWideImmediate
    1, // Bitfield
    1, // Extract
    1, // UnconditionalBranch
    1, // UnconditionalBranchToRegister
    1, // CompareBranch
    1, // TestBranch
    1, // ConditionalBranch
    1, // System
    1, // Exception
    5, // LoadStorePairPostIndex
    5, // LoadStorePairOffset
    5, // LoadStorePairPreIndex
    4, // LoadStorePairNonTemporal
    4, // LoadLiteral
    4, // LoadStoreUnscaledOffset
    4, // LoadStorePostIndex
    4, // LoadStorePreIndex
    4, // LoadStoreRegisterOffset
    4, // LoadStoreUnsignedOffset
    4, // LoadStoreExclusive
    5, // LogicalShifted
    2, // AddSubShifted
    2, // AddSubExtended
    1, // AddSubWithCarry
    1, // ConditionalCompareRegister
    1, // ConditionalCompareImmediate
    1, // ConditionalSelect
    1, // DataProcessing1Source
    5, // DataProcessing2Source
    9, // DataProcessing3Source //mixed 6~10
    3, // FPCompare
    6, // FPConditionalCompare
    3, // FPConditionalSelect
    3, // FPImmediate
    10, // FPDataProcessing1Source 3 ~ 19
    5, // FPDataProcessing2Source
    9, // FPDataProcessing3Source
    5, // FPIntegerConvert
    10, // FPFixedPointConvert
    100, // Crypto2RegSHA   // Unimplemented
    100, // Crypto3RegSHA   // Unimplemented
    100, // CryptoAES       // Unimplemented
    1, // NEON2RegMisc
    1, // NEON3Different
    1, // NEON3Same
    1, // NEONAcrossLanes
    1, // NEONByIndexedElement
    1, // NEONCopy
    1, // NEONExtract
    3, // NEONLoadStoreMultiStruct
    3, // NEONLoadStoreMultiStructPostIndex
    2, // NEONLoadStoreSingleStruct
    2, // NEONLoadStoreSingleStructPostIndex
    1, // NEONModifiedImmediate
    1, // NEONScalar2RegMisc
    10, // NEONScalar3Diff
    10, // NEONScalar3Same
    20, // NEONScalarByIndexedElement
    1, // NEONScalarCopy
    1, // NEONScalarPairwise
    1, // NEONScalarShiftImmediate
    1, // NEONShiftImmediate
    1, // NEONTable
    1// NEONPerm
};

} // namespace Kraken

#endif /* include guard */