module evr2re.escapem;

import std.stdio, std.string;
string escapeManager(string l){
    return l.replace("\\b", "\"").replace("\\p", "(").replace("\\cp", ")");
}