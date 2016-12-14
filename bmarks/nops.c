
int main(void)
{
#define nop64() \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop"); \
    __asm__("nop"); __asm__("nop"); __asm__("nop"); __asm__("nop");


#define nops512() \
    nop64(); nop64(); \
    nop64(); nop64(); \
    nop64(); nop64(); \
    nop64(); nop64();

#define nops4k() \
    nops512(); nops512(); \
    nops512(); nops512(); \
    nops512(); nops512(); \
    nops512(); nops512();

#define nops32k() \
    nops4k(); nops4k(); \
    nops4k(); nops4k(); \
    nops4k(); nops4k(); \
    nops4k(); nops4k();

#define nops256k() \
    nops32k(); nops32k(); \
    nops32k(); nops32k(); \
    nops32k(); nops32k(); \
    nops32k(); nops32k();

#define nops2m() \
    nops256k(); nops256k(); \
    nops256k(); nops256k(); \
    nops256k(); nops256k(); \
    nops256k(); nops256k();

    //above 4k takes too long
    nops4k();

}