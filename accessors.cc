//nzcv, fpcr in SimSystemRegister
#define DEFINE_GETTER(Name, HighBit, LowBit, Func)        \
  uint32_t Name() const { return Func(HighBit, LowBit); } \
  void Set##Name(uint32_t bits) { SetBits(HighBit, LowBit, bits); }
#define DEFINE_WRITE_IGNORE_MASK(Name, Mask) \
  static const uint32_t Name##WriteIgnoreMask = ~static_cast<uint32_t>(Mask);

SYSTEM_REGISTER_FIELDS_LIST(DEFINE_GETTER, DEFINE_WRITE_IGNORE_MASK)

//pc
fetcher->setPc(cachedNewPc);

//r SimRegister
template <typename T>
T reg(unsigned code, Reg31Mode r31mode = Reg31IsZeroRegister) const {
    VIXL_ASSERT(code < kNumberOfRegisters);
    if ((code == 31) && (r31mode == Reg31IsZeroRegister)) {
        T result;
        memset(&result, 0, sizeof(result));
        return result;
    }
    return registers_[code].Get<T>();
}

template <typename T>
void set_reg(unsigned code,
             T value,
             RegLogMode log_mode = LogRegWrites,
             Reg31Mode r31mode = Reg31IsZeroRegister) {
    VIXL_STATIC_ASSERT((sizeof(T) == kWRegSizeInBytes) ||
                       (sizeof(T) == kXRegSizeInBytes));
    VIXL_ASSERT(code < kNumberOfRegisters);

    if ((code == 31) && (r31mode == Reg31IsZeroRegister)) {
        return;
    }

    registers_[code].Set(value);

    if (log_mode == LogRegWrites) LogRegister(code, r31mode);
}


//v SimVRegister
template <typename T>
T vreg(unsigned code) const {
    VIXL_STATIC_ASSERT(
        (sizeof(T) == kBRegSizeInBytes) || (sizeof(T) == kHRegSizeInBytes) ||
        (sizeof(T) == kSRegSizeInBytes) || (sizeof(T) == kDRegSizeInBytes) ||
        (sizeof(T) == kQRegSizeInBytes));
    VIXL_ASSERT(code < kNumberOfVRegisters);

    return vregisters_[code].Get<T>();
}

template <typename T>
void set_vreg(unsigned code, T value, RegLogMode log_mode = LogRegWrites) {
    VIXL_STATIC_ASSERT((sizeof(value) == kBRegSizeInBytes) ||
                       (sizeof(value) == kHRegSizeInBytes) ||
                       (sizeof(value) == kSRegSizeInBytes) ||
                       (sizeof(value) == kDRegSizeInBytes) ||
                       (sizeof(value) == kQRegSizeInBytes));
    VIXL_ASSERT(code < kNumberOfVRegisters);
    vregisters_[code].Set(value);

    if (log_mode == LogRegWrites) {
        LogVRegister(code, GetPrintRegisterFormat(value));
    }
}

//mem
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