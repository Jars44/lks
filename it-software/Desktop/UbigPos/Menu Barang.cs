using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace ubigpos
{
    public partial class Form5 : Form
    {
        public Form5()
        {
            InitializeComponent();
        }

        private void label3_Click(object sender, EventArgs e)
        {

        }

        private void Form5_Load(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            Form4 dashboardForm = new();
            dashboardForm.Show();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Form5 addItemForm = new();
            addItemForm.Show();
        }

        private void button6_Click(object sender, EventArgs e)
        {
            UbigPos loginForm = new();
            loginForm.Show();
        }
    }
}
