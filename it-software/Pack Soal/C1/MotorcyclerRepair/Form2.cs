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
    public partial class Form2 : Form
    {
        public Form2()
        {
            InitializeComponent();
        }

        private void usersToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var form = new UserForm();
            form.MdiParent = this;
            form.Show();
        }

        private void productsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var form = new ProductForm();
            form.MdiParent = this;
            form.Show();
        }

        private void servicesToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var form = new ServicesForm();
            form.MdiParent = this;
            form.Show();
        }

        private void mechanicsToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var form = new MechanicForm();
            form.MdiParent = this;
            form.Show();
        }

        private void transactionToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var form = new TransactionForm();
            form.MdiParent = this;
            form.Show();
        }

        private void logoutToolStripMenuItem_Click(object sender, EventArgs e)
        {
            var form = new Form1();
            form.MdiParent = this;
            form.Show();
            Close();
        }
    }
}
