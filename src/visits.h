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

} // namespace Kraken

#endif /* include guard */