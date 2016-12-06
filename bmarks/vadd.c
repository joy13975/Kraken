#ifdef _DEBUG
#include <stdio.h>
#endif

#define N 256
int main(void)
{
    int a[N], b[N], c[N];

    //intialise arrays
    for (int i = 0; i < N; i++)
    {
        b[i] = i;
        a[i] = 3 * ~b[i];
    }

    //vector add arrays
    for (int i = 0; i < N; i++)
        c[i] = a[i] + b[i];

#ifdef _DEBUG
    printf("c[0](%d) = a[0](%d) + b[0](%d)\n", c[0], a[0], b[0]);
    printf("c[N-1](%d) = a[N-1](%d) + b[N-1](%d)\n", c[N - 1], a[N - 1], b[N - 1]);
#endif

    return 0;
}