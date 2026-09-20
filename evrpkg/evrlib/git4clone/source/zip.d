module zip;

import std.stdio, std.zip, std.file, std.path, std.string, std.algorithm;

class Zip {
    static void zipExtractor(string zip_path, string output, string zipname)
    {
        bool firstFolder = true;
        string firstFolderName;
        //writeln(zip_path, " ", output);
        if (exists(zip_path)) {
            if (!exists(expandTilde(output))) mkdirRecurse(expandTilde(output));
            auto zip = new ZipArchive(read(zip_path));
            foreach(nhame, mem; zip.directory)
            {
                if (firstFolder && nhame.indexOf("/") != -1) 
                {
                    string[] jk = nhame.split("/");
                    firstFolder = false;
                    firstFolderName = jk[0] ~ "/";
                }
                string name;
                if (firstFolderName.length > 0 && nhame.startsWith(firstFolderName))
                {
                    name = nhame[firstFolderName.length .. $];
                    name = zipname ~ "/" ~ name; 
                } else name = nhame;
                auto pathn = buildPath(expandTilde(output), name);
                
                if (name.endsWith("/"))
                {
                    mkdirRecurse(pathn);
                    continue;
                }
                mkdirRecurse(dirName(pathn));
                zip.expand(mem);
                //writeln(pathn);
                std.file.write(expandTilde(pathn), mem.expandedData);
                continue;
            }
        }
    }
}