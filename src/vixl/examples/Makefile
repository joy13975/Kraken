CXX:=g++

.PHONY: all clean
BIN_EXT:=out
SRC_EXT:=cc

SRC:=$(wildcard *.$(SRC_EXT))
EXAMPLES:=$(SRC:%.$(SRC_EXT)=%.$(BIN_EXT))

INCS:=-I ../../
LINKS:=../../../.obj/src/vixl/*.o ../../../.obj/src/vixl/a64/*.o
COMPILE:=$(CXX) $(INCS) $(LINKS)

%.$(BIN_EXT): %.$(SRC_EXT)
	$(COMPILE) -o $@ $<

all: $(EXAMPLES)

clean:
	rm -rf *.$(BIN_EXT)