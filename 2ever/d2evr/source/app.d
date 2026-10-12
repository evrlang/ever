import std.stdio;
import dmd.frontend;
import std.file;

public string ver = "0.0.1-" ~ __TIME__ ~ " " ~ __DATE__;
void helpmenu(){
	writeln("D2EVR - Translate D source code to Ever source code.");
	writeln("	\tUsage: ./d2evr hi.d -o hi.evr");
	writeln("Options:");
	writeln("\t-o | --output: set output name.");
	writeln("\t-v | --version: write version of d2evr in stdout.");
	writeln("Under GPL-V3-Only, (C) 2026. Pouya Mohammadi.");
}
void main(string[] argv)
{
	if (argv.length >= 2){
		if (argv[1] == "-v" || argv[1] == "--version"){
			writeln(ver);
		} else if (exists(argv[1]) && args.length >= 3 && (argv[2] == "-o" || argv[2] == "--output")){
			auto res = parseModule(argv[1], readText(argv[1]));
			auto err = res.diagnostics;
			if (!err.hasErrors){
				writeln(res.module_);
			}
		}
	} else {
		helpmenu();
	}
}
