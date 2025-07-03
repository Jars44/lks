using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Migrations;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MotorcyclerRepair
{
    public partial class MechanicForm : Form
    {
        public MechanicForm()
        {
            InitializeComponent();
        }

        private void MechanicForm_Load(object sender, EventArgs e)
        {
            mechanicsBindingSource.DataSource = Helper.Db.Mechanics.ToList();

            var prefix = $"MC";
            var mechanic = Helper.Db.Mechanics.Where(f => f.MechanicCode.StartsWith(prefix)).OrderByDescending(f => f.MechanicCode).FirstOrDefault();

            if (mechanic == default) prefix += "001";
            else
            {
                int number = int.Parse(mechanic.MechanicCode.Replace(prefix, "")) + 1;
                prefix += number.ToString().PadLeft(3, '0');
            }

            formBindingSource.Clear();
            formBindingSource.DataSource = new Mechanics
            {
                MechanicCode = prefix,
                MechanicName = "",
            };
        }

        private void mechanicsBindingSource_CurrentChanged(object sender, EventArgs e)
        {
            if (mechanicsBindingSource.Current is Mechanics mch)
            {
                formBindingSource.Clear();
                formBindingSource.DataSource = mch;
            }
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(mechanicNameTextBox.Text))
            {
                MessageBox.Show("Mechanic name is required");
                return;
            }


            if (formBindingSource.Current is Mechanics mch)
            {
                Helper.Db.Mechanics.AddOrUpdate(mch);
                Helper.Db.SaveChanges();
                OnLoad(e);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (formBindingSource.Current is Mechanics mch)
            {
                var mechanic = Helper.Db.Mechanics.FirstOrDefault(f => f.MechanicCode == mch.MechanicCode);
                if (mechanic == default)
                {
                    MessageBox.Show("Please select a row");
                    return;
                }
                else
                {
                    if (string.IsNullOrEmpty(mechanicNameTextBox.Text))
                    {
                        MessageBox.Show("Mechanic name is required");
                        return;
                    }


                    Helper.Db.Mechanics.AddOrUpdate(mch);
                    Helper.Db.SaveChanges();
                    OnLoad(e);
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var mechanic = Helper.Db.Mechanics.FirstOrDefault(f => f.MechanicCode == mechanicCodeTextBox.Text);
            if (mechanic != default)
            {
                if (MessageBox.Show("Are you sure?", "Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    Helper.Db.Mechanics.Remove(mechanic);
                    Helper.Db.SaveChanges();
                    OnLoad(e);
                }
            }
            else
            {
                MessageBox.Show("Please select a row");
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            OnLoad(e);
        }
    }
}
