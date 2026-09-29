module tok;

import std.stdio, std.string;


string[] tkgenerator(string line)
{
    line = line.strip();
    string cur;
    string[] res;
    bool pr = false;
    foreach(char a; line)
    {
        if (a == '\"'){
            pr = !pr;
            if (pr)
            {
                cur = "";
                cur ~= "\"";
                continue;
            }
            cur ~= a;
            res ~= cur;
            cur = "";
            continue;

        }
        else if (a == ' ' && !pr)
        {
            res ~= cur;
            cur = "";
            continue;
        } else {
            cur ~= a;
            continue;
        }
    }
    cur = cur.strip();
    if (!(cur == ""))
    {
        res ~= cur;
    }
    return res;
}