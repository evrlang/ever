module arg;

import std.stdio;
import std.string;
import astsupport, ver, std.json, std.typecons, std.conv;
import astsupport, std.file, axiom;

struct ConfigStatus {
    Nullable!bool enter;
    Nullable!bool compile;
    Nullable!string compile_backend;
    Nullable!string compile_linker;
    Nullable!bool _version;
    Nullable!bool help;
    Nullable!bool _debug;
    Nullable!string value;
    Nullable!bool dp;
}

void add_JSON_entry(string name, string value){
    config_json = config_json ~ ",\n\t\"" ~ name ~ "\":\"" ~ value ~ "\"";
}

void args_manager(string[] args){
    foreach(option; args){
        if (option == "--compile" || option == "-c"){
            add_JSON_entry("compile", "true");
        } else if (option == "--enter" || option == "-e"){
            add_JSON_entry("enter", "true");
        } else if (option.startsWith("--compile-backend:") || option.startsWith("-cb:"))
        {
            if (option == "--compile-backend:C" || option == "-cb:C" || option == "--compile-backend:c" || option == "-cb:c")
            {
                add_JSON_entry("compile-backend", "c");
            }
        } else if (option.startsWith("--compile-linker:") || option.startsWith("-cl:"))
        {
            if (option == "--compile-linker:gold" || option == "-cl:gold")
            {
                add_JSON_entry("compile-linker", "gold");
            } else if (option == "--compile-linker:ld" || option == "-cl:ld")
            {
                add_JSON_entry("compile-linker", "ld");
            } else if (option == "--compile-linker:lld" || option == "-cl:lld")
            {
                add_JSON_entry("compile-linker", "lld");
            }
        } else if (option == "--version" || option == "-v")
        {
            add_JSON_entry("version", "true");
        } else if (option == "--help" || option == "-h")
        {
            add_JSON_entry("help", "true");
        } else if (option == "--debug" || option == "-d")
        {
            add_JSON_entry("debug", "true");
        } else if (option == "./evr" || option == "evr"){
            continue;
        } else if (option == "--debug-printall" || option == "-dp"){
            add_JSON_entry("debug_printall", "true");
        } else {
            add_JSON_entry("value", option);
        }
    }

    config_json = config_json ~ "\n}";
    args_main();
}


void args_main()
{
    JSONValue cfg = parseJSON(config_json);
    ConfigStatus cfgst;
    foreach(key, value; cfg.object)
    {
        if (key == "enter")
        {
            cfgst.enter = to!bool(value.str);
        } else if (key == "compile")
        {
            cfgst.compile = to!bool(value.str);
        } else if (key == "compile-backend")
        {
            cfgst.compile_backend = value.str;
        } else if (key == "compile-linker")
        {
            cfgst.compile_linker = to!string(value.str);
        } else if (key == "version")
        {
            cfgst._version = to!bool(value.str);
        } else if (key == "debug")
        {
            cfgst._debug = to!bool(value.str);
        } else if (key == "help")
        {
            cfgst.help = to!bool(value.str);
        } else if (key == "value")
        {
            cfgst.value = value.str;
        } else if (key == "debug_printall")
        {
            cfgst.dp = to!bool(value.str);
        }
    }

    if (!cfgst.enter.isNull && cfgst.enter)
    {
        if (cfgst.value.isNull || !exists(cfgst.value.get)) _error("The imported file does not exists.");
        if (!cfgst.dp.isNull && cfgst.dp) dp_all = true;
        astSupportRun(cfgst.value, 0);
    } else if (cfgst.compile)
    {
        if (cfgst.value.isNull || !exists(cfgst.value.get)) _error("The imported file does not exists.");
        if (cfgst.compile_backend == "c")
        {
            if (cfgst.compile_linker.isNull) {
                if (!cfgst.value.isNull && !exists(cfgst.value.get)) _error("The imported file does not exist.");
                compileuseC(cfgst.value, readText(cfgst.value.get), 0);
            } else {
                if (cfgst.compile_linker == "ld")
                {
                    compileuseC(cfgst.value, readText(cfgst.value.get), 0);
                } else if (cfgst.compile_linker == "gold")
                {
                    compileuseC(cfgst.value, readText(cfgst.value.get), 1);
                } else if (cfgst.compile_linker == "lld")
                {
                    compileuseC(cfgst.value, readText(cfgst.value.get), 2);
                }
            }
        } else if(cfgst.compile_backend.isNull) astSupportCompile(cfgst.value);
    } else if (cfgst.help)
    {
        prHelpMenu();
    } else if (cfgst._version)
    {
		writeln("\033[1mever (V" ~ ever_ver ~ ") " ~ __DATE__ ~ " " ~ __TIME__);
    } else if (cfgst._debug){
        if (cfgst.value.isNull || !exists(cfgst.value.get)) _error("File Not exists.");
        //writeln(cfgst.value.get);
        debg(readText(cfgst.value.get), 1);
    } else {
        prHelpMenu();
        _error("No option exists like whats you entered.");
    }
}