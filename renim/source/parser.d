module parser;

import std.stdio, structs, ast, std.array, std.algorithm, lexer;
class Parsing {
    public static Node[] pars(tokens[] tj)
    {
        Node[] resa;
        if (tj.length >= 2 && tj[0].type == Types.Func && tj[1].type == Types.Value)
        {
            resa ~= new DefineFunction(tj[0].value, tj[1].value);
            tj.remove(0);
            tj.remove(0);
        } else if (tj.length >= 1 && tj[0].type == Types.Epoint)
        {
            resa ~= new EntryPointDefine();
            tj.remove(0);
        } else if (tj.length >= 1 && tj[0].type == Types.Section)
        {
            resa ~= new SectionDefine(tj[0].value);
            tj.remove(0);
        } else if (tj.length >= 1 && tj[0].type == Types.End){
            resa ~= new EndEntryPointDefine();
            tj.remove(0);
        } else if (tj.length >= 1 && tj[0].type == Types.BR){
            resa ~= new BlockDefine(pars(lex(gbrk[0].bod)));
            writeln(resa);
            writeln("BD: ", pars(lex(gbrk[0].bod)));
            gbrk.remove(0);
            tj.remove(0);
        }
        writeln(tj);
        writeln(resa);
        return resa;
    }
}