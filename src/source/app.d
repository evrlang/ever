import std.stdio;
import init_prog;
import error;
import std.file, std.regex, std.string, std.algorithm, core.stdc.stdlib, std.conv;
import infss;
public import marschiert;
public import axiom;
import astsupport;
// web server
import handy_httpd;
import handy_httpd.handlers.file_resolving_handler;
import everc.evermain;
int oa = 0;
string aj;
//import argparse;
string ever_ver = "0.0.4";
void prHelpMenu()
{
	writeln("\033[1mever (V0.0.5) https://github.com/everlang/ever");
		writeln("	Usage: ./ever [flag] [options]");
        writeln("\nFlags:\n	-e | --enter: Importing a ever program");
		//writeln("	-ge| --generate-exe: Generate an executable binary as a standalone application.");
		writeln("	-n | --normal: Run the interpreter in normal mode (without interpretation messages)");
		writeln("	-d | --debug: Run the interpreter in debug mode and display messages during the interpretation process.");
		//writeln("	-x | --xdoc: Offline Documents in localhost.");
		//writeln("	-v | --version: show version of everInterperter.");
		//writeln("	-h | --help: show current menu.");
		// writeln("	-spe | --sboxprinterror: Show errors of SboX.");
		//writeln("	-adebug | --asm-debug: Print result of everC to NASM.");
		//writeln("	-cdebug | --csc-debug: Printf ever to everC result.");
		writeln("	-td | --term-debugger: run terminal-based Debugger.");
		writeln("	-ast | --abstract-syntax-tree: Use AST to run your program. (BETA)");
		writeln("Versions:");
		writeln("	marschiert(runtime librray): " ~ _version);
		writeln("	ever: 0.0.5");
		writeln("\nExample: ./ever -e hi.ever -n\033[0m");
}
void main(string[] args)
{
	/*
	auto argm = new ArgumentParser();
	argm.addArgument(
		["-ge", "--generate-exe"],
		"Generate an executable binary as a standalone application.",
		infs(args[2], "cc", "ll", 0)
	);
	argm.addArgument(
		["-e", "--enter"],
		"run interperter for an ever program",
		infs(args[2], "normal", "ll", 0)
	);
	argm.addArgument(
		["-v", "--version"],
		"Show version of ever",
		writeln("\033[1mever " ~ ever_ver ~" " ~ __DATE__ ~ " " ~ __TIME__)
	);
	argm.addArgument(
		["-ast", "--abstract-syntax-tree"],
		"Use AST to run your program. (BETA)",
		astSupportRun(args[2])
	);
	*/
	if (args.length < 2){
		prHelpMenu();
        //prinPanic("WUT");
    } else if(args[1] == "-e" || args[1] == "--enter" || args[1] == "--generate-exe" || args[1] == "-ge"){
        if (exists(args[2])){
			try {
			if (args[3] == "-d" || args[3] == "--debug"){
				if (args[1] == "-ge" || args[1] == "--generate-exe")
				{
					infs(args[2], "cc", "ll", 0);
				} else {
					infs(args[2], "debug", "ll", 0);
				}
			} else if(args[3] == "-n" || args[3] == "--normal"){
				if (args[1] == "-ge" || args[1] == "--generate-exe"){
					infs(args[2], "cc", "ll", 0);
				} else {
					if (args.length > 3 && args[3] == "--print:ast") infs(args[2], "normal", "ll", 1); //fixed for bug/C002
            		else infs(args[2], "normal", "ll", 0);
				}
			}
			} catch(Exception e){

			}
        } else {
            prinPanic(kodes._no_file, "import userfile");
        }
    } else if (args[1] == "-v" || args[1] == "--version")
	{
		writeln("\033[1mever (v0.0.4) " ~ __DATE__ ~ " " ~ __TIME__);
	} else if (args[1] == "-h" || args[1] == "--help")
	{
		prHelpMenu();
	} else if (args[1] == "-td" || args[1] == "--term-debugger")
	{
		writeln("\033[1mever-Term-Debugger V0.0.1 based on ever Version 0.1\033[0m");
		writeln("\033[34mhttps://github.com/anhumandev/ever/p-term-debugger/\033[0m");
		writeln("\033[1m\n\t[I]: Run \"help\" to get list of functions and a help menu.\033[0m");
		writeln("");
		ctermde();
	} else if (args[1] == "-rv" || args[1] == "--runtime-version")
	{
		writeln("\033[1mMarschiert (runtime library for ever) " ~ _version ~ "\n© 2026 All rights reserved.\033[0m");
	} else if (args[1] == "-x" || args[1] == "--xdoc")
	{
		auto evera = new FileResolvingHandler(".");
		new HttpServer().start();
	} else if (args[1] == "-ast" || args[1] == "--abstract-syntax-tree")
	{
		if(args.length > 3 && args[3] == "--print:ast") astSupportRun(args[2], 1);
		else astSupportRun(args[2], 0);
	} else if(args[1] == "--enable-test:everc")
			{
				auto jaa = readText(args[2]);
				auto ajj = jaa.splitLines();
				evercmain_run(ajj);
			}
}

void ctermde()
{
	//int oa = 0;
	write("(ever-term-debugger) ");
	auto jaj = readln();
	if (jaj.strip() == "help")
	{
		help();
		ctermde();
	} else if (jaj.startsWith("include"))
	{
		auto ja = regex(`include (\S+) (\S+)`);
		auto ja2 = match(jaj, ja);
		if (!ja2.empty)
		{
			if (exists(ja2.captures[1])){
				if (ja2.captures[2] == "exe"){
					aj = ja2.captures[1];
					infs(ja2.captures[1], "cc", "ll", 0);
					oa = 1;
					ctermde();
				} else if(ja2.captures[2] == "engine"){
					infs(ja2.captures[1], "debug", "ll", 0);
					
					ctermde();
				}
			}
		}
	} else if (jaj.strip() == "exit"){
		exit(0);
	} else if (jaj.strip() == "asm"){
		if (oa == 1)
		{
			infs(aj, "cc", "d", 0);
			ctermde();
		} else {
			writeln("first run \"include FILENAME exe\" then try again.");
			ctermde();
		}
	} else {
		writeln("\033[1m\033[31mThe debugger received an undefined command.\033[0m");
		ctermde();
	}
}

void help()
{
	writeln("A quick Help Menu for csl-term-debugger.");
	writeln("\n\thelp: show current menu.");
	writeln("\tinclude FILEPATH [option=exe, engine]: run or compile a csl file in debug mode.");
	writeln("\tasm: show result of convert ever to asm. (just work in include exe.)");
	writeln("\tcsc: show result of convert ever to everC. (just work in include exe.)");
}
