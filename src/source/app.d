import std.stdio;
import std.file, std.regex, std.string, std.algorithm, core.stdc.stdlib, std.conv;
public import axiom;
import astsupport;


int oa = 0;
string aj;
public string ever_ver = "0.0.5";
string red = "\033[31m";
string bold = "\033[1m";
string reset = "\033[0m";

void prHelpMenu()
{
	writeln("\033[1mever (V" ~ ever_ver ~ ") - A Tool for using Ever source files. https://github.com/everlang/ever");
	writeln("	Usage: ./evr [flag] [options]");
    writeln("\nFlags:\n	-e | --enter: Importing a ever program");
	writeln("\t-v | --version: Select core version.");
	writeln("\t-e | --enter: run your script with lastest version if core.");
	writeln("\t-c | --compile: compile your code and create a standalone binary.");
	writeln("\t-f | --config: port your config file to set compiler behavior.");
	writeln("\nExample: ./evr -e hi.evr\033[0m");
}

void main(string[] args)
{
	if (args.length < 2){
		prHelpMenu();
	}else if (args[1] == "--compile" || args[1] == "-c")
	{
		if ((args.length <= 2) || (args.length > 2 && !exists(args[2])))
		{
			writeln(red ~ bold ~ "Error:" ~ reset ~" The imported file does not exist.");
			exit(1);
		}
		writeln("Please note that the compiler is currently in " ~ "\033[1m" ~"beta " ~ "\033[0m" ~", and it does not support all functions. It is unstable and is not supported on all platforms.");
		astSupportCompile(args[2]);
    } else if (args[1] == "-v" || args[1] == "--version")
	{
		writeln("\033[1mever (V" ~ ever_ver ~ ") " ~ __DATE__ ~ " " ~ __TIME__);
	} else if (args[1] == "-h" || args[1] == "--help")
	{
		prHelpMenu();
	} else if (args[1] == "-e" || args[1] == "--enter")
	{
		if ((args.length <= 2) || (args.length > 2 && !exists(args[2])))
		{
			writeln(red ~ bold ~ "Error:" ~ reset ~" The imported file does not exist.");
			exit(1);
		}
		astSupportRun(args[2], 0);
	} else if (args[1] == "-d" || args[1] == "--debug"){
		if (args.length > 1 && exists(args[2])){
			debg(readText(args[2]), 1);
		} else {
			writeln(red ~ bold ~ "Error:" ~ reset ~" The imported file does not exist.");
			exit(1);
		}
	} else {
		prHelpMenu();
		writeln(red ~ bold ~ "Error:" ~ reset ~" There is no comment like the one you entered.");
		exit(1);
	} 
}

private void ierror(string msg)
{
	writeln(red ~ bold ~ "Error: " ~ reset ~ bold ~ msg ~ reset);
	exit(1);
}