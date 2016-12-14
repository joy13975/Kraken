
#ifdef _DEBUG
#include "stdio.h"
#endif

int main()
{
    int n = 40;
    int first = 0, second = 1, next, c;

    long ret;
    for ( c = 0 ; c < n ; c++ )
    {
        if ( c <= 1 )
            next = c;
        else
        {
            next = first + second;
            first = second;
            second = next;
        }

        ret = next;
#ifdef _DEBUG
        printf("%d\n", ret);
#endif
    }

    return ret;
}