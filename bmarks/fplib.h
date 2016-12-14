#ifndef _LOG_H_
#define _LOG_H_

#define e_const     2.718281828459045235360287471352662497757247093
#define pi_const    3.141592653589793238462643383279502884197169399

float fastlog2 (float x)
{
    union { float f; unsigned int i; } vx = { x };
    union { unsigned int i; float f; } mx = { (vx.i & 0x007FFFFF) | 0x3f000000 };
    float y = vx.i;
    y *= 1.1920928955078125e-7f;

    return y - 124.22551499f
           - 1.498030302f * mx.f
           - 1.72587999f / (0.3520887068f + mx.f);
}

float fastlog (float x)
{
    return 0.69314718f * fastlog2 (x);
}

long int ipow(int x, int n)
{
    int i; /* Variable used in loop counter */
    int number = 1;

    for (i = 0; i < n; ++i)
        number *= x;

    return (number);
}

float fpow(float x, float n)
{
    float i; /* Variable used in loop counter */
    float number = 1;

    for (i = 0; i < n; ++i)
        number *= x;

    return (number);
}

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

float fabsolute(float a)
{
    return a > 0.0f ? a : -a;
}

#endif /* include guard */