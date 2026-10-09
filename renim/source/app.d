import std.stdio, std.file, std.string;
import tok, lexer, structs, ast, parser, error, renim_main;
import core.stdc.stdlib;
void main(string[] argv)
{
	if (argv.length > 1)
	{
		auto erd = new StandardError();
		if (!exists(argv[1]) || isDir(argv[1]))
		{
			erd.file_read(argv[1]);
		}
		auto aa = readText(argv[1]);
		string[] aaa = aa.splitLines();
		Node[] final_resu;
		foreach(b; aaa)
		{
			string[] tks = tkgenerator(b);
			//writeln(tks);
			tokens[] trs = lex(tks);
			//writeln(trs);
			auto prs = new Parsing();
			final_resu ~= prs.pars(trs);
			//writeln(final_resu);
		}
		//writeln(final_resu);
		string rs = renim(final_resu);
		//writeln(rs);

		auto fg = std.stdio.File(argv[1].replace(".en", ".asm"), "w");
		fg.write(rs);
		fg.close();
		version(Windows) system(toStringz("nasm -f win64 " ~ argv[1].replace(".en", ".asm") ~ " -o " ~ argv[1].replace(".en", ".obj")));
		version(linux) system(toStringz("nasm -f elf64 " ~ argv[1].replace(".en", ".asm") ~ " -o " ~ argv[1].replace(".en", ".o")));
		if (exists(argv[1].replace(".asm", "")))
		{
			version(linux) writeln("gcc -no-pie "  ~ argv[1].replace(".en", ".o") ~ " -o " ~ argv[1].replace(".en", "") ~ " -L/usr/local/lib -levrlib");
			version(linux) system(toStringz("gcc -no-pie "  ~ argv[1].replace(".en", ".o") ~ " -o " ~ argv[1].replace(".en", "") ~ " -L/usr/local/lib -levrlib"));
			version(Windows) system(toStringz("lld-link "  ~ argv[1].replace(".en", ".obj") ~ " kernel32.lib -entry:_start -subsystem:console -out:" ~ argv[1].replace(".en", ".exe")));

		}
	} else writeln("Usage: renim [filename.re]");
}
