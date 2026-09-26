using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class Parser
    {
        public static List<Node> ReturnAST(List<Token> toks)
        {
            List<ever4win.Node> res = new List<Node>();
            if (toks[0].type == TokType.Func && toks[1].type == TokType.Value)
            {
                res.Add(new FunctionDefine(toks[0].value, toks[1].value));
            }
            else if (toks[0].type == TokType.Keyword && toks[1].type == TokType.Type && toks[2].type == TokType.Name && toks[3].type == TokType.Value)
            {
                res.Add(new DefineWord(toks[2].value, toks[1].value, toks[3].value));
            }
            else if (toks[0].type == TokType.Name && toks[1].type == TokType.Value)
            {
                string ab = toks[0].value;
                ab = ab.Replace("@", "");
                if (ever4win.Program.mapstr.ContainsKey(ab))
                {
                    res.Add(new DefineWord(toks[0].value, "string", toks[1].value));
                }
            }
            return res;
        }
    }
}
