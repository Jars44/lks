using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MotorcyclerRepair
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button1_Click(object sender, EventArgs e)
        {
            var user = Helper.Db.Users.FirstOrDefault(f => f.UserCode == textBox1.Text && f.UserPassword == textBox2.Text);

            if (user == default)
            {
                MessageBox.Show("Username or Password is not correct");
                return;
            }

            Helper.UserCode = user.UserCode;
            Helper.MainContext.MainForm = new Form2();
            Helper.MainContext.MainForm.Show();
            Close();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
        }
    }
}
