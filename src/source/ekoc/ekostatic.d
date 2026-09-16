module everc.everstatic;

enum everctype {
    keyword,
    name,
    op,
    valaue
}
struct evercToken {
    string value;
    everctype type;
}