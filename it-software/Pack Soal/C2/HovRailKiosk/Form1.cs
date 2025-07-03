using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HovRailKiosk
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            label1.Text = DateTime.Now.ToString("dddd, dd-MMM-yyyy hh:mm:ss tt");
            timer1.Tick += (s, f) =>
            {
                label1.Text = DateTime.Now.ToString("dddd, dd-MMM-yyyy hh:mm:ss tt");
            };
            timer1.Start();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Helper.MainContext.MainForm = new RouteForm();
            Helper.MainContext.MainForm.Show();
            Close();
        }

        private void button2_Click(object sender, EventArgs e)
        {

            Helper.MainContext.MainForm = new BookForm();
            Helper.MainContext.MainForm.Show();
            Close();
        }
    }
}
