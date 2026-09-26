using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class ErrorManager
    {
        public static void Error(string msg)
        {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.Write("Error: ");
            Console.ResetColor();
            Console.WriteLine(msg);
            Environment.Exit(1);
        }
    }
}
