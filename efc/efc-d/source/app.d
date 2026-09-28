import std.stdio, std.file, std.sting;

void main(string[] argv)
{
	if (argv.length == 1)
	{
		auto aa = readText(argv[1]);
		aa = aa.spiltLines();
	} else writeln("Usage: efc [filename.efc]");
}
