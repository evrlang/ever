module res;

import std.stdio, ast, error, escapem, std.conv, structs;
import std.algorithm;
string simplerenim(Node[] asttree)
{
    auto erda = new StandardError();
    string asm_res;
    bool intxts = false;
    bool point = false;
    string lastloadupmode = "";
    string global_set= "";
    int global_var = 0;
    int setcount = 0;
    int funcname = 0;
    bool needblock = false;
    string setdata = "section .data\n\t";
    foreach(Node ast; asttree)
    {
        
        if (auto af = cast(DefineFunction)ast)
        {
            writeln(af.funcname, " ", af.value);
            if (af.funcname == "RENIM")
            {
                if (eout(af.value) == "w")
                {
                    lastloadupmode = "w";
                } else if (eout(af.value) == "e")
                {
                    lastloadupmode = "e";
                } else if (eout(af.value) == "g"){
                    lastloadupmode = "g";
                } else {
                    erda.unknown_calltype(eout(af.value));
                }
            } else if (af.funcname == "LOADUP")
            {
                //if (!point) erda.noenter(af.funcname);

                if (lastloadupmode == "e"){
                    if (eout(af.value) == "%VAR")
                    {
                        version(Windows) asm_res ~= "\nsub rsp, 40\nmov rcx, " ~ to!string(global_var) ~ "\ncall ExitProcess";
                        else version(linux) asm_res ~= "\n add rsp, 8\nmov rax, " ~ to!string(global_var) ~ "\nret";
                    } else {
                        try {
                            auto ia = to!int(eout(af.value));
                            asm_res ~= "\nadd rsp, 8\nmov rax, 0\nret";
                        } catch (Exception e){
                            erda.notnumber(eout(af.value));
                        }
                    }
                } else if (lastloadupmode == "w")
                {
                    if (eout(af.value) == "%SET")
                    {
                        asm_res ~= "\nlea rdi, [rel gbl" ~ to!string(setcount) ~"]\ncall evrlib_write";
                    }
                } else if (lastloadupmode == "g"){
                    if (funcname == 1 && eout(af.value) == "%SET"){
                        asm_res ~= "\nlea rdi, [rel gbl" ~ to!string(setcount) ~ "]\ncall evrlib_initgraphic";
                    } else if (funcname == 2 && eout(af.value) == "%NULL"){

                    }
                }
            } else if (af.funcname == "VAR")
            {
                try {
                    global_var = to!int(eout(af.value));
                } catch (Exception e){
                    erda.notnumber(eout(af.value));
                }
            } else if (af.funcname == "FUNCNUM"){
                funcname = to!int(eout(af.value));
            } 
        }
    }
    writeln(asm_res);
    return asm_res;
}