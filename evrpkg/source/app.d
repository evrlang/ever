import std.stdio, argin;

void main(string[] args)
{
	if (args.length > 1)
	{
		arginit(args);
	} else {
		help_menu();
	}
}

void help_menu()
{
	writeln("evrpkg - A minimal Package Manager for Ever");
	writeln("usage:\t./evrpkg [option] [link]");
	writeln("options:");
	writeln("\tinstall: Install an Ever Program from link in current device/system.");
	writeln("\tupload: Add your project to evrpkg github repo.");
	writeln("\tremove: Remove an Ever Installed Program from this computer.");
	writeln("\nPackages are hosted on github, and indexed in https://github.com/evrlang/evrpkg.");
	writeln("Report abuse: https://github.com/evrlang/evrpkg/issues");
}