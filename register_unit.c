#include <stdlib.h>

#include "register_unit.h"

struct register_unit
{
    WORD input;
    WORD output;
} ;

const WORD get_register(register_unit *r)
{
    return r->output;
}

void set_register(register_unit *r, WORD new_val)
{
    r->input = new_val;
}

void propagate_registers(register_unit *head, size_t n)
{
    for (int i = 0; i < n; i++)
    {
        propagate_register(head);
        head++;
    }
}

void propagate_register(register_unit *r)
{
    r->output = r->input;
}

register_unit *create_registers(size_t n)
{
    return calloc(n, sizeof(register_unit));
}

register_unit *create_register()
{
    return calloc(1, sizeof(register_unit));
}