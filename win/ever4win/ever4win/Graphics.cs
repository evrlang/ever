using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Drawing;

namespace ever4win
{
    class Graphics
    {
        public static Dictionary<string, Form> GlobalForm = new Dictionary<string, Form>();
        private static bool _isapprun = false;
        static public void CreateWin(string name, string title)
        {
            if (!GlobalForm.ContainsKey(name))
            {
                GlobalForm[name] = new Form();
                GlobalForm[name].Text = title;
                GlobalForm[name].Height = 400;
                GlobalForm[name].Width = 400;
            }
        }
        public static void ShowWin(string name)
        {
            if (GlobalForm.ContainsKey(name))
            {
                if (GlobalForm[name] == null || GlobalForm[name].IsDisposed)
                {
                    ever4win.ErrorManager.Error("The created window has been closed.");
                }
                
                    _isapprun = true;
                    Application.Run(GlobalForm[name]);
                    _isapprun = false;
                
            }
            else
            {
                ever4win.ErrorManager.Error("The created window value does not exist.");
            }
        }
        public static void removeWin(string name)
        {
            if (GlobalForm.ContainsKey(name))
            {
                GlobalForm.Remove(name);
            }
            else
            {
                ever4win.ErrorManager.Error("The created window value does not exist.");
            }
        }
        public static void addLabel(string name, string text, int x, int y)
        {
            if (!GlobalForm.ContainsKey(name))
            {
                ever4win.ErrorManager.Error("The created window value does not exist.");
            }
            else
            {
                Label temp_label = new Label();
                temp_label.Text = text;
                temp_label.Location = new Point(x, y);
                temp_label.AutoSize = true;
                GlobalForm[name].Controls.Add(temp_label);
            }
        }
    }
}
