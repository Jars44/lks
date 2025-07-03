namespace MotorcyclerRepair
{
    partial class ServicesForm
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
            System.Windows.Forms.Label costLabel;
            System.Windows.Forms.Label serviceCodeLabel;
            System.Windows.Forms.Label serviceNameLabel;
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.costTextBox = new System.Windows.Forms.TextBox();
            this.formBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.serviceCodeTextBox = new System.Windows.Forms.TextBox();
            this.serviceNameTextBox = new System.Windows.Forms.TextBox();
            this.motorcycleServicesDataGridView = new System.Windows.Forms.DataGridView();
            this.dataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn2 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataGridViewTextBoxColumn3 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.motorcycleServicesBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.button4 = new System.Windows.Forms.Button();
            this.button3 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.button1 = new System.Windows.Forms.Button();
            costLabel = new System.Windows.Forms.Label();
            serviceCodeLabel = new System.Windows.Forms.Label();
            serviceNameLabel = new System.Windows.Forms.Label();
            this.groupBox1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.formBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.motorcycleServicesDataGridView)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.motorcycleServicesBindingSource)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.SuspendLayout();
            // 
            // costLabel
            // 
            costLabel.AutoSize = true;
            costLabel.Location = new System.Drawing.Point(78, 33);
            costLabel.Name = "costLabel";
            costLabel.Size = new System.Drawing.Size(31, 13);
            costLabel.TabIndex = 0;
            costLabel.Text = "Cost:";
            // 
            // serviceCodeLabel
            // 
            serviceCodeLabel.AutoSize = true;
            serviceCodeLabel.Location = new System.Drawing.Point(78, 59);
            serviceCodeLabel.Name = "serviceCodeLabel";
            serviceCodeLabel.Size = new System.Drawing.Size(74, 13);
            serviceCodeLabel.TabIndex = 2;
            serviceCodeLabel.Text = "Service Code:";
            // 
            // serviceNameLabel
            // 
            serviceNameLabel.AutoSize = true;
            serviceNameLabel.Location = new System.Drawing.Point(78, 85);
            serviceNameLabel.Name = "serviceNameLabel";
            serviceNameLabel.Size = new System.Drawing.Size(77, 13);
            serviceNameLabel.TabIndex = 4;
            serviceNameLabel.Text = "Service Name:";
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(costLabel);
            this.groupBox1.Controls.Add(this.costTextBox);
            this.groupBox1.Controls.Add(serviceCodeLabel);
            this.groupBox1.Controls.Add(this.serviceCodeTextBox);
            this.groupBox1.Controls.Add(serviceNameLabel);
            this.groupBox1.Controls.Add(this.serviceNameTextBox);
            this.groupBox1.Location = new System.Drawing.Point(12, 12);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(562, 121);
            this.groupBox1.TabIndex = 0;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "Service Detail";
            // 
            // costTextBox
            // 
            this.costTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.formBindingSource, "Cost", true));
            this.costTextBox.Location = new System.Drawing.Point(161, 30);
            this.costTextBox.Name = "costTextBox";
            this.costTextBox.Size = new System.Drawing.Size(323, 20);
            this.costTextBox.TabIndex = 1;
            // 
            // formBindingSource
            // 
            this.formBindingSource.DataSource = typeof(MotorcyclerRepair.MotorcycleServices);
            // 
            // serviceCodeTextBox
            // 
            this.serviceCodeTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.formBindingSource, "ServiceCode", true));
            this.serviceCodeTextBox.Location = new System.Drawing.Point(161, 56);
            this.serviceCodeTextBox.Name = "serviceCodeTextBox";
            this.serviceCodeTextBox.ReadOnly = true;
            this.serviceCodeTextBox.Size = new System.Drawing.Size(323, 20);
            this.serviceCodeTextBox.TabIndex = 3;
            // 
            // serviceNameTextBox
            // 
            this.serviceNameTextBox.DataBindings.Add(new System.Windows.Forms.Binding("Text", this.formBindingSource, "ServiceName", true));
            this.serviceNameTextBox.Location = new System.Drawing.Point(161, 82);
            this.serviceNameTextBox.Name = "serviceNameTextBox";
            this.serviceNameTextBox.Size = new System.Drawing.Size(323, 20);
            this.serviceNameTextBox.TabIndex = 5;
            // 
            // motorcycleServicesDataGridView
            // 
            this.motorcycleServicesDataGridView.AllowUserToAddRows = false;
            this.motorcycleServicesDataGridView.AllowUserToDeleteRows = false;
            this.motorcycleServicesDataGridView.AutoGenerateColumns = false;
            this.motorcycleServicesDataGridView.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.motorcycleServicesDataGridView.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.motorcycleServicesDataGridView.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.dataGridViewTextBoxColumn1,
            this.dataGridViewTextBoxColumn2,
            this.dataGridViewTextBoxColumn3});
            this.motorcycleServicesDataGridView.DataSource = this.motorcycleServicesBindingSource;
            this.motorcycleServicesDataGridView.Location = new System.Drawing.Point(12, 245);
            this.motorcycleServicesDataGridView.MultiSelect = false;
            this.motorcycleServicesDataGridView.Name = "motorcycleServicesDataGridView";
            this.motorcycleServicesDataGridView.ReadOnly = true;
            this.motorcycleServicesDataGridView.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.motorcycleServicesDataGridView.Size = new System.Drawing.Size(570, 220);
            this.motorcycleServicesDataGridView.TabIndex = 2;
            // 
            // dataGridViewTextBoxColumn1
            // 
            this.dataGridViewTextBoxColumn1.DataPropertyName = "ServiceCode";
            this.dataGridViewTextBoxColumn1.HeaderText = "Service Code";
            this.dataGridViewTextBoxColumn1.Name = "dataGridViewTextBoxColumn1";
            this.dataGridViewTextBoxColumn1.ReadOnly = true;
            // 
            // dataGridViewTextBoxColumn2
            // 
            this.dataGridViewTextBoxColumn2.DataPropertyName = "ServiceName";
            this.dataGridViewTextBoxColumn2.HeaderText = "Sevice Name";
            this.dataGridViewTextBoxColumn2.Name = "dataGridViewTextBoxColumn2";
            this.dataGridViewTextBoxColumn2.ReadOnly = true;
            // 
            // dataGridViewTextBoxColumn3
            // 
            this.dataGridViewTextBoxColumn3.DataPropertyName = "Cost";
            this.dataGridViewTextBoxColumn3.HeaderText = "Cost";
            this.dataGridViewTextBoxColumn3.Name = "dataGridViewTextBoxColumn3";
            this.dataGridViewTextBoxColumn3.ReadOnly = true;
            // 
            // motorcycleServicesBindingSource
            // 
            this.motorcycleServicesBindingSource.DataSource = typeof(MotorcyclerRepair.MotorcycleServices);
            this.motorcycleServicesBindingSource.CurrentChanged += new System.EventHandler(this.motorcycleServicesBindingSource_CurrentChanged);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.button4);
            this.groupBox2.Controls.Add(this.button3);
            this.groupBox2.Controls.Add(this.button2);
            this.groupBox2.Controls.Add(this.button1);
            this.groupBox2.Location = new System.Drawing.Point(74, 139);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(446, 100);
            this.groupBox2.TabIndex = 6;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Process";
            // 
            // button4
            // 
            this.button4.Location = new System.Drawing.Point(340, 33);
            this.button4.Name = "button4";
            this.button4.Size = new System.Drawing.Size(75, 35);
            this.button4.TabIndex = 3;
            this.button4.Text = "Cancel";
            this.button4.UseVisualStyleBackColor = true;
            this.button4.Click += new System.EventHandler(this.button4_Click);
            // 
            // button3
            // 
            this.button3.Location = new System.Drawing.Point(238, 33);
            this.button3.Name = "button3";
            this.button3.Size = new System.Drawing.Size(75, 35);
            this.button3.TabIndex = 2;
            this.button3.Text = "Delete";
            this.button3.UseVisualStyleBackColor = true;
            this.button3.Click += new System.EventHandler(this.button3_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(136, 33);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 35);
            this.button2.TabIndex = 1;
            this.button2.Text = "Edit";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(34, 33);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 35);
            this.button1.TabIndex = 0;
            this.button1.Text = "Save";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // ServicesForm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(594, 645);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.motorcycleServicesDataGridView);
            this.Controls.Add(this.groupBox1);
            this.Name = "ServicesForm";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Services";
            this.Load += new System.EventHandler(this.ServicesForm_Load);
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.formBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.motorcycleServicesDataGridView)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.motorcycleServicesBindingSource)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.BindingSource motorcycleServicesBindingSource;
        private System.Windows.Forms.DataGridView motorcycleServicesDataGridView;
        private System.Windows.Forms.TextBox costTextBox;
        private System.Windows.Forms.BindingSource formBindingSource;
        private System.Windows.Forms.TextBox serviceCodeTextBox;
        private System.Windows.Forms.TextBox serviceNameTextBox;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn2;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataGridViewTextBoxColumn3;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button button4;
        private System.Windows.Forms.Button button3;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Button button1;
    }
}