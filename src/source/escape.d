module escape;

import std.stdio;
import std.json, std.array;
/* 
    escapeManager
    Handle Ever custom escapes.
    1. first must be cp in top.
 */
string escapeManager(string txt)
{
    return txt.replace("\\cp", ")").replace("\\c", "(").replace("\\b", "\"");
}