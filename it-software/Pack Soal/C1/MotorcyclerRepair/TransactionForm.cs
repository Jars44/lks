using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Data;
using System.Data.Entity.Core.Common.CommandTrees.ExpressionBuilder;
using System.Data.Entity.Migrations;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MotorcyclerRepair
{
    public partial class TransactionForm : Form
    {
        public TransactionForm()
        {
            InitializeComponent();
        }

        private void paidLabel_Click(object sender, EventArgs e)
        {

        }

        private void paidTextBox_TextChanged(object sender, EventArgs e)
        {
            if (transactionServiceBindingSource.Current is TransactionService tx)
            {
                if (int.TryParse(paidTextBox.Text, out int paid))
                {
                    tx.Paid = paid;
                }
                else
                {
                    tx.Paid = 0;
                }
                tx.ChangeMoney = tx.Paid - tx.TotalCharge;
                changeMoneyTextBox.Text = tx.ChangeMoney.ToString();
            } 

        }

        private void dataGridView1_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            if (transactionServiceBindingSource.Current is TransactionService tx)
            {
                tx.DetailService = new List<DetailService>();
                var invalidRows = new List<int>();
                foreach (DataGridViewRow row in dataGridView1.Rows)
                {
                    if (row.Index == dataGridView1.Rows.Count - 1) continue;
                    var code = row.Cells[0].Value.ToString();
                    var service = Helper.Db.MotorcycleServices.FirstOrDefault(f => f.ServiceCode == code);
                    if (service == default) invalidRows.Add(row.Index);
                    else
                    {
                        row.Cells[1].Value = service.ServiceName;
                        row.Cells[2].Value = service.Cost;
                        tx.DetailService.Add(new DetailService
                        {
                            Cost = service.Cost,
                            ServiceCode = service.ServiceCode,
                        });
                    }
                }
                foreach (var index in invalidRows) dataGridView1.Rows.RemoveAt(index);

                textBox1.Text = tx.DetailService.Count.ToString();
                tx.TotalServiceCost = tx.DetailService.Sum(f => f.Cost);
                tx.TotalCharge = tx.TotalServiceCost + tx.TotalProductPrice;
                tx.ChangeMoney = tx.Paid - tx.TotalCharge;
                textBox2.Text = tx.TotalServiceCost.ToString();
                totalChargeTextBox.Text = tx.TotalCharge.ToString();
                changeMoneyTextBox.Text = tx.ChangeMoney.ToString();
            }
            
        }

        private void groupBox2_Enter(object sender, EventArgs e)
        {

        }

        private void TransactionForm_Load(object sender, EventArgs e)
        {
            comboBox1.DataSource = Helper.Db.Mechanics.ToList();
            comboBox1.DisplayMember = "MechanicName";
            comboBox1.ValueMember = "MechanicCode";

            transactionServiceBindingSource.Clear();

            var suffix = DateTime.Now.ToString("MMyyyy");
            var tx = Helper.Db.TransactionService.Where(f => f.TransactionNumber.EndsWith(suffix)).OrderByDescending(f => f.TransactionNumber).FirstOrDefault();
            if (tx == default) suffix = "T001" + suffix;
            else
            {
                int seq = int.Parse(tx.TransactionNumber.Replace("T", "").Replace(suffix, "")) + 1;
                suffix = "T" + seq.ToString().PadLeft(3, '0') + suffix;
            }

            transactionServiceBindingSource.DataSource = new TransactionService
            {
                TransactionNumber = suffix,
                PoliceRegistrationNumber = "",
                Damage = "",
                Paid = 0,
                ChangeMoney = 0,
                TotalCharge = 0,
                TotalProductPrice = 0,
                TotalServiceCost = 0
            };
            textBox1.Text = "0";
            textBox4.Text = "0";
            comboBox1.SelectedIndex = -1;
        }

        private void dataGridView1_CellContentDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            
        }

        private void dataGridView1_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (transactionServiceBindingSource.Current is TransactionService tx)
            {
                if (e.RowIndex == dataGridView1.Rows.Count - 1) return;

                var code = dataGridView1.Rows[e.RowIndex].Cells[0].Value.ToString();
                dataGridView1.Rows.RemoveAt(e.RowIndex);

                tx.DetailService.Remove(tx.DetailService.First(f => f.ServiceCode == code));
                textBox1.Text = tx.DetailService.Count.ToString();
                tx.TotalServiceCost = tx.DetailService.Sum(f => f.Cost);
                tx.TotalCharge = tx.TotalServiceCost + tx.TotalProductPrice;
                tx.ChangeMoney = tx.Paid - tx.TotalCharge;
                textBox2.Text = tx.TotalServiceCost.ToString();
                totalChargeTextBox.Text = tx.TotalCharge.ToString();
                changeMoneyTextBox.Text = tx.ChangeMoney.ToString();
            }
        }

        private void dataGridView2_CellEndEdit(object sender, DataGridViewCellEventArgs e)
        {
            if (transactionServiceBindingSource.Current is TransactionService tx)
            {
                tx.DetailProduct = new List<DetailProduct>();
                var invalidRows = new List<int>();
                foreach (DataGridViewRow row in dataGridView2.Rows)
                {
                    if (row.Index == dataGridView2.Rows.Count - 1) continue;
                    var code = row.Cells[0].Value.ToString();
                    var product = Helper.Db.Products.FirstOrDefault(f => f.ProductCode == code);
                    if (product == default) invalidRows.Add(row.Index);
                    else
                    {
                        row.Cells[1].Value = product.ProductName;
                        row.Cells[2].Value = product.Price;
                        row.Cells[3].Value = row.Cells[3].Value ?? 1;
                        row.Cells[4].Value = int.Parse(row.Cells[3].Value.ToString()) * product.Price;
                        tx.DetailProduct.Add(new DetailProduct
                        {
                            Amount = int.Parse(row.Cells[3].Value.ToString()),
                            Price = product.Price,
                            Total = int.Parse(row.Cells[4].Value.ToString()),
                            ProductCode = product.ProductCode,
                        });
                    }
                }

                foreach (var index in invalidRows) dataGridView2.Rows.RemoveAt(index);

                textBox4.Text = tx.DetailProduct.Count.ToString();
                tx.TotalProductPrice = tx.DetailProduct.Sum(f => f.Total);
                textBox3.Text = tx.TotalProductPrice.ToString();
                tx.TotalCharge = tx.TotalServiceCost + tx.TotalProductPrice;
                tx.ChangeMoney = tx.Paid - tx.TotalCharge;
                totalChargeTextBox.Text = tx.TotalCharge.ToString();
                changeMoneyTextBox.Text = tx.ChangeMoney.ToString();
            }
            
        }

        private void dataGridView2_CellDoubleClick(object sender, DataGridViewCellEventArgs e)
        {
            if (transactionServiceBindingSource.Current is TransactionService tx)
            {
                if (e.RowIndex == dataGridView2.Rows.Count - 1) return;
                if (e.ColumnIndex == AmountColumn.Index) return;
                var code = dataGridView2.Rows[e.RowIndex].Cells[0].Value.ToString();
                tx.DetailProduct.Remove(tx.DetailProduct.First(f => f.ProductCode == code));
                dataGridView2.Rows.RemoveAt(e.RowIndex);

                textBox4.Text = tx.DetailProduct.Count.ToString();
                tx.TotalProductPrice = tx.DetailProduct.Sum(f => f.Total);
                textBox3.Text = tx.TotalProductPrice.ToString();
                tx.TotalCharge = tx.TotalServiceCost + tx.TotalProductPrice;
                tx.ChangeMoney = tx.Paid - tx.TotalCharge;
                totalChargeTextBox.Text = tx.TotalCharge.ToString();
                changeMoneyTextBox.Text = tx.ChangeMoney.ToString();
            }
        }

        private void button2_Click(object sender, EventArgs e)
        {
            OnLoad(e);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            if (transactionServiceBindingSource.Current is TransactionService tx)
            {
                tx.TransactionDate = transactionDateDateTimePicker.Value;

                if (string.IsNullOrEmpty(tx.PoliceRegistrationNumber))
                {
                    MessageBox.Show("Police Registration Number is required");
                    return;
                }

                if (string.IsNullOrEmpty(tx.Damage))
                {
                    MessageBox.Show("Damage is required");
                    return;
                }

                if (comboBox1.SelectedIndex == -1)
                {
                    MessageBox.Show("Plese select a mechanic");
                    return;
                }

                if (tx.DetailProduct.Count == 0 && tx.DetailService.Count == 0)
                {
                    MessageBox.Show("Please insert at least a product or a service");
                    return;
                }

                if (tx.ChangeMoney < 0)
                {
                    MessageBox.Show("Dont have any money? go make some");
                    return;
                }

                Helper.Db.TransactionService.AddOrUpdate(tx);
                Helper.Db.SaveChanges();
                OnLoad(e);
                MessageBox.Show("Transaction has been saved successfully");
            }
        }
    }
}
