module renim_main;

import std.stdio, ast, error, escapem, std.conv;

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
                asm_res ~= "\nsection .everdb\never db \"true\"\nsection .text";
                intxts = true;
            }
            else if (af.section_name == ".d") asm_res ~= "\nsection .data";
            else if (af.section_name == ".db") asm_res ~= "\nsection .bs";
            else {
                erda.unknown_section(af.section_name);
            }
        } else if (auto af = cast(EntryPointDefine)ast)
        {
            if (!intxts) erda.wrong_section();
            asm_res ~= "\nglobal _start";
            version(Windows) asm_res ~= "\nextern ExitProcess";
            asm_res ~= "\n_start:";
            
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
                }
            } else if (af.funcname == "VAR")
            {
                try {
                    global_var = to!int(eout(af.value));
                } catch (Exception e){
                    erda.notnumber(eout(af.value));
                }
            }
        }
    }
    
    return asm_res;
}