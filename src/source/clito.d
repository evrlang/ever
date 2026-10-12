module clito;

import std.stdio, axiom, core.stdc.stdlib;

class Clitools
{
    static void helpmenu(string funcname){
        string[] funclist = ["help", "quit"];
        if (funcname == ""){
            writeln("\n\t;help\n\n\t-------------------------");
            writeln("\thelp | print current menu.\n\tquit | out from REPL Mode.");
        } else {
            foreach(kl; funclist){
                if (kl == funcname){
                    if (kl == "help"){
                        writeln("help - REPL");
                        writeln("print a help menu for REPL Mode.");
                        writeln("---------------------------------");
                        writeln("Usage: ;help\n\t;help argument");
                        writeln("\thttps://evrlang.github.io/wiki/repl/help");
                    } else {
                        _error("Help ERROR - No REPL Option with this name `" ~ kl ~"` Exists.");
                    }

                } else {
                    _error("No REPL Option with this name `" ~ kl ~"` Exists.");
                }
            }
        }
    }
    static void end(){
        exit(0);
    }
}