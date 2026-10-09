module lexer;

import std.stdio , std.string, std.algorithm;
import structs;
bool bc = false;
string[] tks;
tokens[] lex(string[] tk)
{
    
    tokens[] res;
    
    foreach(string la; tk)
    {
        string l = la.strip();
        if (bc && l == "[END]"){
            //writeln()
            gbrk ~= Brk(tks);
            res ~= tokens("block", Types.BR);
            tks = null;
            bc = false;
            continue;
        } else if (bc){
            tks ~= l;
            //writeln(tks);
            continue;
        } 
        else if (l == "[EPOINT]" && ends == false)
        {
            res ~= tokens(l, Types.Epoint);
            continue;
        } else if (l == "[ENDPOINT]" && ends == false)
        {
            res ~= tokens(l, Types.End);
            ends = true;
            //writeln(ends);
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
        } else if (l == "[START]"){
            bc = true;
            continue;
        } else {
            if (ends == false) res ~= tokens(l, Types.Func);
            continue;
        }
    }

    return res;
}