module error;

import std.stdio, core.stdc.stdlib;

extern(C) void _error(string errortxt)
{
    writeln("\033[1m\033[31mError: \033[0m" ~ errortxt);
    exit(1);
}