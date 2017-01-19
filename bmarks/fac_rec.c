#ifdef _DEBUG
#include "stdio.h"
#endif

int fac(int i)
{
#ifdef _DEBUG
    printf("i=%d\n", i);
#endif
    return i > 1 ? i * fac(i - 1) : 1;
}

#define N 100
int main(void)
{
    int res = fac(N);

#ifdef _DEBUG
    printf("fac(%d) = %d\n", N, res);
#endif

    return res;
}