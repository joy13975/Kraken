EXE=sim
CC=gcc
CCFLAGS=-O3 -g
ARGS=
COMPILE=$(CC) $(CCFLAGS) $(ARGS)

all: $(EXE)

%.o: %.c
	$(COMPILE) $^ -c

$(EXE): $(EXE).o util.o register_unit.o state.o clock.o
	$(COMPILE) $^ -o $@

fresh: clean all

.PHONY: clean
clean:
	rm -rf $(EXE) *.o *.dSYM .DS_Store
