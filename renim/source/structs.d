module structs;

enum Types {
    Func,
    Value,
    Section,
    Epoint,
    Doer
}

struct tokens {
    string value;
    Types type;
}
