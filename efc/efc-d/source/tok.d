module tok;

import std.stdio;

enum Types {
    Func,
    Value,
    Section
}

struct tokens {
    string vale;
    Types type;
}