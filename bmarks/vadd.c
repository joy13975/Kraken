#ifdef _DEBUG
#include <stdio.h>
#endif

#include "nums1k.h"

#define N 1024
int main(void)
{
    int c[N];

    for (int i = 0; i < N; i++)
        c[i] = nums1k1[i] + nums1k2[i];

#ifdef _DEBUG
    printf("c[0](%d)    = nums1k1[0](%d) + nums1k2[0](%d)\n",
           c[0], nums1k1[0], nums1k2[0]);
    printf("c[N-1](%d)  = nums1k1[N-1](%d) + nums1k2[N-1](%d)\n",
           c[N - 1], nums1k1[N - 1], nums1k2[N - 1]);
#endif

    return 0;
}