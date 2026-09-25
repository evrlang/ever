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
            return res;
        }
    }
}
