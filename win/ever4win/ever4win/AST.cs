using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
   public abstract class Node {
   }
    public class FunctionDefine: Node {
        public string funcname;
        public string arguments;
        public FunctionDefine(string fu, string args)
        {
            funcname = fu;
            arguments = args;
        }
    }
    public class DefineWord : Node
    {
        public string name;
        public string type;
        public string value;
        public DefineWord(string n, string t, string v)
        {
            name = n;
            type = t;
            value = v;
        }
    }
}
