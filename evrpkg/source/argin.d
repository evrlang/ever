module argin;

import std.stdio, std.regex, std.string, std.path, std.json, core.stdc.stdlib, std.file, std.string;

void arginit(string[] args)
{
    if (args[1] == "install")
    {
        if (!exists(expandTilde("~/.evrpkg")) || !isDir(expandTilde("~/.evrpkg")))
        {
            system("mkdir ~/.evrpkg");
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
            system("wget -q -P ~/.evrpkg/ https://raw.githubusercontent.com/evrlang/evrpkg/refs/heads/main/last.txt");
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
                        system(toStringz("rm -r " ~ pkg["pkgname"].str));
                        if (exists(expandTilde("~/evrpkg/") ~ pkg["pkgname"].str) && isDir(expandTilde("~/evrpkg/") ~ pkg["pkgname"].str))
                        {
                            preinstalled = true;
                            system(toStringz("rm -r " ~ expandTilde("~/evrpkg/pkg/") ~ pkg["pkgname"].str));
                        }
                    }
                    if (pkg["source"].str.startsWith("https://github.com/")) system(toStringz("git clone --depth 1 " ~ pkg["source"].str));
                    else system(toStringz("wget -q -P ~/.evrpkg/ " ~ pkg["source"].str));
                    writeln("\033[32m\033[1mDownload @" ~ pkg["username"].str ~ ":" ~ pkg["pkgname"].str ~ " finished.\033[0m");
                    writeln(pkg["desc"].str);
                    system(toStringz("mv " ~ pkg["pkgname"].str ~ " ~/.evrpkg/pkgs/"));
                    writeln("Install progress finshed, Done.");
                    if (readText(expandTilde("~/.evrpkg/list.txt")).indexOf(args[2]) == -1)
                    {
                    auto file = File(expandTilde("~/.evrpkg/list.txt"), "a");
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
        system("wget -q -O ~/.evrpkg/index.json https://raw.githubusercontent.com/evrlang/evrpkg/refs/heads/main/index.json");
        JSONValue root = parseJSON(readText(expandTilde("~/.evrpkg/index.json")));
        string ver = root["version"].str;
        writeln("\033[1m\033[32mIndex file version ", ver, " fetched. It will be used as the source for packages.\033[0m");
    } else if (args[1] == "clean"){
        system(toStringz("rm -r " ~ expandTilde("~/.evrpkg/")));
    } else {
        foreach(pkg; readText(expandTilde("~/.evrpkg/list.txt")).splitLines())
        {
            //writeln(pkg.strip);
            if (exists(expandTilde("~/.evrpkg/pkgs/") ~ pkg.strip()) && isDir(expandTilde("~/.evrpkg/pkgs/") ~ pkg.strip()))
            {
                //writeln(expandTilde("~/.evrpkg/" ~ pkg.strip() ~ "/") ~ pkg.strip() ~ ".ever");
                system(toStringz("ever -ast " ~ expandTilde("~/.evrpkg/pkgs/" ~ pkg.strip() ~ "/") ~ pkg.strip() ~ ".ever"));
            } else {
                continue;
            }
        }
    }
}