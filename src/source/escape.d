module escape;

import std.stdio;
import std.json, std.array;
/* 
    escapeManager
    Handle Ever custom escapes.
    1. first must be cp in top.
 */
string escapeManager(string txt)
{/*
    string reslt;
    bool scape = false;
    foreach(char a; txt){
        if (a == '\\')
        {
            scape = true;
            continue;
        } else if (a == 'n' && scape)
        {
            reslt ~= "\n";
            scape = false;
            continue;
        } else if (a == 'c')
        {
            reslt ~= "(";
            scape = false;
            continue;
        } else if (a == 'b' && scape)
        {
            reslt ~= "\"";
            scape = false;
            continue;
        } else if(a == '')
    }*/
    return txt.replace("\\cp", ")")
    .replace("\\c", "(")
    .replace("\\b", "\"")
    .replace("\\n", "\n")
    .replace("\\t", "\t")
    .replace("\\a", "\a")
    .replace("\\d", "\b")
    .replace("\\r", "\r")
    .replace("\\v", "\v")
    .replace("\\f", "\f");
}