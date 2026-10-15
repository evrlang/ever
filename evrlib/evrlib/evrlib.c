#include <stdio.h>
#include "evrlib.h"

void evrlib_write(const char *text)
{
    printf("%s", text);
}

void evrlib_writeint(int num){
    printf("%d", num);
}

void evrlib_readstr(char *text){
    fgets(text, sizeof(text), stdin);
}
