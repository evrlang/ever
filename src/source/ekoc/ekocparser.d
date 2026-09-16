module everc.evercparser;

import std.stdio;
import std.string, everc.evercast, everc.everstatic;

ASTNode[] evercparsera(evercToken[] tokens)
{
    ASTNode[] result;
    if (tokens[0].type == everctype.keyword && tokens[1].type == everctype.name && tokens[2].type == everctype.op && tokens[3].type == everctype.valaue)
    {
        result ~= new DefineKeyWord(
            tokens[0].value,
            new BineryOp(
                tokens[2].value,
                new IdeNode(tokens[1].value),
                new StringDefine(tokens[3].value)
            )
        );
    }
    return result;
}