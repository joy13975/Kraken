CXX=g++

EXE=kraken

OBJ_DIR := .obj

SRC_DIR := src
LIBELF_DIR := $(SRC_DIR)/libelf
C_SRC := $(wildcard $(SRC_DIR)/*.c) $(wildcard $(LIBELF_DIR)/*.c)
CC_SRC := $(wildcard $(SRC_DIR)/*.cc)
OBJS := $(C_SRC:%.c=$(OBJ_DIR)/%.o) $(CC_SRC:%.cc=$(OBJ_DIR)/%.o)
DEPS := $(C_SRC:%.c=$(OBJ_DIR)/%.d) $(CC_SRC:%.cc=$(OBJ_DIR)/%.d)

$(shell mkdir -p $(OBJ_DIR)/$(SRC_DIR))

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

DEFS :=
INCS := -I./src/
CPPFLAGS := -MMD -O3 -std=c++11 $(DEBUG_FLAG) $(GOMP_FLAG) $(DEFS) $(INCS)
COMPILE := $(CXX) $(CPPFLAGS)

#
# start of rules
#

EXTS=c cc
define make_rule
$(OBJ_DIR)/%.o: %.$1
	$$(COMPILE) -o $$@ -c $$<
endef
$(foreach EXT,$(EXTS),$(eval $(call make_rule,$(EXT))))

$(EXE): $(OBJS)
	$(COMPILE) $(LDFLAGS) $^ $(LDLIBS) -o $@

.PHONY: all clean

all: $(EXE)

test: $(EXE)
	./$(EXE) -i bmarks/vadd.o

-include $(DEPS)

fresh: clean $(EXE)

clean:
	rm -rf $(EXE) $(OBJ_DIR)/* $(OBJ_DIR) *.dSYM .DS_Store

#
# DO NOT DELETE NEWLINE AT END OF FILE
#
