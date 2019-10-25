#include "stdio.h"

extern char* g_hello;

void foo(void)
{
    printf("void foo(): %s\n", g_hello);
}