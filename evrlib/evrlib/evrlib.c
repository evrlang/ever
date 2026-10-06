#include <stdio.h>
#include "evrlib.h"

void evrlib_write(const char *text)
{
    printf("%s\n", text);
}

const char *evrlib_readstring()
{
    static char result[256] = "";
    scanf("%s", result);
    return result;
}