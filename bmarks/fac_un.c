#ifdef _DEBUG
#include "stdio.h"
#endif

#define N 10
int main(void)
{
    int res = 1, i = N;

#define itr() \
    if (i != 1) \
    { \
        res *= i; \
        i--; \
    }

    itr();
    itr();
    itr();
    itr();
    itr();
    itr();
    itr();
    itr();
    itr();
    itr();

#ifdef _DEBUG
    printf("fac(%d) = %d\n", N, res);
#endif

    return res;
}