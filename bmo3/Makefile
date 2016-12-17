.PHONY: all clean

SRC				:=$(wildcard *.c)

EXT_X86_BIN 	:=x86
EXT_OBJ 		:=o
EXT_A64_ASM 	:=s
EXT_A64_DASM 	:=ds
EXT_A64_BIN 	:=a64

BIN_X86			:=$(SRC:%.c=%.$(EXT_X86_BIN))
ASM_A64 		:=$(SRC:%.c=%.$(EXT_A64_ASM))
DASM_A64 		:=$(SRC:%.c=%.$(EXT_A64_DASM))
BIN_A64 		:=$(SRC:%.c=%.$(EXT_A64_BIN))

OPT 			:=3

ifeq ($(OPT), 1)
	OPT_FLAGS 	:=-O0
else ifeq ($(OPT), 2)
	OPT_FLAGS 	:=-Oz
else
	OPT_FLAGS 	:=-O3 -ffast-math -fvectorize -mcpu=cortex-a57
endif

C_CLAGS			:=-std=gnu99 -fno-stack-protector \
					-fno-exceptions -fno-asynchronous-unwind-tables
C_TO_X86		:=gcc $(C_CLAGS) -D_DEBUG
# -O3 -ffast-math -march=armv8.1-a+fp+simd -mtune=vulcan
A64_ARCH		:=-target aarch64-arm-none-elf
C_TO_A64 		:=clang $(A64_ARCH) $(C_CLAGS) -nostdlib $(OPT_FLAGS)
C_TO_A64_OBJ 	:=$(C_TO_A64) -c
OBJ_TO_A64_BIN 	:=aarch64ld -Ttext=0x100 -e main
C_TO_A64_ASM 	:=$(C_TO_A64) -fverbose-asm -S
OBJ_TO_A64_DASM :=aarch64objdump -xd

%.$(EXT_X86_BIN): %.c
	$(C_TO_X86)  $< -o $@

%.$(EXT_OBJ): %.c
	$(C_TO_A64_OBJ) $< -o $@

%.$(EXT_A64_ASM): %.c
	$(C_TO_A64_ASM) $< -o $@

%.$(EXT_A64_BIN): %.$(EXT_OBJ)
	$(OBJ_TO_A64_BIN) $< -o $@

%.$(EXT_A64_DASM): %.$(EXT_A64_BIN)
	$(OBJ_TO_A64_DASM) $< > $@

all: $(BIN_X86) $(ASM_A64) $(BIN_A64) $(DASM_A64)
	awk 'FNR==1{print ""}1' *.$(EXT_A64_ASM) > all.s

stat: all
	asmstat all.s > allstat.txt
	tail -n2 allstat.txt

clean:
	rm -rf *.$(EXT_X86_BIN) *.$(EXT_A64_BIN) *.$(EXT_OBJ)
	rm -rf *.$(EXT_A64_ASM) *.$(EXT_A64_DASM) a.out
	rm -rf *.dSYM
