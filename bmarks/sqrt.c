#ifdef _DEBUG
#include <stdio.h>
#endif

//#define MINDIFF 2.2250738585072014e-308   // smallest positive float
#define MINDIFF 2.25e-308                   // use for convergence check

float sqroot(float square)
{
    float root = square / 3, last, diff = 1;
    if (square <= 0) return 0;
    do {
        last = root;
        root = (root + square / root) / 2;
        diff = root - last;
    } while (diff > MINDIFF || diff < -MINDIFF);
    return root;
}

int main(void)
{
    float a = sqroot(sqroot(sqroot(3.14150000001)));
#ifdef _DEBUG
    printf("Result: %.10f\n", a);
#endif
    return 0;
}