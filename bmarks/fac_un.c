#ifdef _DEBUG
#include "stdio.h"
#endif

int fac(int i)
{
    int x = 1;

#define FAKE_LOOP() \
        x *= i; \
        i--; \

    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();
    FAKE_LOOP();

    return x;
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