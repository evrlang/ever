/* (C) 2026 - Pouya Mohammadi.
evr2re - convert ever to renim.
*/

module evr2re.evr2re;

import std.stdio, ast, std.string, std.algorithm, evr2re.escapem, std.file, core.stdc.stdlib;

void convert(Node[] asta, string target)
{
    string res;
    res = ".t\n[EPOINT]\n";
    foreach(ast; asta){
    if (auto i = cast(FuncCall)ast)
    {
        if (i.name == "_write")
        {
            string[] lp = i.arguments.split("+");
            string crs;
            foreach(k, pl; lp)
            {
                lp[k] = escapeManager(pl).strip();
                lp[k] = lp[k].replace("\"", "");
                crs ~= lp[k];
            }
            res ~= "\nRENIM \"w\"\nSET \"" ~ crs ~ "\"\nLOADUP %SET";
        }
        }
    }
        res ~= "\nRENIM \"e\"\nVAR 0\nLOADUP %VAR\n[ENDEPOINT]";
        //writeln(res);
        auto j = File("/tmp/_temp_app.en", "w");
        j.write(res);
        j.close();
        system(toStringz("renim /tmp/_temp_app.en"));
        //writeln(target);
        system(toStringz("mv /tmp/_temp_app " ~ target));
}