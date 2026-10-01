#include <stdio.h>
#include <windows.h>
#include "rtime.h"

void consoleWrite(const char *data)
{
    MessageBoxA(NULL, data, "RTIME", MB_OK);
}