EXE=sim

CPP=g++

DEBUG=1
GOMP=1

ifeq ($(DEBUG), 1)
	DEBUG_FLAG=-ggdb3
else
	DEBUG_FLAG=
endif

ifeq ($(GOMP), 1)
	GOMP_FLAG=-fopenmp
else
	GOMP_FLAG=
endif

TEST_ASM_FILE="tests/counting.jasm"
MORE_COMPILE_FLAGS=
RUN_ARGS=

ifeq ($(EXE), JAssembly)
	MORE_COMPILE_FLAGS=-D_TEST_DEFINE_MAIN
	TEST_DEFAULT_ARGS=
	RUN=./$(EXE) $(TEST_ASM_FILE) $(TEST_DEFAULT_ARGS) $(RUN_ARGS)
else
	TEST_DEFAULT_ARGS=-f 1 -l 4
	RUN=./$(EXE) -a $(TEST_ASM_FILE) $(TEST_DEFAULT_ARGS) $(RUN_ARGS)
endif

COMPILE_FLAGS=-O3 -std=c++11 $(DEBUG_FLAG) $(GOMP_FLAG)
COMPILE=$(CPP) $(COMPILE_FLAGS) $(MORE_COMPILE_FLAGS)

EXTS=c cc
define make_rule
%.o : %.$1
	$$(COMPILE) $$^ -c
endef
$(foreach EXT,$(EXTS),$(eval $(call make_rule,$(EXT))))

$(EXE): util.o UtilCpp.o JAssembly.o Commitable.o Register.o Clock.o JProcessor.o $(EXE).o
	$(COMPILE) $^ -o $@

fresh: clean $(EXE)

test: $(EXE)
	$(RUN)

.PHONY: clean
clean:
	rm -rf $(EXE) *.o *.dSYM .DS_Store jasm sim
