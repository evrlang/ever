module helpmenu;

import std.stdio;

void helpm(){
    writeln("evrdocs - Documents maker for Ever.");
    writeln("Usage:");
    writeln("\t./evrdocs [option] [filename]");
    writeln("Options:");
    writeln("\t-e | --enter: Enter an ever source file to make it documents.");
    writeln("\t-v | --version: write version of evrdocs in stdout.");
}