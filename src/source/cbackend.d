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
string[] ckeywords = ["char", "const", "int", "do", "auto", "continue", "default", "case", "break", "double", "while"];
string[] stdfuncs = ["write"];
Cfile cbackend_cc(string outputname, Node[] asts){
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
            global_const_char_p[ast.name.replace("@", "")] = ast.value;
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
            global_charp[ast.name.replace("@", "")] = ast.value;
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
            global_char_max[ast.name.replace("@", "")] = ast.value;
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
                        if (ast.arguments.replace("\"", "").startsWith("@")){
                            string ag = ast.arguments.replace("\"", "").replace("@", "");
                            if (!(ag in global_charp) && !(ag in global_char_max) && !(ag in global_const_char_p) && !(ag in global_int)){
                                _error("No value with name `" ~ ag ~ "` not exists.");
                            }
                            if (ag in global_int){
                                content ~= "evrlib_writeint(" ~ ag ~ ");\n";
                            } else content ~= "evrlib_write(" ~ ag ~ ");\n";
                        } else {
                            if (strisDigit(ast.arguments)){
                                content ~= "evrlib_writeint(" ~ ast.arguments ~ ");\n";
                            } else if (ast.arguments.startsWith("\"") && ast.arguments.endsWith("\"")){
                                content ~= "evrlib_write(" ~ ast.arguments ~ ");\n";
                            }
                        }
                    }
                } else {
                    _error("No such function with `" ~ ast.name ~ "` in standard library.");
                }
            }
        } 
    }
    }

    content ~= "return 0;\n}";
    return Cfile(outputname, content);
}