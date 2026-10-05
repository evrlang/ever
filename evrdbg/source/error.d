module error;

import std.stdio, std.string, core.stdc.stdlib;
public string ver = "0.0.1";
void error(string txt)
{
    writeln("\033[1m\033[31m (1) EverDebugger, " ~ __DATE__  ~ __TIME__  ~ ": \033[0m" ~ txt);
}
void fileerror(){
    error("Ever source not exists.");
} 

void noevr(){
    error("Just work with ever source codes.");
}