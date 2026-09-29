module error;

import std.stdio, consolecolors;
import core.stdc.stdlib;
class StandardError {
    public static void file_read(string filename)
    {
        cwrite("Error: ".red);
        cwriteln(" Cannot find " ~ filename ~ " in this directory.".white);
        exit(1);
    }

    public static void unknown_section(string section_n)
    {
        cwrite("Error: ".red);
        cwriteln(" Undefined section type `" ~ section_n ~ "`, Use only (t-db-d).".white);
        exit(1);
    }

    public static void wrong_section()
    {
        cwrite("Error:".red);
        cwriteln(" You can't create Entry point in out of Text section.".white);
        exit(1);
    }

    public static void noenter(string name)
    {
        cwrite("Error:".red);
        cwriteln(" You can't use " ~ name ~" Outside of EntryPoint.".white);
        exit(1);
    }

    public static void unknown_calltype(string name)
    {
        cwrite("Error:".red);
        cwriteln(" unknown call method for `REMIN` " ~ name ~" Inside of EntryPoint.".white);
        exit(1);
    }

    public static void notnumber(string name)
    {
        cwrite("Error:".red);
        cwriteln(" A function want Number, but you pass " ~ name ~" to it, Inside of EntryPoint.".white);
        exit(1);
    }
}