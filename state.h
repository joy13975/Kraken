#ifndef _STATE_H
#define _STATE_H

#include "register_unit.h"

void write_back();
void fetch_instruction();
const WORD get_stage_flag();
void advance_stage();
void propagate_state();
void destroy_state();
void create_state();

#endif