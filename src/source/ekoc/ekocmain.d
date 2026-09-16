module everc.evermain;
import std.stdio, everc.evercast, everc.everclexer, everc.evercparser, everc.everctoken, everc.everstatic;
import axiom;

string[string] str_map;

void evercmain_run(string[] lines)
{
    foreach(o; lines)
    {
        string[] opa = everc_token(o);
        writeln(opa);
        evercToken[] ever_res = everclex(opa);
        writeln(ever_res);
        ASTNode[] node_res = evercparsera(ever_res);
        writeln(node_res);
        everc_interperter(node_res);
    }
}

void everc_interperter(ASTNode[] asd)
{
    foreach(ast; asd)
    {
        if (auto key = cast(DefineKeyWord)ast)
        {
            if (key.type == "S")
            {
                if (auto key2 = cast(BineryOp)key.value)
                {
                    if (auto key3 = cast(StringDefine)key2.right)
                    {
                        if (auto key4 = cast(IdeNode)key2.left)
                        {
                            str_map[key4.name] = key3.value;
                        }
                    }
                }
                //str_map[ajja.value] = jaka;
                writeln(str_map); //for test
            }
        }
    }
}