module lexer;

import std.stdio , std.string, std.algorithm;
import structs;

tokens[] lex(string[] tk)
{
    bool ends = false;
    tokens[] res;
    foreach(string la; tk)
    {
        string l = la.strip();
        if (l == "[EPOINT]" && ends == false)
        {
            res ~= tokens(l, Types.Epoint);
            continue;
        } else if (l == "[ENDPOINT]" && ends == false)
        {
            ends = true;
            continue;
        } else if (l.startsWith("."))
        {
            res ~= tokens(l, Types.Section);
            continue;
        } else if (l.startsWith("\"") && l.endsWith("\"") && ends == false)
        {
            res ~= tokens(l, Types.Value);
            continue;
        } else if (l.startsWith("%") && ends == false){
            res ~= tokens(l, Types.Value);
            continue;
        } else {
            if (ends == false) res ~= tokens(l, Types.Func);
            continue;
        }
    }

    return res;
}