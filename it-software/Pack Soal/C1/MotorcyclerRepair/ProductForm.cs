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
    public partial class ProductForm : Form
    {
        public ProductForm()
        {
            InitializeComponent();
        }

        private void productsBindingSource_CurrentChanged(object sender, EventArgs e)
        {
            if (productsBindingSource.Current is Products prd)
            {
                formBindingSource.Clear();
                formBindingSource.DataSource = prd;
            }
        }

        private void ProductForm_Load(object sender, EventArgs e)
        {
            productsBindingSource.DataSource = Helper.Db.Products.ToList();
            
            var prefix = $"PR";
            var product = Helper.Db.Products.Where(f => f.ProductCode.StartsWith(prefix)).OrderByDescending(f => f.ProductCode).FirstOrDefault();

            if (product == default) prefix += "001";
            else
            {
                int number = int.Parse(product.ProductCode.Replace(prefix, "")) + 1;
                prefix += number.ToString().PadLeft(3, '0');
            }

            formBindingSource.Clear();
            formBindingSource.DataSource = new Products
            {
                ProductCode = prefix,
                ProductName = "",
                Price = 0
            };
        }

        private void button1_Click(object sender, EventArgs e)
        {
            int price;
            if (!int.TryParse(priceTextBox.Text, out price))
            {
                MessageBox.Show("Price must be number");
                return;
            }

            if (string.IsNullOrEmpty(productNameTextBox.Text))
            {
                MessageBox.Show("Product name is required");
                return;
            }


            if (formBindingSource.Current is Products prd)
            {
                Helper.Db.Products.AddOrUpdate(prd);
                Helper.Db.SaveChanges();
                OnLoad(e);
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (formBindingSource.Current is Products prd)
            {
                var product = Helper.Db.Products.FirstOrDefault(f => f.ProductCode == prd.ProductCode);
                if (product == default)
                {
                    MessageBox.Show("Please select a row");
                    return;
                } else
                {
                    int price;
                    if (!int.TryParse(priceTextBox.Text, out price))
                    {
                        MessageBox.Show("Price must be number");
                        return;
                    }

                    if (string.IsNullOrEmpty(productNameTextBox.Text))
                    {
                        MessageBox.Show("Product name is required");
                        return;
                    }


                    Helper.Db.Products.AddOrUpdate(prd);
                    Helper.Db.SaveChanges();
                    OnLoad(e);
                }
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var product = Helper.Db.Products.FirstOrDefault(f => f.ProductCode == productCodeTextBox.Text);
            if (product != default)
            {
                if (MessageBox.Show("Are you sure?", "Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    Helper.Db.Products.Remove(product);
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
