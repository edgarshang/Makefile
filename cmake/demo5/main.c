#include <stdio.h>
#include <stdlib.h>
#include "config.h"


#ifdef USE_MYMATH

#include "math/MathFunctions.h"


#endif

double mypower(double base, int exponent)
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

int main(int argc, char *argv[])
{
    if(argc < 3)
    {
        printf("Usage: %s base exponent\n", argv[0]);
        return 1;
    }

    double base = atof(argv[1]);
    int exponent = atoi(argv[2]);

#ifdef USE_MYMATH

printf("Now we use our own Math library-----. \n");

double result = power(base, exponent);

#else

printf("Now we use the standard library++++. \n");

double result = mypower(base, exponent);

#endif


    
    printf("%g ^ %d is %g\n", base, exponent, result);

    return 0;
}