import std.stdio, std.string, std.file, error, std.json, std.process, std.typecons, std.conv;
string gsource;
bool stop;
string cclocation;
string returnv;

void main(string[] argv)
{
	int argc = cast(int)argv.length;
	if (argc > 1)
	{
		if (exists(argv[1]))
		{
			if (argv[1].endsWith(".evr") || argv[1].endsWith(".ever")){
				writeln("\033[1m* Welcome to EverDebugger! You are running evrdbg-" ~ ver);
				writeln("  Use \"get docs\" to download lastest and fully Documents.");
				write("  \033[32m[\033[1m*\033[0m\033[32m]\033[0m Put source in Buffer...");
				gsource = readText(argv[1]);
				writeln("\033[1m [Done]");
				 stop = false;
				while(!stop)
				{
					write("\033[1mevrdbg[" ~ argv[1] ~"]> \033[0m");
					manage(argv);
				}
			} else {
				noevr();
			}
		} else {
			fileerror();
		}
	} else {
		help();
	}
}


void help(){
	writeln("evrdbg - A Tool for Debugging Ever source codes and programs.");
	writeln("\nUsage: ./evrdbg [filename|options]");
	writeln("\tUse evrdbg help --sys to show helpmenu of functions.");
	writeln("Options:");
	writeln("\tCC_NAME=\"comiler/interperter name\" | set compiler/interperter for debugging process.");
	writeln("\tENV                                | print all envirment of os.");
}

void manage(string[] argv)
{
	string getin = readln();
	getin = getin.strip();
	if (getin.startsWith("global"))
	{
		string[] spc = getin.split(" ");
		//writeln(spc);
		foreach (la; spc)
		{
			la = la.strip();
			if (la == "0")
			{
				writeln(gsource);
			} else if (la == "1")
			{
				if (returnv != null)
				{
					writeln(returnv);
				} else {
					writeln("[EMPTY]");
				}
			}
		}
	} else if (getin == "exit"){
		write("  \033[32m[\033[1m*\033[0m\033[32m]\033[0m Stop Everdbg and get back to console...");
		stop = true;
		writeln("\033[1m [DONE]\033[0m");
	} else if (getin.startsWith("start")){
		writeln("\033[1m* Note that, If you have not placed the compiler in the system's general binaries folder, you must create an `evrdbg.json` file in the same directory from which you invoked Evrdbg, so that the debugger knows how to call the compiler.");
		
		readforconfig();
		string[] kal = getin.split(" ");
		//writeln(kal);
		if (kal.length > 1)
		{
			string[] jak = gsource.splitLines();

			auto ja = File("/tmp/" ~ kal[1] ~ "-" ~ argv[1], "w");
			ja.write(jak[to!int(kal[1]) - 1]);
			ja.close();

			Tuple!(int, "status", string, "output") ak;
			if (cclocation == "ever"){
				ak = execute(["ever", "-e", "/tmp/" ~ kal[1] ~ "-" ~ argv[1]]);
			} else ak = execute(["." ~ "ever", "-e", "/tmp/" ~ kal[0] ~ "-" ~ argv[1]]);

			returnv = ak.output;

			writeln("\033[1m[DONE]\033[0m");
		} else {
			Tuple!(int, "status", string, "output") ak;
			if (cclocation == "ever"){
				ak = execute(["ever", "-e", argv[1]]);
			} else ak = execute(["." ~ "ever", "-e", argv[1]]);
			returnv = ak.output;
			writeln("\033[1m[DONE]\033[0m");
		}
	}
}

void readforconfig()
{
	if (exists("everdbg.json"))
	{
		auto ja = readText("everdbg.json");
		JSONValue kk = parseJSON(ja);
		if (kk["cc-location"].str != null)
		{
			cclocation = kk["cc-location"].str;
		}
	} else {
		cclocation = "ever";
	}
}