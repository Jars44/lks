namespace MotorcyclerRepair
{
    partial class TransactionForm
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
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.Label changeMoneyLabel;
            System.Windows.Forms.Label damageLabel;
            System.Windows.Forms.Label paidLabel;
            System.Windows.Forms.Label policeRegistrationNumberLabel;
            System.Windows.Forms.Label totalChargeLabel;
            System.Windows.Forms.Label transactionDateLabel;
            System.Windows.Forms.Label transactionNumberLabel;
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.damageTextBox = new System.Windows.Forms.TextBox();
            this.transactionServiceBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.policeRegistrationNumberTextBox = new System.Windows.Forms.TextBox();
            this.transactionDateDateTimePicker = new System.Windows.Forms.DateTimePicker();
            this.transactionNumberTextBox = new System.Windows.Forms.TextBox();
            this.changeMoneyTextBox = new System.Windows.Forms.TextBox();
            this.paidTextBox = new System.Windows.Forms.TextBox();
            this.totalChargeTextBox = new System.Windows.Forms.TextBox();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.textBox2 = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.textBox1 = new System.Windows.Forms.TextBox();
            this.label1 = new System.Windows.Forms.Label();
            this.dataGridView1 = new System.Windows.Forms.DataGridView();
            this.ServiceCodeColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ServiceNameColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.CostColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.textBox3 = new System.Windows.Forms.TextBox();
            this.label3 = new System.Windows.Forms.Label();
            this.textBox4 = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.dataGridView2 = new System.Windows.Forms.DataGridView();
            this.ProductCodeColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.ProductNameColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.PriceColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.AmountColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.TotalColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.comboBox1 = new System.Windows.Forms.ComboBox();
            this.label5 = new System.Windows.Forms.Label();
            this.groupBox5 = new System.Windows.Forms.GroupBox();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            this.groupBox6 = new System.Windows.Forms.GroupBox();
            changeMoneyLabel = new System.Windows.Forms.Label();
            damageLabel = new System.Windows.Forms.Label();
            paidLabel = new System.Windows.Forms.Label();
            policeRegistrationNumberLabel = new System.Windows.Forms.Label();
            totalChargeLabel = new System.Windows.Forms.Label();
            transactionDateLabel = new System.Windows.Forms.Label();
            transactionNumberLabel = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.transactionServiceBindingSource)).BeginInit();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).BeginInit();
            this.groupBox3.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).BeginInit();
            this.groupBox4.SuspendLayout();
            this.groupBox5.SuspendLayout();
            this.groupBox6.SuspendLayout();
            this.SuspendLayout();
            // 
            // changeMoneyLabel
            // 
            changeMoneyLabel.AutoSize = true;
            changeMoneyLabel.Location = new System.Drawing.Point(55, 92);
            changeMoneyLabel.Name = "changeMoneyLabel";
            changeMoneyLabel.Size = new System.Drawing.Size(82, 13);
            changeMoneyLabel.TabIndex = 0;
            changeMoneyLabel.Text = "Change Money:";
            // 
            // damageLabel
            // 
            damageLabel.AutoSize = true;
            damageLabel.Location = new System.Drawing.Point(441, 57);
            damageLabel.Name = "damageLabel";
            damageLabel.Size = new System.Drawing.Size(50, 13);
            damageLabel.TabIndex = 2;
            damageLabel.Text = "Damage:";
            // 
            // paidLabel
            // 
            paidLabel.AutoSize = true;
            paidLabel.Location = new System.Drawing.Point(55, 66);
            paidLabel.Name = "paidLabel";
            paidLabel.Size = new System.Drawing.Size(31, 13);
            paidLabel.TabIndex = 4;
            paidLabel.Text = "Paid:";
            paidLabel.Click += new System.EventHandler(this.paidLabel_Click);
            // 
            // policeRegistrationNumberLabel
            // 
            policeRegistrationNumberLabel.AutoSize = true;
            policeRegistrationNumberLabel.Location = new System.Drawing.Point(441, 31);
            policeRegistrationNumberLabel.Name = "policeRegistrationNumberLabel";
            policeRegistrationNumberLabel.Size = new System.Drawing.Size(138, 13);
            policeRegistrationNumberLabel.TabIndex = 6;
            policeRegistrationNumberLabel.Text = "Police Registration Number:";
            // 
            // totalChargeLabel
            // 
            totalChargeLabel.AutoSize = true;
            totalChargeLabel.Location = new System.Drawing.Point(55, 40);
            totalChargeLabel.Name = "totalChargeLabel";
            totalChargeLabel.Size = new System.Drawing.Size(71, 13);
            totalChargeLabel.TabIndex = 8;
            totalChargeLabel.Text = "Total Charge:";
            // 
            // transactionDateLabel
            // 
            transactionDateLabel.AutoSize = true;
            transactionDateLabel.Location = new System.Drawing.Point(91, 58);
            transactionDateLabel.Name = "transactionDateLabel";
            transactionDateLabel.Size = new System.Drawing.Size(92, 13);
            transactionDateLabel.TabIndex = 10;
            transactionDateLabel.Text = "Transaction Date:";
            // 
            // transactionNumberLabel
            // 
            transactionNumberLabel.AutoSize = true;
            transactionNumberLabel.Location = new System.Drawing.Point(91, 31);
            transactionNumberLabel.Name = "transactionNumberLabel";
            transactionNumberLabel.Size = new System.Drawing.Size(106, 13);
            transactionNumberLabel.TabIndex = 12;
            transactionNumberLabel.Text = "Transaction Number:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(damageLabel);
            this.groupBox1.Controls.Add(this.damageTextBox);
            this.groupBox1.Controls.Add(policeRegistrationNumberLabel);
            this.groupBox1.Controls.Add(this.policeRegistrationNumberTextBox);
            this.groupBox1.Controls.Add(transactionDateLabel);
            this.groupBox1.Controls.Add(this.transactionDateDateTimePicker);
            this.groupBox1.Controls.Add(transactionNumberLabel);
            this.groupBox1.Controls.Add(this.transactionNumberTextBox);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(876, 99);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Motorcycles";
            // 
            // damageTextBox
            // 
            this.damageTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "Damage", true));
            this.damageTextBox.Location = new System.Drawing.Point(585, 54);
            this.damageTextBox.Name = "damageTextBox";
            this.damageTextBox.Size = new System.Drawing.Size(200, 20);
            this.damageTextBox.TabIndex = 3;
            // 
            // transactionServiceBindingSource
            // 
            this.transactionServiceBindingSource.DataSource = typeof(MotorcyclerRepair.TransactionService);
            // 
            // policeRegistrationNumberTextBox
            // 
            this.policeRegistrationNumberTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "PoliceRegistrationNumber", true));
            this.policeRegistrationNumberTextBox.Location = new System.Drawing.Point(585, 28);
            this.policeRegistrationNumberTextBox.Name = "policeRegistrationNumberTextBox";
            this.policeRegistrationNumberTextBox.Size = new System.Drawing.Size(200, 20);
            this.policeRegistrationNumberTextBox.TabIndex = 7;
            // 
            // transactionDateDateTimePicker
            // 
            this.transactionDateDateTimePicker.CustomFormat = "dd MMM yyyy";
            this.transactionDateDateTimePicker.DataBindings.Add(new System.Windows.Forms.Binding("Value", this.transactionServiceBindingSource, "TransactionDate", true));
            this.transactionDateDateTimePicker.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.transactionDateDateTimePicker.Location = new System.Drawing.Point(235, 54);
            this.transactionDateDateTimePicker.Name = "transactionDateDateTimePicker";
            this.transactionDateDateTimePicker.Size = new System.Drawing.Size(200, 20);
            this.transactionDateDateTimePicker.TabIndex = 11;
            // 
            // transactionNumberTextBox
            // 
            this.transactionNumberTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "TransactionNumber", true));
            this.transactionNumberTextBox.Location = new System.Drawing.Point(235, 28);
            this.transactionNumberTextBox.Name = "transactionNumberTextBox";
            this.transactionNumberTextBox.ReadOnly = true;
            this.transactionNumberTextBox.Size = new System.Drawing.Size(200, 20);
            this.transactionNumberTextBox.TabIndex = 13;
            // 
            // changeMoneyTextBox
            // 
            this.changeMoneyTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "ChangeMoney", true));
            this.changeMoneyTextBox.Location = new System.Drawing.Point(199, 89);
            this.changeMoneyTextBox.Name = "changeMoneyTextBox";
            this.changeMoneyTextBox.ReadOnly = true;
            this.changeMoneyTextBox.Size = new System.Drawing.Size(200, 20);
            this.changeMoneyTextBox.TabIndex = 1;
            // 
            // paidTextBox
            // 
            this.paidTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "Paid", true));
            this.paidTextBox.Location = new System.Drawing.Point(199, 63);
            this.paidTextBox.Name = "paidTextBox";
            this.paidTextBox.Size = new System.Drawing.Size(200, 20);
            this.paidTextBox.TabIndex = 5;
            this.paidTextBox.TextChanged += new System.EventHandler(this.paidTextBox_TextChanged);
            // 
            // totalChargeTextBox
            // 
            this.totalChargeTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "TotalCharge", true));
            this.totalChargeTextBox.Location = new System.Drawing.Point(199, 37);
            this.totalChargeTextBox.Name = "totalChargeTextBox";
            this.totalChargeTextBox.ReadOnly = true;
            this.totalChargeTextBox.Size = new System.Drawing.Size(200, 20);
            this.totalChargeTextBox.TabIndex = 9;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.textBox2);
            this.groupBox2.Controls.Add(this.label2);
            this.groupBox2.Controls.Add(this.textBox1);
            this.groupBox2.Controls.Add(this.label1);
            this.groupBox2.Controls.Add(this.dataGridView1);
            this.groupBox2.Location = new System.Drawing.Point(12, 117);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(878, 192);
            this.groupBox2.TabIndex = 10;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Service";
            this.groupBox2.Enter += new System.EventHandler(this.groupBox2_Enter);
            // 
            // textBox2
            // 
            this.textBox2.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "TotalServiceCost", true));
            this.textBox2.Location = new System.Drawing.Point(702, 160);
            this.textBox2.Name = "textBox2";
            this.textBox2.ReadOnly = true;
            this.textBox2.Size = new System.Drawing.Size(168, 20);
            this.textBox2.TabIndex = 4;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(602, 163);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(94, 13);
            this.label2.TabIndex = 3;
            this.label2.Text = "Total Service Cost";
            // 
            // textBox1
            // 
            this.textBox1.Location = new System.Drawing.Point(82, 160);
            this.textBox1.Name = "textBox1";
            this.textBox1.ReadOnly = true;
            this.textBox1.Size = new System.Drawing.Size(168, 20);
            this.textBox1.TabIndex = 2;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(6, 163);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(70, 13);
            this.label1.TabIndex = 1;
            this.label1.Text = "Total Service";
            // 
            // dataGridView1
            // 
            this.dataGridView1.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView1.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView1.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ServiceCodeColumn,
            this.ServiceNameColumn,
            this.CostColumn});
            this.dataGridView1.Location = new System.Drawing.Point(6, 19);
            this.dataGridView1.Name = "dataGridView1";
            this.dataGridView1.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView1.Size = new System.Drawing.Size(864, 126);
            this.dataGridView1.TabIndex = 0;
            this.dataGridView1.CellContentDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellContentDoubleClick);
            this.dataGridView1.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellDoubleClick);
            this.dataGridView1.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView1_CellEndEdit);
            // 
            // ServiceCodeColumn
            // 
            this.ServiceCodeColumn.HeaderText = "Service Code";
            this.ServiceCodeColumn.Name = "ServiceCodeColumn";
            // 
            // ServiceNameColumn
            // 
            this.ServiceNameColumn.HeaderText = "ServiceName";
            this.ServiceNameColumn.Name = "ServiceNameColumn";
            this.ServiceNameColumn.ReadOnly = true;
            // 
            // CostColumn
            // 
            this.CostColumn.HeaderText = "Cost";
            this.CostColumn.Name = "CostColumn";
            this.CostColumn.ReadOnly = true;
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.textBox3);
            this.groupBox3.Controls.Add(this.label3);
            this.groupBox3.Controls.Add(this.textBox4);
            this.groupBox3.Controls.Add(this.label4);
            this.groupBox3.Controls.Add(this.dataGridView2);
            this.groupBox3.Location = new System.Drawing.Point(12, 315);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(878, 192);
            this.groupBox3.TabIndex = 11;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Product";
            // 
            // textBox3
            // 
            this.textBox3.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.transactionServiceBindingSource, "TotalProductPrice", true));
            this.textBox3.Location = new System.Drawing.Point(702, 160);
            this.textBox3.Name = "textBox3";
            this.textBox3.ReadOnly = true;
            this.textBox3.Size = new System.Drawing.Size(168, 20);
            this.textBox3.TabIndex = 4;
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(602, 163);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(98, 13);
            this.label3.TabIndex = 3;
            this.label3.Text = "Total Product Price";
            // 
            // textBox4
            // 
            this.textBox4.Location = new System.Drawing.Point(82, 160);
            this.textBox4.Name = "textBox4";
            this.textBox4.ReadOnly = true;
            this.textBox4.Size = new System.Drawing.Size(168, 20);
            this.textBox4.TabIndex = 2;
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 163);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(71, 13);
            this.label4.TabIndex = 1;
            this.label4.Text = "Total Product";
            // 
            // dataGridView2
            // 
            this.dataGridView2.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.dataGridView2.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dataGridView2.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.ProductCodeColumn,
            this.ProductNameColumn,
            this.PriceColumn,
            this.AmountColumn,
            this.TotalColumn});
            this.dataGridView2.Location = new System.Drawing.Point(6, 19);
            this.dataGridView2.Name = "dataGridView2";
            this.dataGridView2.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.dataGridView2.Size = new System.Drawing.Size(864, 126);
            this.dataGridView2.TabIndex = 0;
            this.dataGridView2.CellDoubleClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView2_CellDoubleClick);
            this.dataGridView2.CellEndEdit += new System.Windows.Forms.DataGridViewCellEventHandler(this.dataGridView2_CellEndEdit);
            // 
            // ProductCodeColumn
            // 
            this.ProductCodeColumn.HeaderText = "Product Code";
            this.ProductCodeColumn.Name = "ProductCodeColumn";
            // 
            // ProductNameColumn
            // 
            this.ProductNameColumn.HeaderText = "Product Name";
            this.ProductNameColumn.Name = "ProductNameColumn";
            this.ProductNameColumn.ReadOnly = true;
            // 
            // PriceColumn
            // 
            this.PriceColumn.HeaderText = "Price";
            this.PriceColumn.Name = "PriceColumn";
            this.PriceColumn.ReadOnly = true;
            // 
            // AmountColumn
            // 
            this.AmountColumn.HeaderText = "Amount";
            this.AmountColumn.Name = "AmountColumn";
            // 
            // TotalColumn
            // 
            this.TotalColumn.HeaderText = "Total";
            this.TotalColumn.Name = "TotalColumn";
            this.TotalColumn.ReadOnly = true;
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.comboBox1);
            this.groupBox4.Controls.Add(this.label5);
            this.groupBox4.Location = new System.Drawing.Point(12, 513);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(876, 86);
            this.groupBox4.TabIndex = 12;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Mechanic";
            // 
            // comboBox1
            // 
            this.comboBox1.DataBindings.Add(new System.Windows.Forms.Binding("SelectedValue", this.transactionServiceBindingSource, "MechanicCode", true));
            this.comboBox1.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.comboBox1.FormattingEnabled = true;
            this.comboBox1.Location = new System.Drawing.Point(113, 33);
            this.comboBox1.Name = "comboBox1";
            this.comboBox1.Size = new System.Drawing.Size(207, 21);
            this.comboBox1.TabIndex = 1;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(22, 37);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(85, 13);
            this.label5.TabIndex = 0;
            this.label5.Text = "Mechanic Name";
            // 
            // groupBox5
            // 
            this.groupBox5.Controls.Add(this.button2);
            this.groupBox5.Controls.Add(this.button1);
            this.groupBox5.Location = new System.Drawing.Point(12, 605);
            this.groupBox5.Name = "groupBox5";
            this.groupBox5.Size = new System.Drawing.Size(415, 146);
            this.groupBox5.TabIndex = 13;
            this.groupBox5.TabStop = false;
            this.groupBox5.Text = "Process";
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(157, 112);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(174, 28);
            this.button2.TabIndex = 1;
            this.button2.Text = "Cancel";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(25, 31);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(157, 83);
            this.button1.TabIndex = 0;
            this.button1.Text = "Save";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // groupBox6
            // 
            this.groupBox6.Controls.Add(this.totalChargeTextBox);
            this.groupBox6.Controls.Add(this.paidTextBox);
            this.groupBox6.Controls.Add(paidLabel);
            this.groupBox6.Controls.Add(this.changeMoneyTextBox);
            this.groupBox6.Controls.Add(totalChargeLabel);
            this.groupBox6.Controls.Add(changeMoneyLabel);
            this.groupBox6.Location = new System.Drawing.Point(433, 605);
            this.groupBox6.Name = "groupBox6";
            this.groupBox6.Size = new System.Drawing.Size(455, 146);
            this.groupBox6.TabIndex = 14;
            this.groupBox6.TabStop = false;
            this.groupBox6.Text = "Charge";
            // 
            // TransactionForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(902, 775);
            this.Controls.Add(this.groupBox6);
            this.Controls.Add(this.groupBox5);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.groupBox1);
            this.Name = "TransactionForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Transaction";
            this.Load += new System.EventHandler(this.TransactionForm_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.transactionServiceBindingSource)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView1)).EndInit();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.dataGridView2)).EndInit();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            this.groupBox5.ResumeLayout(false);
            this.groupBox6.ResumeLayout(false);
            this.groupBox6.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.TextBox damageTextBox;
        private System.Windows.Forms.BindingSource transactionServiceBindingSource;
        private System.Windows.Forms.TextBox policeRegistrationNumberTextBox;
        private System.Windows.Forms.DateTimePicker transactionDateDateTimePicker;
        private System.Windows.Forms.TextBox transactionNumberTextBox;
        private System.Windows.Forms.TextBox changeMoneyTextBox;
        private System.Windows.Forms.TextBox paidTextBox;
        private System.Windows.Forms.TextBox totalChargeTextBox;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.DataGridView dataGridView1;
        private System.Windows.Forms.DataGridViewTextBoxColumn ServiceCodeColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn ServiceNameColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn CostColumn;
        private System.Windows.Forms.TextBox textBox2;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.TextBox textBox1;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.TextBox textBox3;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.TextBox textBox4;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.DataGridView dataGridView2;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductCodeColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn ProductNameColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn PriceColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn AmountColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn TotalColumn;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.ComboBox comboBox1;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.GroupBox groupBox5;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.GroupBox groupBox6;
    }
}