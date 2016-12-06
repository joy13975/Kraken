CXX=g++

EXE=sim

OBJ_DIR := .obj

VIXL_DIR := src/vixl
VIXL_SRC := $(wildcard $(VIXL_DIR)/*.cc)
VIXL_A64_DIR := src/vixl/a64
VIXL_A64_SRC := $(wildcard $(VIXL_A64_DIR)/*.cc)

SRC_DIR := ./src
C_SRC := $(wildcard src/*.c)
CC_SRC := $(wildcard src/*.cc) $(VIXL_SRC) $(VIXL_A64_SRC)
OBJS := $(C_SRC:%.c=$(OBJ_DIR)/%.o) $(CC_SRC:%.cc=$(OBJ_DIR)/%.o)
DEPS := $(C_SRC:%.c=$(OBJ_DIR)/%.d) $(CC_SRC:%.cc=$(OBJ_DIR)/%.d)
$(shell mkdir -p $(OBJ_DIR))
$(shell mkdir -p $(OBJ_DIR)/$(VIXL_DIR))
$(shell mkdir -p $(OBJ_DIR)/$(VIXL_A64_DIR))

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
INCS := -I src/
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

-include $(DEPS)

fresh: clean $(EXE)

clean:
	rm -rf $(EXE) $(OBJ_DIR)/* $(OBJ_DIR)/* *.dSYM .DS_Store

#
# DO NOT DELETE NEWLINE AT END OF FILE
#
