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
    public partial class RouteForm : Form
    {
        public RouteForm()
        {
            InitializeComponent();
        }

        private void RouteForm_Load(object sender, EventArgs e)
        {
            comboBox1.DataSource = Helper.Db.Route.ToList();
            comboBox1.DisplayMember = "routeName";
            comboBox1.ValueMember = "routeId";
        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {
            var route = comboBox1.SelectedItem as Route;
            tableLayoutPanel1.ColumnStyles.Clear();
            tableLayoutPanel1.Controls.Clear();

            var details = route.RouteDetail.ToList();
            var pointSize = (tableLayoutPanel1.Width - 100) / details.Count;
            tableLayoutPanel1.ColumnCount = details.Count + 1;

            foreach (var detail in details)
            {
                var index = details.IndexOf(detail);
                tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle
                {
                    SizeType = SizeType.Absolute,
                    Width = pointSize
                });

                var containerPanel = new Panel
                {
                    Dock = DockStyle.Fill,
                    Margin = Padding.Empty
                };
                var panel1 = new Panel
                {
                    BackColor = Color.Red,
                    Width = 25,
                    Height = 25,
                    Margin = Padding.Empty,
                    Dock = DockStyle.Left
                };

                var panel2 = new Panel
                {
                    BackColor = Color.Green,
                    Width = 25,
                    Height = 15,
                    Margin = Padding.Empty,
                    Dock = DockStyle.Left
                };
                tableLayoutPanel1.Controls.Add(containerPanel, index, 1);
                if (index != details.Count - 1) containerPanel.Controls.Add(panel2);
                containerPanel.Controls.Add(panel1);

                if (index % 2 == 0)
                {
                    tableLayoutPanel1.Controls.Add(new Label
                    {
                        Dock = DockStyle.Bottom,
                        Text = detail.Station.stationName
                    }, index, 0);
                }
                else
                {
                    tableLayoutPanel1.Controls.Add(new Label
                    {
                        Dock = DockStyle.Top,
                        Text = detail.Station.stationName
                    }, index, 2);
                }

                panel2.Width = containerPanel.Width - panel1.Width;
            }

            tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle
            {
                SizeType = SizeType.Percent,
                Width = 100f
            });
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Helper.MainContext.MainForm = new Form1();
            Helper.MainContext.MainForm.Show();
            Close();
        }
    }
}
