module escapem;

import std.stdio, std.string;

string eout(string current)
{
    return current.replace("\"", "");
}