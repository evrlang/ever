using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace ever4win
{
    class Lexer
    {
        public static List<Token> ReturnTokens(List<string> toks)
        {
            List<Token> resu = new List<Token>();
            foreach (string ftok in toks)
            {
                if (ftok.StartsWith("_"))
                {
                    resu.Add(new Token(ftok, TokType.Func));
                }
                else if (ftok.StartsWith("\""))
                {
                    resu.Add(new Token(ftok, TokType.Value));
                }
                else if (ftok == "NULL")
                {
                    resu.Add(new Token(ftok, TokType.Value));
                }
                else if (ftok.StartsWith("@"))
                {
                    resu.Add(new Token(ftok, TokType.Name));
                }
                else if (ftok == "gen" || ftok == "generate")
                {
                    resu.Add(new Token(ftok, TokType.Keyword));
                }
                else if (ftok == "string")
                {
                    resu.Add(new Token(ftok, TokType.Type));
                }
                else if (ftok == "") continue;
                else
                {
                    resu.Add(new Token(ftok, TokType.Value));
                }
            }
            return resu;
        }
    }
}
