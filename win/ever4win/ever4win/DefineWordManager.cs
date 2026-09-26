using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace ever4win
{
    class DefineWordManager
    {
        public static void Run(DefineWord l)
        {
            if (l.type == "string")
            {
                ever4win.Program.mapstr[l.name.Replace("@", "")] = ever4win.InterTool.EscapeManager(l.value);
            }
        }
    }
}
