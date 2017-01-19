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

#ifndef _LOGIC_MEMORY_A64_H_
#define _LOGIC_MEMORY_A64_H_
#include <tuple>

#include "types.h"

namespace vixl
{
static Kraken::RobEntry     ** memRobCursorPtr;
static bool                 * memDepCheckModePtr;

typedef std::vector<std::tuple<const char *, const size_t>> RangeList;
static RangeList readRanges;
static RangeList writeRanges;

// Representation of memory, with typed getters and setters for access.
class Memory {
public:
    template <typename T>
    static T AddressUntag(T address) {
        // Cast the address using a C-style cast. A reinterpret_cast would be
        // appropriate, but it can't cast one integral type to another.
        uint64_t bits = (uint64_t)address;
        return (T)(bits & ~kAddressTagMask);
    }

    static void clearRanges() {
        readRanges.clear();
        writeRanges.clear();
    }

    static bool rangeConflict(RangeList & rl, const char * findAddr, const size_t findSize)
    {
        const char * addr = 0;
        size_t size = 0;

        int i = 0;
        for (i = rl.size() - 1; i > -1; --i)
        {
            std::tie(addr, size) = rl[i];
            if ((addr <= findAddr && (addr + size) > findAddr) ||
                    (findAddr <= addr && (findAddr + findSize) > addr))
                return true;
        }

        return false;
    }

    static void handleRead(const char * address, const size_t & size)
    {
        (*memRobCursorPtr)->memAccRdy = false;

        // if rob is pending read from some reg, wait for that because it might be the address
        // or if logic is in speculative mode - no mem access! can't rollback
        if (!(*memRobCursorPtr)->isReady())
        {
            prf("[MEM] Reject read attempt by %p\n", (*memRobCursorPtr));
        }
        else if (rangeConflict(writeRanges, address, size))
        {
            prf("[MEM] RobCusor %p has read conflict at addr %p len %ld\n",
                (*memRobCursorPtr), address, size);
        }
        else
        {
            (*memRobCursorPtr)->memAccRdy = true;
            prf("[MEM] RobCusor %p read can go ahead\n", (*memRobCursorPtr));
        }

        // still need to recrod range even if tried and failed
        readRanges.push_back(std::make_tuple(address, size));
    }

    template <typename T, typename A>
    static T Read(A address) {
        address = AddressUntag(address);
        VIXL_ASSERT((sizeof(value) == 1) || (sizeof(value) == 2) ||
                    (sizeof(value) == 4) || (sizeof(value) == 8) ||
                    (sizeof(value) == 16));

        T value;
        if (memDepCheckModePtr && *memDepCheckModePtr)
        {
            handleRead(reinterpret_cast<const char*>(address), sizeof(value));
            memset(&value, 0, sizeof(value));
        }
        else
        {
            memcpy(&value, reinterpret_cast<const char*>(address), sizeof(value));
            dbg("[MEM] read addr=%p len=%p val=%p\n",
                address, sizeof(value), value);
        }

        return value;
    }

    static void handleWrite(const char * address, const size_t & size)
    {
        (*memRobCursorPtr)->memAccRdy = false;

        // if rob is pending read from some reg, wait for that because it might be the address
        // or if logic is in speculative mode - no mem access! can't rollback
        if (!(*memRobCursorPtr)->isReady() || (*memRobCursorPtr)->speculator)
        {
            prf("[MEM] Reject write attempt by %p\n", (*memRobCursorPtr));
        }
        else if (rangeConflict(writeRanges, address, size) ||
                 rangeConflict(readRanges, address, size))
        {
            prf("[MEM] RobCusor %p has conflict at addr %p len %ld\n",
                (*memRobCursorPtr), address, size);
        }
        else
        {
            (*memRobCursorPtr)->memAccRdy = true;
            prf("[MEM] RobCusor %p can write go ahead\n", (*memRobCursorPtr));
        }

        // still need to recrod range even if tried and failed
        writeRanges.push_back(std::make_tuple(address, size));
    }

    template <typename T, typename A>
    static void Write(A address, T value) {
        address = AddressUntag(address);
        VIXL_ASSERT((sizeof(value) == 1) || (sizeof(value) == 2) ||
                    (sizeof(value) == 4) || (sizeof(value) == 8) ||
                    (sizeof(value) == 16));

        if (memDepCheckModePtr && (*memDepCheckModePtr))
        {
            handleWrite(reinterpret_cast<const char*>(address), sizeof(value));
        }
        else
        {
            memcpy(reinterpret_cast<char*>(address), &value, sizeof(value));
            int * ptr = (int*) reinterpret_cast<char*>(address);
            wrn("[MEM] Real write: %p, %p (should be %p, len=%d)\n",
                ptr, *ptr, value, sizeof(value));
        }
    }
};

} // namespace vixl

#endif /* include guard */