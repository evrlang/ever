module devrlib;

import std.stdio;
import std.math, core.sys.posix.unistd: getpid;
import core.stdc.stdlib;

extern(C) void evrlib_floattype(float* ft, size_t len)
{
	try {
		auto p = ft[0 .. len];
		write(p);
	} catch(Exception e)
	{
		writeln(getpid(), " runtime error: ", e.msg, " Ever Runtime Exception.");
		writeln(getpid(), " - [1]: from evrlib_floattype");
		writeln(getpid(), "[2]: libevrlib.so");
		exit(1);
	}
}