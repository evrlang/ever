using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Collections;

public enum TokType
{
    Value,
    Func,
    Name,
    Keyword,
    Type
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
        public static Hashtable mapstr = new Hashtable();
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

                    if (txt.Trim() == "" || txt.Trim() == "//")
                    {
                        continue;
                    }
                    bool t1 = false;
                    bool t2 = false;
                    List<string> result = new List<string>();
                    string current = "";
                    foreach (char aa in txt)
                    {
                        if (aa == '\"' && t2 == false)
                        {
                            t1 = !t1;
                            if (t1 == true)
                            {
                                result.Add(current);
                                current = "";
                            }
                            current += aa;
                            

                            if (t1 == false)
                            {
                                result.Add(current);
                                current = "";

                            }
                        }
                        else if (t1 == true)
                        {
                            current += aa;
                        }
                        else if (t1 == false && aa == ' ' && t2 == false)
                        {
                            result.Add(current);
                            current = "";
                        }
                        else if (t1 == false && t2 == false && aa == '(' ){
                            result.Add(current);
                            current = "";
                            t2 = true;
                        }
                        else if (t2 == true && t1 == false && aa == ')')
                        {
                            result.Add(current);
                            current = "";
                        }
                        else if (t2 == true)
                        {
                            current += aa;
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
                    /*
                    foreach (string k in result)
                    {
                        Console.WriteLine(k);
                    }
                     */
                    List<Token> ntok = new List<Token>();
                    ntok = ever4win.Lexer.ReturnTokens(result);
                    
                    //Console.WriteLine("This must be here.");
                    
                    List<Node> nast = new List<Node>();
                    nast = ever4win.Parser.ReturnAST(ntok);
                    
                    foreach (Node lj in nast)
                    {
                        //Console.WriteLine(lj);
                        if (lj is FunctionDefine)
                        {
                            FunctionDefine ll = (FunctionDefine)lj;
                            
                            ever4win.FunctionDefineManagment.FuncManager(ll);
                        }
                        else if (lj is DefineWord)
                        {
                            DefineWord la = (DefineWord)lj;
                            ever4win.DefineWordManager.Run(la);
                        }
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
