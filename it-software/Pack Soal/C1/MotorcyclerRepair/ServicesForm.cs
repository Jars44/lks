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
    public partial class ServicesForm : Form
    {
        public ServicesForm()
        {
            InitializeComponent();
        }

        private void motorcycleServicesBindingSource_CurrentChanged(object sender, EventArgs e)
        {
            if (motorcycleServicesBindingSource.Current is MotorcycleServices service)
            {
                formBindingSource.Clear();
                formBindingSource.DataSource = service;
            }
        }

        private void ServicesForm_Load(object sender, EventArgs e)
        {
            motorcycleServicesBindingSource.DataSource = Helper.Db.MotorcycleServices.ToList();

            var prefix = $"SR";
            var service = Helper.Db.MotorcycleServices.Where(f => f.ServiceCode.StartsWith(prefix)).OrderByDescending(f => f.ServiceCode).FirstOrDefault();

            if (service == default) prefix += "001";
            else
            {
                int number = int.Parse(service.ServiceCode.Replace(prefix, "")) + 1;
                prefix += number.ToString().PadLeft(3, '0');
            }

            formBindingSource.Clear();
            formBindingSource.DataSource = new MotorcycleServices
            {
                ServiceCode = prefix,
                ServiceName = "",
                Cost = 0
            };
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int cost;
            if (!int.TryParse(costTextBox.Text, out cost))
            {
                MessageBox.Show("Cost must be number");
                return;
            }

            if (string.IsNullOrEmpty(serviceNameTextBox.Text))
            {
                MessageBox.Show("Service name is required");
                return;
            }


            if (formBindingSource.Current is MotorcycleServices service)
            {
                Helper.Db.MotorcycleServices.AddOrUpdate(service);
                Helper.Db.SaveChanges();
                OnLoad(e);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (formBindingSource.Current is MotorcycleServices service)
            {
                var srv = Helper.Db.MotorcycleServices.FirstOrDefault(f => f.ServiceCode == service.ServiceCode);
                if (srv == default)
                {
                    MessageBox.Show("Please select a row");
                    return;
                }
                else
                {
                    int cost;
                    if (!int.TryParse(costTextBox.Text, out cost))
                    {
                        MessageBox.Show("Cost must be number");
                        return;
                    }

                    if (string.IsNullOrEmpty(serviceNameTextBox.Text))
                    {
                        MessageBox.Show("Product name is required");
                        return;
                    }


                    Helper.Db.MotorcycleServices.AddOrUpdate(service);
                    Helper.Db.SaveChanges();
                    OnLoad(e);
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var service = Helper.Db.MotorcycleServices.FirstOrDefault(f => f.ServiceCode == serviceCodeTextBox.Text);
            if (service != default)
            {
                if (MessageBox.Show("Are you sure?", "Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    Helper.Db.MotorcycleServices.Remove(service);
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
