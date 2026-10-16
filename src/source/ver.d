module ver;

import std.stdio;
import std.json;

public string ever_ver = "0.0.5";
public string config_json = "{\n\t\"ever_cfg\":\"" ~ "0.0.1" ~ "\"";


//COLORS
public string red = "\033[31m";
public string bold = "\033[1m";
public string reset = "\033[0m";
//END_OF_COLORS



public void prHelpMenu()
{
	writeln("\033[1mever (V" ~ ever_ver ~ ") - A Tool for using Ever source files. https://github.com/everlang/ever");
	writeln("	Usage: ./evr [flag] [options]");
    writeln("\nFlags:\n	-e | --enter: Importing a ever program");
	writeln("\t-v | --version: Select core version.");
	writeln("\t-e | --enter: run your script with lastest version if core.");
	writeln("\t-c | --compile: compile your code and create a standalone binary.");
	writeln("\t-f | --config: port your config file to set compiler behavior.");
	writeln("\t-d | --debug: create a output file, and save result of AST on it.");
	writeln("\t--compile --compile-backend:<Language Name> : Use selected language as Backend of Compiler.");
	writeln("\t--compile --compile-linker:<Selected Linker> : Link result object with Selected linker. (Only supported linker can use.) ld - gnu gold - lld");
	writeln("\t--compile-bc-dwarf : allow to create debug information via dwarf debug format using dwarf-4. (only for C-Backend mode for now.)");
	writeln("\nExample: ./evr -e hi.evr\033[0m");
}

