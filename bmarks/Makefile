.PHONY: all clean

SRC				:=$(wildcard *.c)

EXT_X86 		:=x86
EXT_LL_IR 		:=ll
EXT_A64_ASM 	:=s
EXT_A64_DASM 	:=ds
EXT_A64 		:=a64

BIN_X86			:=$(SRC:%.c=%.$(EXT_X86))
LL_A64 			:=$(SRC:%.c=%.$(EXT_LL_IR))
ASM_A64 		:=$(SRC:%.c=%.$(EXT_A64_ASM))
BIN_A64 		:=$(SRC:%.c=%.$(EXT_A64))
DASM_A64 		:=$(SRC:%.c=%.$(EXT_A64_DASM))

C_CLAGS			:=-O0 -std=gnu99 -fno-stack-protector \
					-fno-exceptions -fno-asynchronous-unwind-tables \
					-fPIC
C_TO_X86		:=gcc $(C_CLAGS) -D_DEBUG

A64_ARCH		:=-target aarch64 -S -emit-llvm
C_TO_A64_LL 	:=clang $(A64_ARCH) $(C_CLAGS) -nostdlib
LL_TO_A64_ASM 	:=llc -march=aarch64
LL_TO_A64 		:=$(LL_TO_A64_ASM) -filetype=obj
A64_TO_DASM 	:=objdump -arch=aarch64 -d

%.$(EXT_X86): %.c
	$(C_TO_X86)  $< -o $@

%.$(EXT_LL_IR): %.c
	$(C_TO_A64_LL) $<  -o $@

%.$(EXT_A64_ASM): %.$(EXT_LL_IR)
	$(LL_TO_A64_ASM) $< -o $@

%.$(EXT_A64): %.$(EXT_LL_IR)
	$(LL_TO_A64) $< -o $@

%.$(EXT_A64_DASM): %.$(EXT_A64)
	$(A64_TO_DASM) $< > $@

all: $(BIN_X86) $(ASM_A64) $(BIN_A64) $(DASM_A64) clean_ll_ir
	awk 'FNR==1{print ""}1' *.$(EXT_A64_ASM) > all.s

clean_ll_ir:
	rm -rf *.$(EXT_LL_IR)

stat: all
	asmstat all.s > allstat.txt
	tail -n2 allstat.txt

clean:
	rm -rf *.$(EXT_X86) *.$(EXT_LL_IR) *.$(EXT_A64_ASM) *.$(EXT_A64)