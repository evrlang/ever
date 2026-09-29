module parser;

import std.stdio, structs, ast;
class Parsing {
    public static Node[] pars(tokens[] tj)
    {
        Node[] resa;
        if (tj.length == 2 && tj[0].type == Types.Func && tj[1].type == Types.Value)
        {
            resa ~= new DefineFunction(tj[0].value, tj[1].value);
        } else if (tj.length == 1 && tj[0].type == Types.Epoint)
        {
            resa ~= new EntryPointDefine();
        } else if (tj.length == 1 && tj[0].type == Types.Section)
        {
            resa ~= new SectionDefine(tj[0].value);
        }
        return resa;
    }
}