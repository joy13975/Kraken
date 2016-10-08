#include <stdlib.h>
#include <string.h>

#include "state.h"
#include "util.h"

size_t dmem_size     = DEFAULT_DMEM_SIZE;
size_t reg_file_size = DEFAULT_REG_FILE_SIZE;

void advance_program_counter();

struct
{
    WORD *imem;                             // instruction memory
    WORD *dmem;                             // data memory
    register_unit *reg_file;                // register file
    register_unit *instruction;             // instruction register
    register_unit *program_counter;         // program counter
    register_unit *stage_flag;              // stage flag register
} state = {0};



void write_back()
{
    advance_program_counter();
}

void advance_program_counter()
{
    const WORD current_pc = get_register(state.program_counter);
    dbg("advance_program_counter() - current pc = %d, incrementing\n", current_pc);
    set_register(state.program_counter, current_pc + 1);
}

void fetch_instruction()
{
    const WORD fetch_addr      = get_register(state.program_counter);
    const WORD fetched_value   = state.imem[fetch_addr];
    prf("fetch_instruction() - pc = %d, imem[pc] = %d\n", fetch_addr, fetched_value);
    set_register(state.instruction, fetched_value);
}

const WORD get_stage_flag()
{
    return get_register(state.stage_flag);
}

void advance_stage()
{
    WORD stage_flag = get_register(state.stage_flag);
    WORD new_stage_flag;

    if (!stage_flag || (stage_flag >= (0x1U << (NUM_STAGES - 1))))
        new_stage_flag = 0x1U;
    else
        new_stage_flag = stage_flag << 1;

    set_register(state.stage_flag, new_stage_flag);
    dbg("advance_stage() - set stage flag to %d\n", new_stage_flag);
}

void propagate_state()
{
    prf("propagate_state()\n");
    propagate_registers(state.reg_file, reg_file_size);
    propagate_register(state.instruction);
    propagate_register(state.program_counter);
    propagate_register(state.stage_flag);
}

void destroy_state()
{
    free(state.imem);
    free(state.dmem);
    free(state.reg_file);
    free(state.instruction);
    free(state.program_counter);
    free(state.stage_flag);
}

void create_state(WORD *program, size_t num_words)
{
    state.imem              = calloc(1, num_words * sizeof(WORD));
    memcpy(state.imem, program, num_words * sizeof(WORD));
    state.dmem              = calloc(1, dmem_size);
    state.reg_file          = create_registers(reg_file_size);
    state.instruction       = create_register();
    state.program_counter   = create_register();
    state.stage_flag        = create_register();
}