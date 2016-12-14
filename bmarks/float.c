#ifdef _DEBUG
#include <stdio.h>
#endif

#include "fplib.h"

int main(void)
{
    float ret = fabsolute(-300.141513371337f);

#ifdef _DEBUG
    printf("ret = %.10f\n", ret);
#endif

    return ret;
}