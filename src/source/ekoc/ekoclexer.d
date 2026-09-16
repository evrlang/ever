module everc.everclexer;
import everc.everstatic;
string[] keywords = ["S"];
import std.stdio, std.string, std.algorithm;
evercToken[] everclex(string[] toks)
{
    evercToken[] tokens;
    foreach(i; toks)
    {
        bool k = false;
        foreach(o; keywords)
        {
            if (i == o)
            {
                tokens ~= evercToken(i, everctype.keyword);
                k = true;
            }
        }
        if (k)
        {
            k = false;
            continue;
        }
        if (i.startsWith("@"))
        {
            tokens ~= evercToken(i, everctype.name);
        } else if (i == "=") tokens ~= evercToken(i, everctype.op);
        else tokens ~= evercToken(i, everctype.valaue);
    }

    return tokens;
}