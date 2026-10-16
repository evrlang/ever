module dbg;

import std.stdio;

void dbgprint_format(string dbgmsg)
{
    writeln("\t\033[36m\033[1mHint: \033[0m" ~ dbgmsg);
}