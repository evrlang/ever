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
                    Console.Write(ever4win.InterTool.EscapeManager(kl.arguments));
                }
                else if (ever4win.Program.mapstr.ContainsKey(kl.arguments))
                {
                    Console.Write(ever4win.Program.mapstr[kl.arguments]);
                }
                else ever4win.ErrorManager.Error("`_write`, The requested value was not found");
            }
            else if (kl.funcname == "_asRed") {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                }
            }
            else if (kl.funcname == "_asWhite")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.White;
                }
            }
            else if (kl.funcname == "_asDefault")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ResetColor();
                }
            }
            else if (kl.funcname == "_asGreen")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                }
            }
            else if (kl.funcname == "_asMagenta")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Magenta;
                }
            }
            else if (kl.funcname == "_asYellow")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Yellow;
                }
            }
            else if (kl.funcname == "_asBlue")
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                }
            }
            else if (kl.funcname == "_mainWindow")
            {
                List<string> a = new List<string>();
                if (ever4win.InterTool.MakeArgs(kl.arguments, ref a))
                {
                    //Console.WriteLine(a.Count);
                    if (a.Count == 2)
                    {
                        ever4win.Graphics.CreateWin(ever4win.InterTool.EscapeManager(a[0]), ever4win.InterTool.EscapeManager(a[1]));
                    }
                    else
                    {
                        
                        ever4win.ErrorManager.Error("`" + kl.funcname +"` has received arguments different from what was expected.");
                    }
                }
            }
            else if (kl.funcname == "_loopWindow")
            {
                ever4win.Graphics.ShowWin(ever4win.InterTool.EscapeManager(kl.arguments));
            }
            else if (kl.funcname == "_rmWindow")
            {
                ever4win.Graphics.removeWin(ever4win.InterTool.EscapeManager(kl.arguments));
            }
            else if (kl.funcname == "_label")
            {
                List<string> a = new List<string>();
                if (ever4win.InterTool.MakeArgs(kl.arguments, ref a))
                {
                    //Console.WriteLine(a.Count);
                    if (a.Count == 4)
                    {
                        int b;
                        int lka;
                        if (int.TryParse(a[2], out b) && int.TryParse(a[3], out lka))
                        {
                            ever4win.Graphics.addLabel(ever4win.InterTool.EscapeManager(a[0]), ever4win.InterTool.EscapeManager(a[1]), b, lka);
                        }
                        else
                        {
                            ever4win.ErrorManager.Error("Input must be number.");
                        }
                    }
                    else
                    {

                        ever4win.ErrorManager.Error("`" + kl.funcname + "` has received arguments different from what was expected.");
                    }
                }
            }
        }
    }
}
