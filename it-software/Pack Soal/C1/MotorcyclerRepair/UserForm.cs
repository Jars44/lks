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
    public partial class UserForm : Form
    {
        public UserForm()
        {
            InitializeComponent();
        }

        private void UserForm_Load(object sender, EventArgs e)
        {
            tableBindingSource.DataSource = Helper.Db.Users.ToList();
            userNameTextBox.Clear();
            userPasswordTextBox.Clear();

            var prefix = $"USR-{DateTime.Now:yy}";
            var user = Helper.Db.Users.Where(f => f.UserCode.StartsWith(prefix)).OrderByDescending(f => f.UserCode).FirstOrDefault();

            if (user == default) prefix += "-01";
            else
            {
                int number = int.Parse(user.UserCode.Replace(prefix + "-", "")) + 1;
                prefix += "-" + number.ToString().PadLeft(2, '0');
            }

            userCodeTextBox.Text = prefix;
        }

        private void button4_Click(object sender, EventArgs e)
        {
            OnLoad(e);
        }

        private void button1_Click(object sender, EventArgs e)
        {
            var length = userNameTextBox.Text.Length;
            if (!(length >= 3 && length <=25))
            {
                MessageBox.Show("Username must be 3-25 chars long");
                return;
            }

            if (string.IsNullOrEmpty(userPasswordTextBox.Text))
            {
                MessageBox.Show("Password is required");
                return;
            }

            var user = new Users
            {
                UserCode = userCodeTextBox.Text,
                UserName = userNameTextBox.Text,
                UserPassword = userPasswordTextBox.Text
            };
            Helper.Db.Users.AddOrUpdate(user);
            Helper.Db.SaveChanges();
            OnLoad(e);
        }

        private void button2_Click(object sender, EventArgs e)
        {
            var user = Helper.Db.Users.FirstOrDefault(f => f.UserCode == userCodeTextBox.Text);
            if (user != default)
            {
                var length = userNameTextBox.Text.Length;
                if (!(length >= 3 && length <= 25))
                {
                    MessageBox.Show("Username must be 3-25 chars long");
                    return;
                }

                if (string.IsNullOrEmpty(userPasswordTextBox.Text))
                {
                    MessageBox.Show("Password is required");
                    return;
                }

                user = new Users
                {
                    UserCode = userCodeTextBox.Text,
                    UserName = userNameTextBox.Text,
                    UserPassword = userPasswordTextBox.Text
                };
                Helper.Db.Users.AddOrUpdate(user);
                Helper.Db.SaveChanges();
                OnLoad(e);
            } else
            {
                MessageBox.Show("Please select a row");
            }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            var user = Helper.Db.Users.FirstOrDefault(f => f.UserCode == userCodeTextBox.Text);
            if (user != default)
            {
                if (MessageBox.Show("Are you sure?", "Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    Helper.Db.Users.Remove(user);
                    Helper.Db.SaveChanges();
                    OnLoad(e);
                }
            }
            else
            {
                MessageBox.Show("Please select a row");
            }
        }

        private void tableBindingSource_CurrentChanged(object sender, EventArgs e)
        {
            if(tableBindingSource.Current is Users user)
            {
                userCodeTextBox.Text = user.UserCode;
                userNameTextBox.Text = user.UserName;
                userPasswordTextBox.Text = user.UserPassword;
            }
        }
    }
}
