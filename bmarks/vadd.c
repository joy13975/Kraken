#ifdef _DEBUG
#include <stdio.h>
#endif

#include "nums1k.h"

#define N 512

int main(void)
{
    int c[N];

    for (int i = 0; i < N; i++)
        c[i] = nums1k1[i] + nums1k2[i];

    int ret = c[N - 1] % 255;

#ifdef _DEBUG
    printf("Front: ");
    for (int i = 0; i < 10; i++)
        printf("%-3d ", c[i]);
    printf("\n");

    printf("Back:  ");
    for (int i = N - 1; i > N - 1 - 10; i--)
        printf("%-3d ", c[i]);
    printf("\n");

    printf("Ret: %d\n", ret);
#endif

    return ret;
}