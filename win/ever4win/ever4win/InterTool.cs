using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class InterTool
    {
        public static bool ArgsAreEmpty(string ag)
        {
            if (ag == "NULL")
            {
                return true;
            }
            else
            {
                Console.BackgroundColor = ConsoleColor.Red;
                Console.Write("Error:");
                Console.BackgroundColor = ConsoleColor.White;
                Console.WriteLine("A Function Dosenot need to get any arguments. (Use NULL for it)");
                Environment.Exit(1);
                return false;
            }
        }
    }
}
