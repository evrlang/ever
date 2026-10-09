module astsupport;

import std.stdio;
import axiom;
import runtime;

import std.file, std.string, std.algorithm;

bool ccp = false;
void astSupportRun(string filepath, int mode)
{
    if (exists(filepath))
    {
        auto fileline = readText(filepath).splitLines();
        foreach(li; fileline)
        {
            //writeln(ccp, li);
            if (ccp)
            {
                if (li.startsWith("*#"))
                {
                    ccp = false;
                    continue;
                } else continue;
            }
            if (li.startsWith("#*")){
                ccp = true;
                continue;
            }
            if (li.startsWith("#")) continue;
            if (li.startsWith("//")) continue;
            
            Tokens[] tokenlist = lexer(li);
			//writeln(tokenlist);
			Node[] parser_result = parser(tokenlist);
			//writeln(parser_result);
            //if (mode == 1) writeln(parser_result);
            map_str["@RED"] = "\033[31m";
            map_str["@RESET"] = "\033[0m";
            map_str["@BOLD"] = "\033[1m";
            map_str["@GREEN"] = "\033[32m";
			interp(parser_result, 0);
        }
    }
}

void astSupportLine(string li, int mode)
{

    Tokens[] tokenlist = lexer(li);
			//writeln(tokenlist);
	Node[] parser_result = parser(tokenlist);
    if (mode == 1) writeln(parser_result);
			//writeln(lexer_result);
	interp(parser_result, 0);
}


void astSupportCompile(string liq)
{
    string target = liq.replace(".evr", "").replace(".ever", "");
    auto fileline = readText(liq).splitLines();
    Node[] gb;
        foreach(li; fileline)
        {
            //writeln(ccp, li);
            if (ccp)
            {
                if (li.startsWith("*#"))
                {
                    ccp = false;
                    continue;
                } else continue;
            }
            if (li.startsWith("#*")){
                ccp = true;
                continue;
            }
            if (li.startsWith("#")) continue;
            if (li.startsWith("//")) continue;
            
            Tokens[] tokenlist = lexer(li);
			//writeln(tokenlist);
			gb = parser(tokenlist);
			//writeln(parser_result);
            //if (mode == 1) writeln(parser_result);
        }
        convert(gb, target);
}

void debg(string filen, int mode){
    if (mode == 1)
    {
        string[] lines = filen.splitLines();
        foreach(string li; lines){
            Tokens[] tokenlist = lexer(li);
			//writeln(tokenlist);
		    Node[] parser_result = parser(tokenlist);
            auto ak = File("output.txt", "w");
            ak.write(parser_result, "\n--TOKENS--\n", tokenlist);
            ak.close();
        }
    }
}