CXX=g++

EXE=sim

HIDDEN := .hidden
$(shell mkdir -p $(HIDDEN))

C_SRC := util.c
CC_SRC := UtilCpp.cc \
	JAssembler.cc Register.cc \
	Clock.cc ProcStage.cc \
	Fetcher.cc \
	XOut.cc Decoder.cc DMemer.cc \
	XInOut.cc RegFiler.cc MemAcc.cc Executor.cc WTBack.cc \
	JProcessor.cc \
	$(EXE).cc
OBJS := $(C_SRC:%.c=$(HIDDEN)/%.o) $(CC_SRC:%.cc=$(HIDDEN)/%.o)
DEPS := $(C_SRC:%.c=$(HIDDEN)/%.d) $(CC_SRC:%.cc=$(HIDDEN)/%.d)

DEBUG=1
GOMP=1

ifeq ($(DEBUG), 1)
	DEBUG_FLAG=-g
else
	DEBUG_FLAG=
endif

ifeq ($(GOMP), 1)
	GOMP_FLAG=-fopenmp
else
	GOMP_FLAG=
endif

TEST_ASM_FILE="tests/counting50.jasm"
MORE_COMPILE_FLAGS=
RUN_ARGS=

ifeq ($(EXE), JAssembly)
	MORE_COMPILE_FLAGS=-D_TEST_DEFINE_MAIN
	TEST_DEFAULT_ARGS=
	RUN=./$(EXE) $(TEST_ASM_FILE) $(TEST_DEFAULT_ARGS) $(RUN_ARGS)
else
	TEST_DEFAULT_ARGS=-f 0 -l 1 -ja
	RUN=./$(EXE) -a $(TEST_ASM_FILE) $(TEST_DEFAULT_ARGS) $(RUN_ARGS)
endif

CPPFLAGS+=-MMD -O3 -std=c++11 $(DEBUG_FLAG) $(GOMP_FLAG)
COMPILE:=$(CXX) $(DEPFLAGS) $(CPPFLAGS) $(MORE_CPPFLAGS)

#
# start of rules
#

.PHONY: all clean

all: $(EXE)

fresh: clean $(EXE)

test: $(EXE)
	$(RUN)

clean:
	rm -rf $(EXE) $(HIDDEN)/* $(HIDDEN)/* *.dSYM .DS_Store

EXTS=c cc
define make_rule
$(HIDDEN)/%.o: %.$1
	$$(COMPILE) -o $$@ -c $$<
endef
$(foreach EXT,$(EXTS),$(eval $(call make_rule,$(EXT))))

$(EXE): $(OBJS)
	$(COMPILE) $(LDFLAGS) $^ $(LDLIBS) -o $@

-include $(DEPS)

#
# DO NOT DELETE NEWLINE AT END OF FILE
#
