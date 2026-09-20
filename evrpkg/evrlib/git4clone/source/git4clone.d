module git4clone;

import std.stdio, std.string, core.stdc.stdlib, std.net.curl, std.regex, std.json, std.path, std.file;
import zip;
string red = "\033[31m";
string bold = "\033[1m";
string reset = "\033[0m";

class Git4clone {
	static void download(string url, string zipname)
	{
		if (checkWebAddress(url))
		{
			auto getrepoinfo = get("https://api.github.com/repos/" ~ url.replace("https://github.com/", ""));
			//std.file.write("repoinfo.json", getrepoinfo);
			JSONValue root = parseJSON(getrepoinfo);
			string io;
			if (url.endsWith("/")) io = url ~ "archive/refs/heads/" ~ root["default_branch"].str ~ ".zip";
			else io = url ~ "/archive/refs/heads/" ~ root["default_branch"].str ~ ".zip";
			auto hget = get(io);
			std.file.write(zipname ~ ".zip", hget);
			auto ll = regex(`(\S+)\/(\S+)`);
			auto vc = match(url.replace("https://github.com/", "").replace("http://github.com/", ""), ll);
			if(!vc.empty) Zip.zipExtractor(zipname ~ ".zip", "~/.evrpkg/pkgs/", zipname);
			else error("The provided source URL is invalid or inaccessible. Please contact the package maintainer if necessary.");
		} else {
			error("The provided source URL is invalid or inaccessible. Please contact the package maintainer if necessary.\n The error has been reported to the package registry.");
		}
	}
}
private bool checkWebAddress(string url)
{
	if (url.startsWith("https://github.com/") || url.startsWith("http://github.com/"))
	{
		return true;
	} else return false;
}
private void error(string msg)
{
	writeln(red ~ bold ~ "Error: " ~ reset ~ bold ~ msg ~ reset);
	exit(1);
}