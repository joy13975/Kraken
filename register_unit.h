#ifndef _REGISTER_UNIT_H
#define _REGISTER_UNIT_H

#include "config.h"

typedef struct register_unit register_unit;


const WORD get_register(register_unit *r);
void set_register(register_unit *r, WORD new_val);
void propagate_registers(register_unit *head, size_t n);
void propagate_register(register_unit *r);
register_unit *create_registers(size_t n);
register_unit *create_register();

#endif