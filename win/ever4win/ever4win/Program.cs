using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;


public enum TokType
{
    String,
    Func
}

public struct Token
{
    public string value;
    public TokType type;

    public Token(string a, TokType b)
    {
        value = a;
        type = b;
    }
}

namespace ever4win
{
    class Program
    {
        static void Main(string[] args)
        {
            if (args.Length == 0){
                Console.WriteLine("ever4win C#-written version, (C)-2026 Pouya Mohammadi");
                Console.WriteLine("An Interperter for Ever to work with Windows.");
                Console.WriteLine("Usage:");
                Console.WriteLine("\t./ever4win [filename.ever]");
            }
            else if (File.Exists(args[0]))
            {
                StreamReader fk = new StreamReader(args[0]);
                while (!fk.EndOfStream)
                {
                    string txt = fk.ReadLine();
                    bool t1 = false;
                    List<string> result = new List<string>();
                    string current = "";
                    foreach (char aa in txt)
                    {
                        if (aa == '\"')
                        {
                            t1 = !t1;
                            result.Add(current);
                            current = "";
                        }
                        else if (t1 == true)
                        {
                            current += aa;
                        }
                        else if (t1 == false && aa == ' ')
                        {
                            result.Add(current);
                            current = "";
                        }
                        else
                        {
                            current += aa;
                        }
                    }
                    if (current != "")
                    {
                        result.Add(current);
                    }

                    foreach (string toh in result)
                    {
                        Console.WriteLine(toh);
                    }
                }
                fk.Close();
            }
            else {
                Console.WriteLine("File error.");
            }
        }
    }
}
