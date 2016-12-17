#ifdef _DEBUG
#include <stdio.h>
#endif

#include "fplib.h"

#define N 10
int main(void)
{
    float ret = fabsolute(-300.141513371337f);

    float sins[N];

    for (int i = 0; i < N; i++)
        sins[i] = fsine((float) i * pi_const / N);

#ifdef _DEBUG
    for (int i = 0; i < N; i++)
        printf("i=%d, sin(i)=%.2f\n", i, sins[i]);

    printf("ret = %.10f\n", ret);
#endif

    return ret;
}