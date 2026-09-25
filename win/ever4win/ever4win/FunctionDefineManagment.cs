using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class FunctionDefineManagment
    {
        public static void FuncManager(FunctionDefine kl)
        {
            if (kl.funcname == "_write")
            {
                if (kl.arguments.StartsWith("\"") && kl.arguments.EndsWith("\""))
                {
                    Console.Write(kl.arguments.Replace("\"", "").Replace("\\n", "\n"));
                }
            }
            else if (kl.funcname == "_asRed") {
                if (ever4win.InterTool.ArgsAreEmpty(kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                }
            }
            else if (kl.funcname == "_asWhite")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.White;
                }
            }
            else if (kl.funcname == "_asDefault")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.arguments))
                {
                    Console.ResetColor();
                }
            }

        }
    }
}
