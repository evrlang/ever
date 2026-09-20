import std.stdio;
extern(C):
export const(char)* ever_init()
{
	return "{\n\"func\": \"add\",\"args\": \"int a, int b\", \"return\": \"int\"\n}";
}
export int add(int a, int b)
{
	return a + b;
}