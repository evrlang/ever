using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Diagnostics;
namespace everstreamscript
{
    class Program
    {
        static void Main(string[] args)
        {
            if (!File.Exists("ess.vbs"))
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine("Error: ");
                Console.ForegroundColor = ConsoleColor.White;
                Console.Error.WriteLine("Engine files dosen't exists. Reinstall This Program or Download it again.");
                Console.ForegroundColor = ConsoleColor.White;
                Environment.Exit(1);
            }
            if (args.Length == 0)
            {
                Process ap = new Process();
                ap.StartInfo.FileName = "cscript.exe";
                ap.StartInfo.Arguments = "/nologo ess.vbs";
                ap.StartInfo.UseShellExecute = false;
                ap.StartInfo.RedirectStandardOutput = true;
                ap.Start();
                ap.WaitForExit();
                Console.WriteLine(ap.StandardOutput.ReadToEnd());

            }
            else if (File.Exists(args[0]))
            {
                Process ll = new Process();
                ll.StartInfo.FileName = "cscript.exe";
                ll.StartInfo.Arguments = "/nologo ess.vbs " + args[0];
                ll.StartInfo.RedirectStandardOutput = true;
                ll.StartInfo.UseShellExecute = false;
                ll.Start();
                ll.WaitForExit();

                Console.WriteLine(ll.StandardOutput.ReadToEnd());
            } 
            else
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.Write("Error: ");
                Console.ForegroundColor = ConsoleColor.White;
                Console.Error.WriteLine("`" + args[0] + "`" +" No such ever program with this name available on this system.");
                Console.ForegroundColor = ConsoleColor.White;
                Environment.Exit(1);
            }
        }
    }
}
