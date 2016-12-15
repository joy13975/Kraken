#ifndef _LOG_H_
#define _LOG_H_

#define e_const     2.718281828459045235360287471352662497757247093
#define pi_const    3.141592653589793238462643383279502884197169399
#define FLT_MAX 340282346638528859811704183484516925440.0000000000000000

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

float fsine(float x)
{
    //always wrap input angle to -PI..PI
    if (x < -3.14159265)
        x += 6.28318531;
    else if (x >  3.14159265)
        x -= 6.28318531;

    //compute sine
    float sin;
    if (x < 0)
    {
        sin = 1.27323954 * x + .405284735 * x * x;

        if (sin < 0)
            sin = .225 * (sin * -sin - sin) + sin;
        else
            sin = .225 * (sin * sin - sin) + sin;
    }
    else
    {
        sin = 1.27323954 * x - 0.405284735 * x * x;

        if (sin < 0)
            sin = .225 * (sin * -sin - sin) + sin;
        else
            sin = .225 * (sin * sin - sin) + sin;
    }

    return sin;
}

float fcosine(float x)
{
    //always wrap input angle to -PI..PI
    if (x < -3.14159265)
        x += 6.28318531;
    else if (x >  3.14159265)
        x -= 6.28318531;

    //compute cosine: sin(x + PI/2) = cos(x)
    float cos;
    x += 1.57079632;
    if (x >  3.14159265)
        x -= 6.28318531;

    if (x < 0)
    {
        cos = 1.27323954 * x + 0.405284735 * x * x;

        if (cos < 0)
            cos = .225 * (cos * -cos - cos) + cos;
        else
            cos = .225 * (cos * cos - cos) + cos;
    }
    else
    {
        cos = 1.27323954 * x - 0.405284735 * x * x;

        if (cos < 0)
            cos = .225 * (cos * -cos - cos) + cos;
        else
            cos = .225 * (cos * cos - cos) + cos;
    }
    return cos;

}

#endif /* include guard */