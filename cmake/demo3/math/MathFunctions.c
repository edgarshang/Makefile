#include <stdio.h>
#include <stdlib.h>

double power(double base, int exponent)
{
    int result = base;
    int i;

    if(exponent == 0)
    {
        return 1;
    }

    for(i = 1; i < exponent; i++)
    {
        result *= base;
    }

    return result;
}