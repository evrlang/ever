module ast;

import std.stdio;

interface Node {
    //noting.
}

class DefineFunction : Node {
    string funcname;
    string value;
    this(string funcname, string value)
    {
        this.funcname = funcname;
        this.value = value;
    }
}

class SectionDefine : Node {
    string section_name;
    this(string section_name)
    {
        this.section_name = section_name;
    }
}

class EntryPointDefine : Node {
    //noting.
}