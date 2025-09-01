namespace ubigpos
{
    partial class Form2
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            fontDialog1 = new FontDialog();
            groupBox1 = new GroupBox();
            label1 = new Label();
            label2 = new Label();
            label6 = new Label();
            textBox1 = new TextBox();
            label3 = new Label();
            textBox2 = new TextBox();
            label4 = new Label();
            textBox3 = new TextBox();
            label5 = new Label();
            textBox4 = new TextBox();
            button1 = new Button();
            label7 = new Label();
            linkLabel1 = new LinkLabel();
            groupBox1.SuspendLayout();
            SuspendLayout();
            // 
            // groupBox1
            // 
            groupBox1.Controls.Add(label5);
            groupBox1.Controls.Add(textBox4);
            groupBox1.Controls.Add(label4);
            groupBox1.Controls.Add(textBox3);
            groupBox1.Controls.Add(label3);
            groupBox1.Controls.Add(textBox2);
            groupBox1.Controls.Add(label6);
            groupBox1.Controls.Add(textBox1);
            groupBox1.Location = new Point(68, 101);
            groupBox1.Name = "groupBox1";
            groupBox1.Size = new Size(647, 168);
            groupBox1.TabIndex = 0;
            groupBox1.TabStop = false;
            groupBox1.Text = "Information";
            groupBox1.Enter += groupBox1_Enter;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Font = new Font("Segoe UI", 20.25F, FontStyle.Bold, GraphicsUnit.Point, 0);
            label1.Location = new Point(62, 32);
            label1.Name = "label1";
            label1.Size = new Size(213, 37);
            label1.TabIndex = 1;
            label1.Text = "Create Account";
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Font = new Font("Segoe UI", 9.75F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label2.Location = new Point(68, 67);
            label2.Name = "label2";
            label2.Size = new Size(318, 17);
            label2.TabIndex = 2;
            label2.Text = "Fill in below inormation to complate your registration";
            // 
            // label6
            // 
            label6.AutoSize = true;
            label6.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label6.Location = new Point(35, 26);
            label6.Name = "label6";
            label6.Size = new Size(86, 21);
            label6.TabIndex = 13;
            label6.Text = "First Name";
            label6.Click += label6_Click;
            // 
            // textBox1
            // 
            textBox1.Location = new Point(35, 49);
            textBox1.Margin = new Padding(3, 2, 3, 2);
            textBox1.Name = "textBox1";
            textBox1.Size = new Size(254, 23);
            textBox1.TabIndex = 12;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label3.Location = new Point(35, 95);
            label3.Name = "label3";
            label3.Size = new Size(48, 21);
            label3.TabIndex = 15;
            label3.Text = "Email";
            label3.Click += this.label3_Click;
            // 
            // textBox2
            // 
            textBox2.Location = new Point(35, 118);
            textBox2.Margin = new Padding(3, 2, 3, 2);
            textBox2.Name = "textBox2";
            textBox2.Size = new Size(254, 23);
            textBox2.TabIndex = 14;
            textBox2.TextChanged += this.textBox2_TextChanged;
            // 
            // label4
            // 
            label4.AutoSize = true;
            label4.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label4.Location = new Point(356, 26);
            label4.Name = "label4";
            label4.Size = new Size(84, 21);
            label4.TabIndex = 17;
            label4.Text = "Last Name";
            // 
            // textBox3
            // 
            textBox3.Location = new Point(356, 49);
            textBox3.Margin = new Padding(3, 2, 3, 2);
            textBox3.Name = "textBox3";
            textBox3.Size = new Size(254, 23);
            textBox3.TabIndex = 16;
            textBox3.TextChanged += textBox3_TextChanged;
            // 
            // label5
            // 
            label5.AutoSize = true;
            label5.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label5.Location = new Point(356, 95);
            label5.Name = "label5";
            label5.Size = new Size(76, 21);
            label5.TabIndex = 19;
            label5.Text = "Password";
            // 
            // textBox4
            // 
            textBox4.Location = new Point(356, 118);
            textBox4.Margin = new Padding(3, 2, 3, 2);
            textBox4.Name = "textBox4";
            textBox4.Size = new Size(254, 23);
            textBox4.TabIndex = 18;
            // 
            // button1
            // 
            button1.BackColor = Color.LightGray;
            button1.FlatStyle = FlatStyle.Flat;
            button1.Font = new Font("Segoe UI", 14.25F, FontStyle.Regular, GraphicsUnit.Point, 0);
            button1.Location = new Point(68, 289);
            button1.Name = "button1";
            button1.Size = new Size(322, 66);
            button1.TabIndex = 3;
            button1.Text = "Create Account";
            button1.UseVisualStyleBackColor = false;
            button1.Click += button1_Click;
            // 
            // label7
            // 
            label7.AutoSize = true;
            label7.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            label7.Location = new Point(68, 369);
            label7.Name = "label7";
            label7.Size = new Size(186, 21);
            label7.TabIndex = 4;
            label7.Text = "Already have an account?";
            label7.Click += label7_Click;
            // 
            // linkLabel1
            // 
            linkLabel1.AutoSize = true;
            linkLabel1.Font = new Font("Segoe UI", 12F, FontStyle.Regular, GraphicsUnit.Point, 0);
            linkLabel1.Location = new Point(260, 369);
            linkLabel1.Name = "linkLabel1";
            linkLabel1.Size = new Size(49, 21);
            linkLabel1.TabIndex = 5;
            linkLabel1.TabStop = true;
            linkLabel1.Text = "Login";
            // 
            // Form2
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(793, 462);
            Controls.Add(linkLabel1);
            Controls.Add(label7);
            Controls.Add(button1);
            Controls.Add(label2);
            Controls.Add(label1);
            Controls.Add(groupBox1);
            Name = "Form2";
            Text = "UbigPos = Register Fomr";
            Load += Form2_Load;
            groupBox1.ResumeLayout(false);
            groupBox1.PerformLayout();
            ResumeLayout(false);
            PerformLayout();
        }
        // Add this method to the Form2 class to fix CS1061
        private void label3_Click(object sender, EventArgs e)
        {
            // You can add any desired logic here, or leave it empty if not needed
        }
        // Add this method to the Form2 class to fix CS1061
        private void textBox2_TextChanged(object sender, EventArgs e)
        {
            // You can add any desired logic here, or leave it empty if not needed
        }
        #endregion

        private FontDialog fontDialog1;
        private GroupBox groupBox1;
        private Label label1;
        private Label label2;
        private Label label6;
        private TextBox textBox1;
        private Label label3;
        private TextBox textBox2;
        private Label label4;
        private TextBox textBox3;
        private Button button1;
        private Label label5;
        private TextBox textBox4;
        private Label label7;
        private LinkLabel linkLabel1;
    }
}