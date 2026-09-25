/*import std.stdio, help, std.file;
import structer, parse, lex, inter, ast;
import std.string;
void main(string[] args)
{
	if (args.length > 1)
	{
		if (args[1] == "-e" || args[1] == "--enter")
		{
			if (exists(args[2]))
			{
				string[] tokena = readText(args[2]).splitLines();
				foreach(line; tokena){
					if (args.length > 3 && args[3] == "--mode:debug"){
						Tokens[] tokenlist = parser(line);
						writeln(tokenlist);
						Node[] lexer_result = Lexer(tokenlist);
						writeln(lexer_result);
						interperter(lexer_result, 1);
					} else {
						Tokens[] tokenlist = parser(line);
					//writeln(tokenlist);
						Node[] lexer_result = Lexer(tokenlist);
					//writeln(lexer_result);
						interperter(lexer_result, 0);
					}
				}
			}
		}
	} else helpmenu();
}*/

module axiom;
public import structer, pars, lex, ast, tokena;
public import cbased;
public import arsd.minigui;