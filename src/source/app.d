import std.stdio;
import std.file, std.regex, std.string, std.algorithm, core.stdc.stdlib, std.conv;
public import axiom;
import astsupport, ver, arg;


int oa = 0;
string aj;

void main(string[] args)
{
	if (args.length < 2){
		cli();
	} else {
		args_manager(args);
		//writeln(config_json);
	}
}