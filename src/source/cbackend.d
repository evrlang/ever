/*
    (C) - 2026 written by Pouya Mohammadi.
    Main - C-backend compile file.
    Part of evr-linux
*/

module cbackend;

import std.stdio;
import std.string;
import std.algorithm;
import axiom;
import std.conv;
import escapetoc;
struct Cfile
{
    string filename;
    string filen;
}

//HASH_TABLES

string[string] global_charp;
string[string] global_const_char_p;
string[string] global_char_max;
int[string] global_int;

//END_OF_HASHS

bool strisDigit(string str){
    bool result = true;
    try {
        int o = to!int(str);
    } catch (Exception e){
        result = false;
    }
    //writeln(result);
    return result;
}
bool hsd = false;
string getArrayType(string a)
{
    string resu = "";
    
    foreach(char b; a)
    {
        //writeln(b);
        if (hsd && b != '>'){
            resu ~= b;
            continue;
        } else if (b == '<')
        {
            hsd = true;
            continue;
        } else if (b == '>'){ break;
        } else {
            continue;
        }
    }
    //writeln(resu);
    hsd = false;
    return resu;
}
string[] ckeywords = ["char", "const", "int", "do", "auto", "continue", "default", "case", "break", "double", "while"];
string[] stdfuncs = ["write"];
Cfile cbackend_cc(string outputname, Node[] asts){
    //writeln(asts);
    string content = "#include <stdio.h>\n#include \"evrlib.h\"\nint main(int argc, char *argv[]){\n";
    foreach(Node u; asts){
        //writeln(u);
    if (auto ast = cast(DefineKeyWord)u){
        if (ast.type == "const<char>*"){
            if (!(ast.name.startsWith("@"))){
                _error("In Ever, Name of values must start with `@`. (In const<char>*)");
            }
            for (int i = 0; i < 9; i++){
                if (ast.name.startsWith(to!string(i))){
                    _error("In C-Backend mode, you can't starts a value name with a number.");
                }
            }
            foreach(keyword; ckeywords){
                if (ast.name.replace("@", "") == keyword){
                    _error("In C-Backend mode, you can't use a keyword name `" ~ keyword ~ "` as name of a value.");
                }
            }
            global_const_char_p[ast.name.replace("@", "")] = escapeManagerC(ast.value);
            content ~= "const char* " ~ ast.name.replace("@", "") ~ " = \"" ~ ast.value ~ "\";\n";
        } else if (ast.type == "char<*>"){
            if (!(ast.name.startsWith("@"))){
                _error("In Ever, Name of values must start with `@`. (In char<*>)");
            }
            for (int i = 0; i < 9; i++){
                if (ast.name.replace("@", "").startsWith(to!string(i))){
                    _error("In C-Backend mode, you can't starts a value name with a number.");
                }
            }
            foreach(keyword; ckeywords){
                if (ast.name.replace("@", "") == keyword){
                    _error("In C-Backend mode, you can't use a keyword name `" ~ keyword ~ "` as name of a value.");
                }
            }
            global_charp[ast.name.replace("@", "")] = escapeManagerC(ast.value);
            content ~= "char* " ~ ast.name.replace("@", "") ~ " = \"" ~ ast.value ~ "\";\n";
        } else if (ast.type == "char<max>" || ast.type == "string"){
            if (!(ast.name.startsWith("@"))){
                _error("In Ever, Name of values must start with `@`. (In char<max>)");
            }
            for (int i = 0; i < 9; i++){
                if (ast.name.startsWith(to!string(i))){
                    _error("In C-Backend mode, you can't starts a value name with a number.");
                }
            }
            foreach(keyword; ckeywords){
                if (ast.name.replace("@", "") == keyword){
                    _error("In C-Backend mode, you can't use a keyword name `" ~ keyword ~ "` as name of a value.");
                }
            }
            global_char_max[ast.name.replace("@", "")] = escapeManagerC(ast.value);
            content ~= "char " ~ ast.name.replace("@", "") ~ "[256] = \"" ~ ast.value ~ "\";\n";
        } else if (ast.type == "int"){
            if (!(ast.name.startsWith("@"))){
                _error("In Ever, Name of values must start with `@`. (In const<char>*)");
            }
            for (int i = 0; i < 9; i++){
                if (ast.name.startsWith(to!string(i))){
                    _error("In C-Backend mode, you can't starts a value name with a number.");
                }
            }
            foreach(keyword; ckeywords){
                if (ast.name.replace("@", "") == keyword){
                    _error("In C-Backend mode, you can't use a keyword name `" ~ keyword ~ "` as name of a value.");
                }
            }
            if (!strisDigit(ast.value)){
                _error("Value of `int` must be a number.");
            }
            global_int[ast.name.replace("@", "")] = to!int(ast.value);
            content ~= "int " ~ ast.name.replace("@", "") ~ " = " ~ ast.value ~ ";\n";
        }
    } else if (auto ast = cast(FuncCall)u){
        if (ast.name.startsWith("_")){
            foreach(a; stdfuncs){
                if (ast.name.replace("_", "") == a){
                    if (a == "write"){
                        {
                            //writeln(global_int, " ", global_char_max, " ", global_charp, " ", global_const_char_p);
                        }
                        string[] afg = ast.arguments.split("+");
                        if (!(afg.length == 1)){
                            foreach(gf; afg)
                            {
                                if (gf == "") continue;
                                //writeln(gf);
                                gf = gf.strip();
                                if (gf.startsWith("@"))
                                {
                                    gf = gf.replace("@", "");

                                    if (!(gf in global_charp) && !(gf in global_char_max) && !(gf in global_const_char_p) && !(gf in global_int) && !(gf in global_floatarray)){
                                    _error("No value with name `" ~ gf ~ "` not exists.");
                                    }
                                    if (gf in global_int){
                                        content ~= "evrlib_writeint(" ~ gf ~ ");\n";
                                    } else if (gf in global_floatarray){
                                        //writeln("lkl");
                                        content ~= "evrlib_floattype(" ~ gf ~ ", sizeof(" ~ gf ~ ") / sizeof(" ~ gf ~"[0]));\n";
                                    } else {
                                        content ~= "evrlib_write(" ~ gf ~ ");\n";
                                    }
                                    continue;
                                } else if (gf.startsWith("\"") && gf.endsWith("\""))
                                {
                                    if (strisDigit(gf)){
                                        content ~= "evrlib_writeint(" ~ gf ~ ");\n";
                                    } else if (gf.startsWith("\"") && gf.endsWith("\"")){
                                        content ~= "evrlib_write(" ~ escapeManagerC(gf) ~ ");\n";
                                    }
                                    continue;
                                }
                            }
                        } else if (ast.arguments.replace("\"", "").startsWith("@")){
                            string ag = ast.arguments.replace("\"", "").replace("@", "");
                            if (!(ag in global_charp) && !(ag in global_char_max) && !(ag in global_const_char_p) && !(ag in global_int) && !(ag in global_floatarray)){
                                _error("No value with name `" ~ ag ~ "` not exists.");
                            }
                            if (ag in global_int){
                                content ~= "evrlib_writeint(" ~ ag ~ ");\n";
                            } else if (ag in global_floatarray){
                                content ~= "evrlib_floattype(" ~ ag ~ ", sizeof(" ~ ag ~ ") / sizeof(" ~ ag ~"[0]));\n";
                            } else {
                                content ~= "evrlib_write(" ~ ag ~ ");\n";
                            }
                        } else {
                            if (strisDigit(ast.arguments)){
                                content ~= "evrlib_writeint(" ~ ast.arguments ~ ");\n";
                            } else if (ast.arguments.startsWith("\"") && ast.arguments.endsWith("\"")){
                                content ~= "evrlib_write(" ~ escapeManagerC(ast.arguments) ~ ");\n";
                            }
                        }
                    }
                } else {
                    _error("No such function with `" ~ ast.name ~ "` in standard library.");
                }
            }
        } 
    } else if (auto ast = cast(DefineArray)u)
    {
        if (ast.type.startsWith("array<") && ast.type.endsWith(">"))
        {
            string type = getArrayType(ast.type);
            //writeln(type);
            if (type == "f32")
            {
                float[] flt;
                foreach(al; ast.members)
                {
                    flt ~= to!float(al);
                }
                global_floatarray[ast.name.replace("@", "")] = flt;
                content ~= "float " ~ ast.name.replace("@", "") ~ "[] = " ~ to!string(global_floatarray[ast.name.replace("@", "")]).replace("[", "{").replace("]", "}") ~ ";\n";
            }
        }
    }
    }

    content ~= "return 0;\n}";
    //writeln(content);
    return Cfile(outputname, content);
}