#ifdef _DEBUG
#include <stdio.h>
#endif

#include "mats64.h"

#define N 64

static unsigned long product[N][N] = {0};
int main(void)
{

    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                product[i][j] += mats64_1[i][k] * mats64_2[k][j];

    unsigned long ret = product[2][2] % 1337;

#ifdef _DEBUG
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++)
            printf("%-16d ", product[i][j]);
        printf("\n");
    }

    printf("ret = %d\n", ret);
#endif

    return ret;
}