#ifdef _DEBUG
#include <stdio.h>
#endif

#define N 700
int main() {
    int r[N * 4 + 1];
    int i, k;
    int b, d;
    int c = 0;

    for (i = 0; i < N * 4; i++) {
        r[i] = 2000;
    }

    int ret;

    for (k = N * 4; k > 0; k -= 14) {
        d = 0;

        i = k;
        for (;;) {
            d += r[i] * 10000;
            b = 2 * i - 1;

            r[i] = d % b;
            d /= b;
            i--;
            if (i == 0) break;
            d *= i;
        }

#ifdef _DEBUG
        printf("%.4d ", c + d / 10000);
#endif
        ret = c + d / 10000;

        c = d % 10000;
    }

    return ret;
}