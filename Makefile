EXE=sim
CC=gcc
CCFLAGS=-O2 -g -fopenmp
COMPILE=$(CC) $(CCFLAGS)

all: $(EXE)

%.o: %.c
	$(COMPILE) $^ -c

$(EXE): $(EXE).o util.o register_unit.o
	$(COMPILE) $^ -o $@

fresh: clean all

clean:
	rm -rf $(EXE) *.o *.dSYM .DS_Store