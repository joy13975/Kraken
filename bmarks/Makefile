.PHONY: all clean

EXT_X86:=x86
EXT_A64_ASM:=s

SRC:=$(wildcard *.c)
BIN_X86:=$(SRC:%.c=%.$(EXT_X86))
ASM_A64:=$(SRC:%.c=%.$(EXT_A64_ASM))

COMPILE_X86:=gcc -O0 -std=gnu99 -fno-stack-protector -D_DEBUG


%.$(EXT_X86): %.c
	$(COMPILE_X86) -o $@ $<

%.$(EXT_A64_ASM): %.c
	./asm $< $@

	$(eval asmObjName := $(@:.$(EXT_A64_ASM)=.o))
	./asm $< $(asmObjName) obj
	# ./extract $(asmObjName)

all: $(BIN_X86) $(ASM_A64)
	awk 'FNR==1{print ""}1' *.$(EXT_A64_ASM) > all.s

stat: all
	asmstat all.s > allstat.txt
	tail -n2 allstat.txt

clean:
	rm -rf *.$(EXT_A64_ASM) *.$(EXT_X86) *.data *.text *.o