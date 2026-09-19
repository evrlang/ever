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
string red = "\033[31m";
string bold = "\033[1m";
string reset = "\033[0m";

void prHelpMenu()
{
	writeln("\033[1mever (V0.0.5) https://github.com/everlang/ever");
		writeln("	Usage: ./ever [flag] [options]");
        writeln("\nFlags:\n	-e | --enter: Importing a ever program");
		//writeln("	-ge| --generate-exe: Generate an executable binary as a standalone application.");
		writeln("	-ver | --version: Select core version.");
		writeln("	(Only work in ver=0.0.4)-n | --normal: Run the interpreter in normal mode (without interpretation messages)");
		writeln("	(Only work in ver=0.0.4)-d | --debug: Run the interpreter in debug mode and display messages during the interpretation process.");
		//writeln("	-x | --xdoc: Offline Documents in localhost.");
		//writeln("	-v | --version: show version of everInterperter.");
		//writeln("	-h | --help: show current menu.");
		// writeln("	-spe | --sboxprinterror: Show errors of SboX.");
		//writeln("	-adebug | --asm-debug: Print result of everC to NASM.");
		//writeln("	-cdebug | --csc-debug: Printf ever to everC result.");
		//writeln("	-td | --term-debugger: run terminal-based Debugger.");
		writeln("	-e | run your script with lastest version if core.");
		writeln("Versions:");
		writeln("	ever: 0.0.5");
		writeln("\nExample: ./ever -e hi.ever\033[0m");
		writeln("./ever -ver=0.0.4 -e hi.ever -n");
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
    } else if(args[1] == "-ver=0.0.4" && args[2] == "-e" || args[2] == "--enter"){
        if (exists(args[3])){
			try {
			if (args[4] == "-d" || args[4] == "--debug"){
				infs(args[3], "debug", "ll", 0);
			} else if(args[4] == "-n" || args[4] == "--normal"){
            	infs(args[3], "normal", "ll", 0);
			}
			} catch(Exception e){
				ierror(e.msg);
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
	} else if (args[1] == "-e" || args[1] == "--enter")
	{
		astSupportRun(args[2], 0);
	} else if(args[1] == "--enable-test:everc")
			{
				auto jaa = readText(args[2]);
				auto ajj = jaa.splitLines();
				evercmain_run(ajj);
			}
}

private void ierror(string msg)
{
	writeln(red ~ bold ~ "Error: " ~ reset ~ bold ~ msg ~ reset);
	exit(1);
}