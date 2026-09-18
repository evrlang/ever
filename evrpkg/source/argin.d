module argin;

import std.stdio, std.regex, std.string, std.path, std.json, core.stdc.stdlib, std.file, std.string;
import std.net.curl;
void arginit(string[] args)
{
    if (args[1] == "install")
    {
        if (!exists(expandTilde("~/.evrpkg")) || !isDir(expandTilde("~/.evrpkg")))
        {
            mkdir(expandTilde("~/.evrpkg"));
        }
        if (!exists(expandTilde("~/.evrpkg/index.json")))
        {
            writeln("Index access was unavailable. Update the index using evrpkg update.");
            exit(1);
        }
        if (args[2].startsWith("@")){
            //system("wget -q https://raw.githubusercontent.com/evrlang/evrpkg/refs/heads/main/index.json");
            JSONValue root = parseJSON(readText(expandTilde("~/.evrpkg/index.json")));
            string ver = root["version"].str;
            //writeln("\033[1m\033[32mIndex file version ", ver, " fetched. It will be used as the source for packages.\033[0m");
            auto vg = get("https://raw.githubusercontent.com/evrlang/evrpkg/refs/heads/main/last.txt");
            auto gf = File(expandTilde("~/.evrpkg/last.txt"), "w");
            gf.write(vg);
            gf.close();
            if(ver != readText(expandTilde("~/.evrpkg/last.txt")).strip()){
                writeln("Notice: May you need update your Package index with everpkg update?");
            }
            JSONValue pkginfo = root["package"];
            foreach (JSONValue pkg; pkginfo.array)
            {
                auto l = regex(`@([^:]+):(\S+)`);
                auto k = match(args[2], l);
                if (k.empty)
                {
                    writeln("\033[31m\033[1mError: Wrong format. standard: @user:pkgname");
                    exit(1);
                }
                if (pkg["username"].str == k.captures[1] && pkg["pkgname"].str == k.captures[2])
                {
                    bool preinstalled = false;
                    if (exists(pkg["pkgname"].str) && isDir(pkg["pkgname"].str))
                    {
                        rmdirRecurse(expandTilde(pkg["pkgname"].str));
                        if (exists(expandTilde("~/evrpkg/") ~ pkg["pkgname"].str) && isDir(expandTilde("~/evrpkg/") ~ pkg["pkgname"].str))
                        {
                            preinstalled = true;
                            rmdirRecurse(expandTilde("~/.evrpkg/pkgs/" ~ pkg["pkgname"].str));
                        }
                    }
                    if (pkg["source"].str.startsWith("https://github.com/")) system(toStringz("git clone --depth 1 " ~ pkg["source"].str));
                    else {
                        auto lk = get(pkg["source"].str);
                        std.file.write(pkg["pkgname"].str ~ ".evrpk", lk);
                    }
                    writeln("\033[32m\033[1mDownload @" ~ pkg["username"].str ~ ":" ~ pkg["pkgname"].str ~ " finished.\033[0m");
                    writeln(pkg["desc"].str);
                    mkdirRecurse(expandTilde("~/.evrpkg/pkgs/" ~ pkg["pkgname"].str));
                    rename(expandTilde(pkg["pkgname"].str), expandTilde("~/.evrpkg/pkgs/" ~ pkg["pkgname"].str));
                    writeln("Install progress finshed, Done.");
                    if (exists(expandTilde("~/.evrpkg/list.txt")) && readText(expandTilde("~/.evrpkg/list.txt")).indexOf(args[2]) == -1)
                    {
                    	auto file = File(expandTilde("~/.evrpkg/list.txt"), "a");
                    	file.write(pkg["pkgname"].str ~ "\n");
                    	file.close();
                    } else {
                        auto file = File(expandTilde("~/.evrpkg/list.txt"), "w");
				        file.write(pkg["pkgname"].str ~ "\n");
				        file.close();
                    }
                } else {
                    write("\033[31m\033[1mError: " ~ "\033[0m");
                    write("The requested package does not exist in the current index file.\nUpdating the index file may solve the problem.\n");
                    exit(1);
                }
            }
        } else {
            writeln("\033[1m\033[31mError: Need code owner name (example @user:pkgname)\033[0m");
            exit(1);
        }
        
    } else if (args[1] == "update")
    {
        if (!exists(expandTilde("~/.evrpkg")))
        {
            mkdir(expandTilde("~/.evrpkg"));
        }
        auto vg = get("https://raw.githubusercontent.com/evrlang/evrpkg/refs/heads/main/index.json");
        auto gf = File(expandTilde("~/.evrpkg/index.json"), "w");
        gf.write(vg);
        gf.close();
        JSONValue root = parseJSON(readText(expandTilde("~/.evrpkg/index.json")));
        string ver = root["version"].str;
        writeln("\033[1m\033[32mIndex file version ", ver, " fetched. It will be used as the source for packages.\033[0m");
    } else if (args[1] == "clean"){
        if (exists(expandTilde("~/.evrpkg")) && isDir(expandTilde("~/.evrpkg"))) rmdirRecurse(expandTilde("~/.evrpkg"));
    } else {
        foreach(pkg; readText(expandTilde("~/.evrpkg/list.txt")).splitLines())
        {
            pkg = pkg.strip();
            if (pkg.strip() == args[1] && exists(expandTilde("~/.evrpkg/pkgs/"  ~ pkg)) && isDir(expandTilde("~/.evrpkg/pkgs/") ~ pkg.strip()))
            {
                //writeln(expandTilde("~/.evrpkg/" ~ pkg.strip() ~ "/") ~ pkg.strip() ~ ".ever");
                system(toStringz("ever -ast " ~ expandTilde("~/.evrpkg/pkgs/" ~ pkg.strip() ~ "/") ~ pkg.strip() ~ ".ever"));
                //writeln("ever -ast " ~ expandTilde("~/.evrpkg/pkgs/" ~ pkg.strip() ~ "/") ~ pkg.strip() ~ ".ever");
            } else {
                continue;
            }
        }
    }
}
