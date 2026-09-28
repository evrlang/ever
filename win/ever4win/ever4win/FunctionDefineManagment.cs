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
            //Console.WriteLine(ever4win.InterTool.checkFuncName("write", kl.arguments));
            if (ever4win.InterTool.checkFuncName("write", kl.funcname))
            {
                if (kl.arguments.StartsWith("\"") && kl.arguments.EndsWith("\""))
                {
                    Console.Write(ever4win.InterTool.EscapeManager(kl.arguments));
                }
                else if (ever4win.Program.mapstr.ContainsKey(kl.arguments))
                {
                    Console.Write(ever4win.Program.mapstr[kl.arguments]);
                }
                else ever4win.ErrorManager.Error("`write`, The requested value was not found");
            }
            else if (ever4win.InterTool.checkFuncName("asRed", kl.funcname)) {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Red;
                }
            }
            else if (ever4win.InterTool.checkFuncName("asWhite", kl.funcname))
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.White;
                }
            }
            else if (ever4win.InterTool.checkFuncName("asDefault", kl.funcname))
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ResetColor();
                }
            }
            else if (ever4win.InterTool.checkFuncName("asGreen", kl.funcname))
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Green;
                }
            }
            else if (ever4win.InterTool.checkFuncName("asMagenta", kl.funcname))
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Magenta;
                }
            }
            else if (ever4win.InterTool.checkFuncName("asYellow", kl.funcname))
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Yellow;
                }
            }
            else if (ever4win.InterTool.checkFuncName("asBlue", kl.funcname))
            {
                if (ever4win.InterTool.ArgsAreEmpty(kl.funcname, kl.arguments))
                {
                    Console.ForegroundColor = ConsoleColor.Blue;
                }
            }
            else if (ever4win.InterTool.checkFuncName("mainWindow", kl.funcname))
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
            else if (ever4win.InterTool.checkFuncName("loopWindow", kl.funcname))
            {
                ever4win.Graphics.ShowWin(ever4win.InterTool.EscapeManager(kl.arguments));
            }
            else if (ever4win.InterTool.checkFuncName("rmWindow", kl.funcname))
            {
                ever4win.Graphics.removeWin(ever4win.InterTool.EscapeManager(kl.arguments));
            }
            else if (ever4win.InterTool.checkFuncName("label", kl.funcname))
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
            else if (ever4win.InterTool.checkFuncName("noBorder", kl.funcname))
            {
                ever4win.Graphics.rmControl(ever4win.InterTool.EscapeManager(kl.arguments));
            }
            else if (ever4win.InterTool.checkFuncName("msgBox", kl.funcname))
            {
                ever4win.Graphics.msgbox(ever4win.InterTool.EscapeManager(kl.arguments));
            }
        }
    }
}
