#ifdef _DEBUG
#include "stdio.h"
#endif

#define N 10
int main(void)
{
    int res = 1, i = N;

#define itr() \
    { \
        res *= i; \
        i--; \
    }

#define itr10() \
    itr(); \
    itr(); \
    itr(); \
    itr(); \
    itr(); \
    itr(); \
    itr(); \
    itr(); \
    itr(); \
    itr();

    itr10();
    itr10();
    itr10();
    itr10();
    itr10();
    itr10();
    itr10();
    itr10();
    itr10();
    itr10();

#ifdef _DEBUG
    printf("fac(%d) = %d\n", N, res);
#endif

    return res;
}