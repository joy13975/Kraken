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

namespace vixl
{


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

    template <typename T, typename A>
    static T Read(A address) {
        T value;
        address = AddressUntag(address);
        VIXL_ASSERT((sizeof(value) == 1) || (sizeof(value) == 2) ||
                    (sizeof(value) == 4) || (sizeof(value) == 8) ||
                    (sizeof(value) == 16));
        memcpy(&value, reinterpret_cast<const char*>(address), sizeof(value));
        return value;
    }

    template <typename T, typename A>
    static void Write(A address, T value) {
        address = AddressUntag(address);
        VIXL_ASSERT((sizeof(value) == 1) || (sizeof(value) == 2) ||
                    (sizeof(value) == 4) || (sizeof(value) == 8) ||
                    (sizeof(value) == 16));
        memcpy(reinterpret_cast<char*>(address), &value, sizeof(value));
    }
};

} // namespace vixl

#endif /* include guard */