.PHONY: all clean

EXT_X86:=x86
EXT_A64_ASM:=s

SRC:=$(wildcard *.c)
BIN_X86:= $(SRC:%.c=%.$(EXT_X86))
ASM_A64:= $(SRC:%.c=%.$(EXT_A64_ASM))

HACK:=-lgcc -lc -lm
COMPILE_X86:=gcc -O0 -std=gnu99 -fno-stack-protector $(HACK)
MAKE_ASM_A64:=./asm


%.$(EXT_X86): %.c
	$(COMPILE_A64) -o $@ $<

%.$(EXT_A64_ASM): %.c
	$(MAKE_ASM_A64) $< $@

all: $(BIN_X86) $(ASM_A64)
	rm -rf *.o

clean:
	rm -rf $(ASM_A64) $(BIN_X86)