#include "stdio.h"
#include "func.h"

extern char* g_hello;

void foo(void)
{
    printf("void foo(): %s\n", HELLO);
}