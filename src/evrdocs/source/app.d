import std.stdio, helpmenu, std.file;
import axiom, std.string;

public string verevrdocs = "0.0.1 " ~ __DATE__ ~ " " ~ __TIME__;
void main(string[] argv)
{
	string html_content = "<!DOCTYPE HTML><html><head><title>Generated documents</title></head><body>";
	if(argv.length >= 2){
		if (argv[1] == "-v" || argv[1] == "--version"){
			writeln(verevrdocs);
		} else if (argv.length >= 3 && (argv[1] == "-e" || argv[1] == "--enter") && exists(argv[2])){
			auto filec = readText(argv[2]);
			auto filel = filec.splitLines();
			Node[] resu;
			foreach(line; filel){
				Tokens[] tk = lexer(line);
				resu ~= parser(tk);
			}
			foreach(l; resu)
			{
				if (auto p = cast(DefineKeyWord)l)
				{
					html_content = html_content ~ "<h1>" ~ p.name ~ "</h1><p>type: " ~ p.type.replace("<", "&lt;").replace(">", "&gt;").replace("&", "&amp;") ~ "<p>" ~ p.value ~ "</p><p>Description: Define a value with <code>" ~ p.type ~ "</code> type, with name <code>" ~ p.name ~ "</code>, equal to <code>" ~ p.value ~ "</code>\n";
				} else if (auto p = cast(FuncCall)l)
				{
					html_content = html_content ~ "<h1>" ~ p.name ~ "</h1>";
					if (p.name == "_write") html_content = html_content ~ "<p>Description: write " ~ p.arguments ~ " to stdout.</p>";
				}
			}
			html_content = html_content ~ "</body></html>";
			auto fi = File(argv[2].replace(".evr", "") ~ ".html", "w");
			fi.write(html_content);
			fi.close();
			writeln("\033[1m\033[34mGenerate\033[0m documents for \033[1m" ~ argv[2] ~ ".\033[0m");
		}
	} else helpm();
}
