#ifdef _DEBUG
#include <stdio.h>
#endif

#include "fplib.h"

int main(void)
{
    float ret = sqroot(sqroot(sqroot(3332341213123.14150000001)));
#ifdef _DEBUG
    printf("Result: %.10f\n", ret);
#endif
    return ret;
}