EXE=proc
CC=gcc
CCFLAGS=-O2 -g
COMPILE=$(CC) $(CCFLAGS)

all: proc

%.o: %.c
	$(COMPILE) $^ -c

$(EXE): $(EXE).o clock_component.o components.o
	$(COMPILE) $^ -o $@

fresh: clean all

clean:
	rm -rf $(EXE) *.o *.dSym .DS_Store