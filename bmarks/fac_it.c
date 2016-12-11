#ifdef _DEBUG
#include "stdio.h"
#endif

int fac(int i)
{
    int x = 1;
    while (i != 1)
    {
#ifdef _DEBUG
        printf("x=%d, i=%d\n", x, i);
#endif

        x *= i;
        i--;
    }
    return x;
}

#define N 10
int main(void)
{
    int res = fac(N);

#ifdef _DEBUG
    printf("fac(%d) = %d\n", N, res);
#endif

    return res;
}