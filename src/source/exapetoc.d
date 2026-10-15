module escapetoc;

import std.stdio;
import std.json, std.array;
/* 
    escapeManager
    Handle Ever custom escapes.
    1. first must be cp in top.
 */
string escapeManagerC(string txt)
{
    return txt.replace("\\cp", ")")
    .replace("\\c", "(")
    .replace("\\b", "\\\"")
    .replace("\\n", "\\n")
    .replace("\\t", "\\t")
    .replace("\\a", "\\a")
    .replace("\\d", "\\b")
    .replace("\\r", "\\r")
    .replace("\\v", "\\v")
    .replace("\\f", "\\f");
}