module astsupport;

import std.stdio;
import axiom;
import runtime;

import std.file, std.string, std.algorithm, cbackend, core.stdc.stdlib, ver, clito;

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

void compileuseC(string outputname, string filec){
    Node[] result;
    string[] lines = filec.splitLines();
    foreach(string line; lines){
        //writeln(line);
        Tokens[] tks = lexer(line);
        //writeln(tks);
        result ~= parser(tks);
        //writeln(result);
    }
    Cfile resu = cbackend_cc(outputname, result);
    auto resf = File(resu.filename, "w");
    resf.write(resu.filen);
    resf.close();
    system(toStringz("gcc -c " ~ resu.filename ~ " -o " ~ resu.filename.replace(".c", ".o")));
    system(toStringz("gcc " ~ resu.filename.replace(".c", ".o") ~ " -L/usr/local/lib -levrlib -o " ~ resu.filename.replace(".c", "")));
    remove(resu.filename);
    //writeln(result);
}

void cli(){
    //bool ccp = false;
    writeln("\033[1m\033[32mEver\033[0m\033[1m " ~ ever_ver ~ " - (C) 2026 - Pouya Mohammadi.\033[0m");
    writeln("Use `;help` to show help menu. or use `;help option` to see help menu of an option.");
    write("\033[1m>>>\033[0m ");
    repl();

}

void repl(){
    auto hj = readln().strip();
    if (hj.startsWith(";")){
        //CLI Function.
        auto func = hj.split(" ");
        //writeln(func);
        if (func.length >= 1 && func[0] == ";help"){
            Clitools.helpmenu("");
        } else if (func.length == 1 && func[0] == ";quit"){
            Clitools.end();
        }
    } else {
            //writeln(ccp, li);
            Tokens[] tokenlist = lexer(hj);
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
    write("\n\033[1m>>> \033[0m");
    repl();
}