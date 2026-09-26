using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class InterTool
    {
        public static bool ArgsAreEmpty(string fn, string ag)
        {
            if (ag == "NULL")
            {
                return true;
            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.Write("\nError:");
                Console.ResetColor();
                Console.WriteLine(" `" + fn + "` Dosenot need to get any arguments. (Use NULL for it)");
                Environment.Exit(1);
                return false;
            }
        }

        public static string EscapeManager(string a)
        {
            return a.Replace("\"", "").Replace("\\b", "\"").Replace("\\n", "\n").Replace("\\p", "(").Replace("\\cp", ")");
        }
        public static bool MakeArgs(string args, ref List<string> save)
        {
            save = ever4win.Tokenizer.TokenizerMake(args);
            return true;
        }
    }
}
