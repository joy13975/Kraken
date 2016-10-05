#ifndef _REGISTER_UNIT_H
#define _REGISTER_UNIT_H

#include "config.h"

typedef struct
{
    REG_PROTOTYPE input;
    REG_PROTOTYPE output;
} register_unit;

void set_register(register_unit *r, REG_PROTOTYPE new_val);
void propagate_registers(register_unit *head, size_t n);
void propagate_register(register_unit *r);

#endif