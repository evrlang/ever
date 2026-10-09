module structs;

enum Types {
    Func,
    Value,
    Section,
    Epoint,
    Doer,
    End,
    BR
}

struct tokens {
    string value;
    Types type;
}
struct Brk {
    string[] bod;
}

public Brk[] gbrk;
public bool ends = false;