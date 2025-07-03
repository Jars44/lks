using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Data.Entity;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HovRailKiosk
{
    public partial class BookForm : Form
    {
        public BookForm()
        {
            InitializeComponent();
        }

        private void button4_Click(object sender, EventArgs e)
        {
            var station1 = comboBox1.SelectedItem as Station;
            var station2 = comboBox2.SelectedItem as Station;
            var date = dateTimePicker1.Value;

            if (station1.stationID == station2.stationID)
            {
                MessageBox.Show("Departure and Arrival station cannot be the same");
                return;
            }

            var data = Helper.Db.Schedule.Where(f => f.Route.departureStationID == station1.stationID && f.Route.arrivalStationID == station2.stationID && DbFunctions.TruncateTime(f.departureTime) == date.Date).ToList();
            scheduleBindingSource.DataSource = data;
        }

        private void BookForm_Load(object sender, EventArgs e)
        {
            button1.Enabled = tabControl1.SelectedIndex != 0;
            comboBox1.DataSource = Helper.Db.Station.ToList();
            comboBox1.DisplayMember = "stationName";
            comboBox1.ValueMember = "stationID";

            comboBox2.DataSource = Helper.Db.Station.ToList();
            comboBox2.DisplayMember = "stationName";
            comboBox2.ValueMember = "stationID";
        }

        private void scheduleDataGridView_CellFormatting(object sender, DataGridViewCellFormattingEventArgs e)
        {
            try
            {
                var data = scheduleDataGridView.Rows[e.RowIndex].DataBoundItem as Schedule;
                var header = scheduleDataGridView.Columns[e.ColumnIndex].HeaderText;

                var duration = data.Route.RouteDetail.Sum(f => f.travelHour);
                var arrivalTime = data.departureTime.AddHours((int)duration);
                var price = data.Route.fixedPrice + duration * data.Route.pricePerHour;
                var availableSeat = data.Train.capacity - data.Ticket.Count;

                if (header == "Route") e.Value = data.Route.routeName;
                if (header == "Train") e.Value = data.Train.trainName;
                if (header == "Departure Time") e.Value = data.departureTime.ToString("dd MMM yyyy HH:mm:ss");
                if (header == "ArrivalTime") e.Value = arrivalTime.ToString("dd MMM yyyy HH:mm:ss");
                if (header == "Price") e.Value = (int)price;
                if (header == "Available Seat") e.Value = availableSeat;

                if (availableSeat == 0)
                {
                    e.CellStyle.BackColor = Color.Red;
                }
            } catch { }
        }

        private void button3_Click(object sender, EventArgs e)
        {
            Helper.MainContext.MainForm = new Form1();
            Helper.MainContext.MainForm.Show();
            Close();
        }

        private void DrawSeat(Schedule sch, int selectedSeat = -1)
        {
            tableLayoutPanel1.RowStyles.Clear();
            tableLayoutPanel1.ColumnStyles.Clear();
            tableLayoutPanel1.Controls.Clear();
            var seats = sch.Train.capacity;

            var width = 50;

            tableLayoutPanel1.RowStyles.Add(new RowStyle
            {
                SizeType = SizeType.Absolute,
                Height = width
            });
            tableLayoutPanel1.ColumnCount = seats;
            tableLayoutPanel1.RowCount = 2;

            var isChoosed = false;

            for (int seat = 1; seat <= seats; seat++)
            {
                tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle
                {
                    SizeType = SizeType.Absolute,
                    Width = width + 10
                });

                var isBooked = sch.Ticket.Any(f => f.seatNumber == seat);

                var button = new Button
                {
                    Tag = seat,
                    Text = seat.ToString(),
                    Margin = new Padding(0, 0, 0, 10),
                    Width = width,
                    Height = width,
                    Dock = DockStyle.Left,
                    BackColor = isBooked ? Color.Red : Color.White
                };
                if (!isBooked)
                {
                    button.Click += (a, b) =>
                    {
                        DrawSeat(sch, (int)button.Tag);
                    };
                }
                
                if (((!isBooked && selectedSeat == -1) || (selectedSeat == seat)) && !isChoosed)
                {
                    isChoosed = true;
                    button.BackColor = Color.Yellow;
                }

                tableLayoutPanel1.Controls.Add(button, seat - 1, 0);
            }

            tableLayoutPanel1.ColumnStyles.Add(new ColumnStyle
            {
                SizeType = SizeType.Percent,
                Width = 100f
            });

            tableLayoutPanel1.RowStyles.Add(new RowStyle
            {
                SizeType = SizeType.Percent,
                Height = 100f
            });
        }


        private bool Tab1IsValid()
        {
            if (scheduleDataGridView.SelectedRows.Count > 0 && scheduleDataGridView.SelectedRows[0].DataBoundItem is Schedule sch)
            {
                var schDate = sch.departureTime.Date;
                var start = schDate.AddDays(-3).Date;
                var end = schDate.AddDays(-1).Date;
                var date = DateTime.Now.Date;

                var availSeat = sch.Train.capacity - sch.Ticket.Count;
                if (date >= start && date <= end && availSeat > 0)
                {
                    return true;
                }
            }
            return false;
        }

        private bool Tab2IsValid()
        {
            var prevSelected = (int)(tableLayoutPanel1.Controls.OfType<Button>().FirstOrDefault(f => f.BackColor == Color.Yellow)?.Tag ?? -1);
            if (prevSelected != -1 && !string.IsNullOrEmpty(textBox1.Text))
            {
                return true;
            }
            return false;
        }

        private void tabControl1_Selecting(object sender, TabControlCancelEventArgs e)
        {
            if (tabControl1.Tag is bool b && b)
            {
                if (e.TabPageIndex == 1)
                {
                    if (Tab1IsValid())
                    {
                        var prevSelected = tableLayoutPanel1.Controls.OfType<Button>().FirstOrDefault(f => f.BackColor == Color.Yellow)?.Tag ?? -1;
                        DrawSeat(scheduleDataGridView.SelectedRows[0].DataBoundItem as Schedule, (int)prevSelected);
                    }
                    else
                    {
                        e.Cancel = true;
                        MessageBox.Show("Please select a ticket and book it at least one day in advance and up to three days before it's departure date, and there is available seat");
                    }
                }

                if (e.TabPageIndex == 2)
                {

                    if (Tab2IsValid())
                    {
                        var sch = scheduleDataGridView.SelectedRows[0].DataBoundItem as Schedule;
                        var duration = sch.Route.RouteDetail.Sum(f => f.travelHour);
                        var price = sch.Route.fixedPrice + duration * sch.Route.pricePerHour;
                        var arrivalTime = sch.departureTime.AddHours((int)duration);

                        label7.Text = $"Schedule Date: {DateTime.Now.ToString("dd MMM yyyy")}";
                        label8.Text = $"Route Name: {sch.Route.routeName}";
                        label9.Text = $"Departure Station: {sch.Route.Station1.stationName}";
                        label10.Text = $"Departure Time: {sch.departureTime.ToString("dd MMM yyy HH:mm:ss")}";
                        label11.Text = $"Passenger Name: {textBox1.Text}";
                        label12.Text = $"Price: {(int)price}";
                        label17.Text = $"Train Name: {sch.Train.trainName}";
                        label16.Text = $"Arrival Station: {sch.Route.Station.stationName}";
                        label15.Text = $"Arrival Time: {arrivalTime.ToString("dd MMM yyy HH:mm:ss")}";
                        label14.Text = $"Seat Number: {tableLayoutPanel1.Controls.OfType<Button>().First(f => f.BackColor == Color.Yellow).Tag}";
                    }
                    else
                    {
                        e.Cancel = true;
                        MessageBox.Show("Please enter your name and select a tempat duduk");
                    }
                }
            } else
            {
                e.Cancel = true;
            }
            

        }

        private void button2_Click(object sender, EventArgs e)
        {
            if (button2.Text == "Next")
            {
                tabControl1.Tag = true;
                tabControl1.SelectTab(tabControl1.SelectedIndex + 1);
                tabControl1.Tag = false;
            } else if (button2.Text == "Submit")
            {
                if (MessageBox.Show("Are you sure?", "Confirmation", MessageBoxButtons.YesNo) == DialogResult.Yes)
                {
                    var sch = scheduleDataGridView.SelectedRows[0].DataBoundItem as Schedule;
                    var duration = sch.Route.RouteDetail.Sum(f => f.travelHour);
                    var price = sch.Route.fixedPrice + duration * sch.Route.pricePerHour;
                    var arrivalTime = sch.departureTime.AddHours((int)duration);

                    var ticket = new Ticket
                    {
                        arrivalStationID = sch.Route.arrivalStationID,
                        arrivalTime = arrivalTime,
                        createdAt = DateTime.Now,
                        departureStationID = sch.Route.departureStationID,
                        passengerName = textBox1.Text,
                        departureTime = sch.departureTime,
                        price = price,
                        scheduleID = sch.scheduleID,
                        seatNumber = (int)tableLayoutPanel1.Controls.OfType<Button>().First(f => f.BackColor == Color.Yellow).Tag,
                    };
                    Helper.Db.Ticket.Add(ticket);
                    Helper.Db.SaveChanges();
                    button3.PerformClick();
                }
            }
            
        }

        private void tabControl1_Selected(object sender, TabControlEventArgs e)
        {
            if (tabControl1.SelectedIndex != tabControl1.TabCount - 1) button2.Text = "Next";
            else button2.Text = "Submit";

            button1.Enabled = tabControl1.SelectedIndex != 0;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            tabControl1.Tag = true;
            tabControl1.SelectTab(tabControl1.SelectedIndex - 1);
            tabControl1.Tag = false;
        }
    }
}
