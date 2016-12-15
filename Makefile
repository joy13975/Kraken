CXX=g++

EXE=kraken


SRC_DIR 		:= src
VIXL_DIR 		:= $(SRC_DIR)/vixl
VIXL_A64_DIR 	:= $(VIXL_DIR)/a64
OBJ_DIR 		:= .obj
$(shell mkdir -p 	$(OBJ_DIR)/$(SRC_DIR) \
					$(OBJ_DIR)/$(VIXL_DIR) \
					$(OBJ_DIR)/$(VIXL_A64_DIR))

C_SRC 			:= $(wildcard $(SRC_DIR)/*.c)
CC_SRC 			:= $(wildcard $(SRC_DIR)/*.cc) \
					$(wildcard $(VIXL_DIR)/*.cc) \
					$(wildcard $(VIXL_A64_DIR)/*.cc)
OBJS 			:= $(C_SRC:%.c=$(OBJ_DIR)/%.o) $(CC_SRC:%.cc=$(OBJ_DIR)/%.o)
DEPS 			:= $(C_SRC:%.c=$(OBJ_DIR)/%.d) $(CC_SRC:%.cc=$(OBJ_DIR)/%.d)

DEBUG=0
GOMP=0

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

DEFS 			:=
INCS 			:= -I./src/
CPPFLAGS 		:= -MMD -O3 -std=c++11 -fmax-errors=1\
					$(DEBUG_FLAG) $(GOMP_FLAG) $(DEFS) $(INCS)
COMPILE 		:= $(CXX) $(CPPFLAGS)
TEST_PROG 		:= vadd

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
	./$(EXE) -i bmarks/$(TEST_PROG).a64 $(ARGS)

testim: $(EXE)
	./$(EXE) -i bmarks/$(TEST_PROG).a64 -im $(ARGS)

clean:
	rm -rf $(EXE) $(OBJ_DIR)/* $(OBJ_DIR) *.dSYM .DS_Store *.dec *.bin

-include $(DEPS)

#
# DO NOT DELETE NEWLINE AT END OF FILE
#
