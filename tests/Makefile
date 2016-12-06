.PHONY: all clean

EXT_X86:=x86
EXT_A64:=a64
EXT_A64_ASM:=aasm

SRC:=$(wildcard *.c)
BIN_X86:= $(SRC:%.c=%.$(EXT_X86))
BIN_A64:= $(SRC:%.c=%.$(EXT_A64))
ASM_A64:= $(SRC:%.c=%.$(EXT_A64_ASM))

HACK:=-lgcc -lc -lm
COMPILE_X86:=gcc -O0 -std=gnu99 -fno-stack-protector $(HACK)
COMPILE_A64:=./compile
MAKE_ASM_A64:=./asm


%.$(EXT_X86): %.c
	$(COMPILE_X86) -o $@ $< -D_DEBUG

%.$(EXT_A64): %.c
	$(COMPILE_A64) -o $@ $<

%.$(EXT_A64_ASM): %.c
	$(MAKE_ASM_A64) $< $@

all: $(BIN_X86) $(BIN_A64) $(ASM_A64)
	rm -rf *.o

clean:
	rm -rf *.$(EXT_X86) *.$(EXT_A64) *.$(EXT_A64_ASM) *.o