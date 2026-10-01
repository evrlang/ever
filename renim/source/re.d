module renim_main;

import std.stdio, ast, error, escapem, std.conv;
import std.algorithm;
string renim(Node[] asttree)
{
    auto erda = new StandardError();
    string asm_res;
    bool intxts = false;
    bool point = false;
    string lastloadupmode = "";
    string global_set= "";
    int global_var = 0;
    foreach(Node ast; asttree)
    {
        
        if (auto af = cast(SectionDefine)ast)
        {
            if (af.section_name == ".t") {
                asm_res ~= "\nsection .text";
                intxts = true;
            }
            else {
                erda.unknown_section(af.section_name);
            }
        } else if (auto af = cast(EntryPointDefine)ast)
        {
            if (!intxts) erda.wrong_section();
            asm_res ~= "\nglobal main";
            version(Windows) asm_res ~= "\n extern ExitProcess\n extern GetStdHandle\n extern WriteFile";
            asm_res ~= "\nmain:";
            
            point = true;
        } else if (auto af = cast(DefineFunction)ast)
        {
            if (!point){
                erda.noenter(af.funcname);
            } 
            if (af.funcname == "RENIM")
            {
                if (eout(af.value) == "w")
                {
                    lastloadupmode = "w";
                } else if (eout(af.value) == "e")
                {
                    lastloadupmode = "e";
                } else {
                    erda.unknown_calltype(eout(af.value));
                }
            } else if (af.funcname == "LOADUP")
            {
                if (!point) erda.noenter(af.funcname);

                if (lastloadupmode == "e"){
                    if (eout(af.value) == "%VAR")
                    {
                        version(Windows) asm_res ~= "\nsub rsp, 40\nmov rcx, " ~ to!string(global_var) ~ "\ncall ExitProcess";
                        else version(linux) asm_res ~= "\nmov rax, 60\nmov rdi, " ~ to!string(global_var) ~ "\nsyscall";
                    } else {
                        try {
                            auto ia = to!int(eout(af.value));
                            asm_res ~= "\nmov rax, 60\nmov rdi, " ~ eout(af.value) ~ "\nsyscall";
                        } catch (Exception e){
                            erda.notnumber(eout(af.value));
                        }
                    }
                } else if (lastloadupmode == "w")
                {
                    if (eout(af.value) == "%SET")
                    {
                        asm_res ~= "\nmov rax, 1\nmov rdi, 1\nmov rsi, gbl\nmov rdx, gbl_len\nsyscall";
                    }
                }
            } else if (af.funcname == "VAR")
            {
                try {
                    global_var = to!int(eout(af.value));
                } catch (Exception e){
                    erda.notnumber(eout(af.value));
                }
            } else if(af.funcname == "SET")
            {
                global_set = eout(af.value);
                if (!asm_res.startsWith("section .data"))
                {
                    asm_res = "section .data\ngbl db \"" ~ global_set ~ "\", 10\n gbl_len db $ - gbl\n" ~ asm_res;
                }
            }
        }
    }
    
    return asm_res;
}