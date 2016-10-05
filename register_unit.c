#include "register_unit.h"

void set_register(register_unit *r, REG_PROTOTYPE new_val)
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