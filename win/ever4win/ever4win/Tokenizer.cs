using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class Tokenizer
    {
        public static List<string> TokenizerMake(string line)
        {
            bool t1 = false;
            bool t2 = false;
            List<string> result = new List<string>();
            string current = "";
            foreach (char aa in line)
            {
                if (aa == '\"' && t2 == false)
                {
                    t1 = !t1;
                    if (t1 == true && t2 == false && current != "" && current != " ")
                    {
                        result.Add(current);
                        current = "";
                    }
                    current += aa;

                    if (t1 == false && current != "" && current != " ")
                    {
                        result.Add(current);
                        current = "";
                    }
                }
                else if (t1 == true && current != "" && current != " ")
                {
                    current += aa;
                }
                else if (t1 == false && aa == ' ' && current != " " && current != "")
                {
                    result.Add(current);
                    current = "";
                }
                else
                {
                    current += aa;
                }
            }
            if (current != "" && current != " ")
            {
                result.Add(current);
            }
            
            return result;
        }
    }
}
