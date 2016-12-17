#include "logic-regs-a64.h"

namespace vixl
{
void LogicVRegister::ReadUintFromMem(VectorFormat vform, int index, uint64_t addr) const {
    switch (LaneSizeInBitsFromFormat(vform)) {
    case 8:
        register_.Insert(index, register_.memory->Read<uint8_t>(addr));
        break;
    case 16:
        register_.Insert(index, register_.memory->Read<uint16_t>(addr));
        break;
    case 32:
        register_.Insert(index, register_.memory->Read<uint32_t>(addr));
        break;
    case 64:
        register_.Insert(index, register_.memory->Read<uint64_t>(addr));
        break;
    default:
        VIXL_UNREACHABLE();
        return;
    }
}

void LogicVRegister::WriteUintToMem(VectorFormat vform, int index, uint64_t addr, Memory *memory) const {
    uint64_t value = Uint(vform, index);
    switch (LaneSizeInBitsFromFormat(vform)) {
    case 8:
        memory->Write(addr, static_cast<uint8_t>(value));
        break;
    case 16:
        memory->Write(addr, static_cast<uint16_t>(value));
        break;
    case 32:
        memory->Write(addr, static_cast<uint32_t>(value));
        break;
    case 64:
        memory->Write(addr, value);
        break;
    }
}
} // namespace vixl