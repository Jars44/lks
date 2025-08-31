# Panduan Pengerjaan Modul B, C, dan D - LKS AI Kabupaten Malang 2025

## 📊 Modul B: Data Classification (120 Menit)

### 🎯 Tujuan dan Konsep Teoritis

**Tujuan Utama**: Membangun model klasifikasi menggunakan algoritma Decision Tree untuk memprediksi data baru dengan akurasi optimal.

**Konsep Decision Tree**: Decision Tree adalah algoritma supervised learning yang membangun struktur pohon keputusan berdasarkan fitur-fitur data. Setiap node internal merepresentasikan tes pada sebuah fitur, setiap cabang merepresentasikan hasil tes, dan setiap leaf node merepresentasikan kelas atau nilai prediksi.

**Prinsip Kerja**:

- **Information Gain**: Mengukur penurunan entropy setelah dataset di-split berdasarkan suatu fitur
- **Entropy**: Mengukur ketidakpastian atau ketidakteraturan dalam dataset
- **Gini Impurity**: Alternatif lain untuk mengukur ketidakteraturan

### 📝 Strategi dan Langkah-langkah Implementasi

#### 1. Persiapan Data dan Preprocessing

**Konsep Split Data**: Pembagian dataset menjadi training (80%) dan testing (20%) sangat penting untuk evaluasi model yang objektif. Training set digunakan untuk membangun model, sedangkan testing set digunakan untuk menguji performa model pada data yang belum pernah dilihat.

**Implementasi Kunci**:

```python
# Contoh implementasi manual train-test split
def manual_train_test_split(X, y, test_size=0.2, random_state=42):
    np.random.seed(random_state)
    indices = np.arange(len(X))
    np.random.shuffle(indices)
    test_count = int(len(X) * test_size)
    # ... (implementasi lengkap)
```

#### 2. Implementasi Manual Decision Tree

**Algoritma Inti**: Decision Tree bekerja dengan memilih fitur yang memberikan information gain tertinggi pada setiap langkah splitting. Proses ini berlanjut secara rekursif hingga kriteria stopping terpenuhi.

**Strategi Splitting**:

- Hitung information gain untuk setiap fitur
- Pilih fitur dengan gain tertinggi sebagai node splitting
- Ulangi proses untuk subset data yang dihasilkan

**Pseudocode Implementasi**:

```python
def build_tree(data, depth=0):
    if stopping_criteria_met(data, depth):
        return leaf_node(majority_class(data))

    best_feature = find_best_split(data)
    tree = {best_feature: {}}

    for each value in best_feature_values:
        subset = data[data[best_feature] == value]
        tree[best_feature][value] = build_tree(subset, depth+1)

    return tree
```

#### 3. Visualisasi dan Interpretasi

**Pentingnya Visualisasi**: Visualisasi Decision Tree membantu memahami bagaimana model membuat keputusan dan memvalidasi logika klasifikasi.

**Elemen Visual yang Penting**:

- Node decision dengan kondisi splitting
- Leaf nodes dengan kelas prediksi
- Depth dan complexity tree
- Feature importance visualization

#### 4. Analisis Matematis dan Feature Importance

**Information Gain Calculation**:

```text
Information Gain = Entropy(parent) - Weighted Average × Entropy(children)
```

**Entropy Formula**:

```text
Entropy(S) = -Σ pᵢ × log₂(pᵢ)
```

dimana pᵢ adalah proporsi instance milik kelas i

**Interpretasi Feature Importance**: Fitur dengan information gain tinggi memiliki pengaruh lebih besar dalam proses klasifikasi dan sebaiknya diprioritaskan dalam analisis.

### ✅ Checklist Modul B

- [ ] Data berhasil di-split 80:20
- [ ] Model decision tree ter-training
- [ ] Visualisasi pohon keputusan tersimpan
- [ ] Feature importance terhitung
- [ ] Penjelasan matematis tersedia (jika ada waktu)

---

## 📈 Modul C: Evaluasi Model (60 Menit)

### 🎯 Tujuan dan Konsep Evaluasi

**Tujuan Utama**: Mengevaluasi performa model klasifikasi menggunakan berbagai metrik evaluasi dan melakukan optimasi jika diperlukan untuk meningkatkan akurasi prediksi.

**Konsep Evaluasi Model**: Evaluasi model bertujuan untuk mengukur seberapa baik model dapat melakukan prediksi pada data yang belum pernah dilihat sebelumnya. Proses ini penting untuk menghindari overfitting dan memastikan model dapat digeneralisasi dengan baik.

### 📝 Strategi dan Metrik Evaluasi

#### 1. Confusion Matrix Analysis

**Konsep Confusion Matrix**: Matriks yang menampilkan perbandingan antara nilai aktual dan prediksi dalam bentuk empat kuadran:

- **True Positive (TP)**: Prediksi benar positif
- **True Negative (TN)**: Prediksi benar negatif
- **False Positive (FP)**: Prediksi salah positif (Type I Error)
- **False Negative (FN)**: Prediksi salah negatif (Type II Error)

**Interpretasi Visual**: Heatmap confusion matrix membantu mengidentifikasi pola kesalahan klasifikasi dan kelas-kelas yang sulit dibedakan.

**Implementasi Inti**:

```python
def manual_confusion_matrix(y_true, y_pred, classes):
    cm = np.zeros((len(classes), len(classes)), dtype=int)
    class_to_idx = {cls: idx for idx, cls in enumerate(classes)}
    for true, pred in zip(y_true, y_pred):
        true_idx = class_to_idx[true]
        pred_idx = class_to_idx[pred]
        cm[true_idx][pred_idx] += 1
    return cm
```

#### 2. Metrik Evaluasi Komprehensif

**Accuracy**: Proporsi prediksi yang benar dari total prediksi

```text
Accuracy = (TP + TN) / (TP + TN + FP + FN)
```

**Precision**: Proporsi prediksi positif yang benar

```text
Precision = TP / (TP + FP)
```

**Recall (Sensitivity)**: Proporsi actual positif yang terprediksi benar

```text
Recall = TP / (TP + FN)
```

**F1-Score**: Harmonic mean dari precision dan recall

```text
F1-Score = 2 × (Precision × Recall) / (Precision + Recall)
```

**Support**: Jumlah instance actual untuk setiap kelas

#### 3. Strategi Optimasi Model

**Konsep Optimasi**: Proses meningkatkan performa model melalui berbagai teknik seperti:

- **Hyperparameter Tuning**: Menyesuaikan parameter model
- **Feature Engineering**: Memilih atau membuat fitur yang lebih informatif
- **Algorithm Selection**: Memilih algoritma yang lebih sesuai dengan data

**Threshold Optimization**: Menyesuaikan batas keputusan untuk menyeimbangkan precision dan recall berdasarkan kebutuhan aplikasi.

### ✅ Checklist Modul C

- [ ] Confusion matrix terhitung dan tervisualisasi
- [ ] Accuracy score terhitung
- [ ] Classification report lengkap
- [ ] Optimasi model dilakukan (jika diperlukan)
- [ ] Model final tersimpan

---

## 🖥 Modul D: GUI untuk Uji Coba Data Baru (120 Menit)

### 🎯 Tujuan dan Prinsip Desain GUI

**Tujuan Utama**: Membangun antarmuka pengguna grafis yang intuitif dan user-friendly untuk menguji model prediksi dengan data baru.

**Prinsip Desain GUI yang Penting**:

- **Usability**: Antarmuka harus mudah digunakan dan dipahami oleh pengguna akhir
- **Responsiveness**: Aplikasi harus merespons input pengguna dengan cepat dan memberikan feedback visual
- **Error Handling**: Penanganan kesalahan yang robust untuk input tidak valid
- **Visual Consistency**: Konsistensi dalam tata letak, warna, dan font untuk pengalaman pengguna yang baik

### 📝 Strategi Implementasi GUI

#### 1. Arsitektur Aplikasi GUI

**Struktur Modular**: Pisahkan kode GUI menjadi komponen-komponen yang terorganisir:

- **Main Application Class**: Kelas utama yang mengatur window dan layout utama
- **Input Components**: Komponen untuk menerima input numerik dari pengguna
- **Prediction Logic**: Logika untuk memproses input dan menghasilkan prediksi
- **Result Display**: Komponen untuk menampilkan hasil prediksi dan confidence level

**Pattern MVC (Model-View-Controller)**:

- **Model**: Data dan logika bisnis (model machine learning yang sudah ditraining)
- **View**: Tampilan GUI (Tkinter widgets dan layout)
- **Controller**: Menghubungkan view dengan model dan menangani event handling

#### 2. Komponen GUI Esensial

**Dynamic Input Fields**: Membuat input field secara dinamis berdasarkan fitur dataset

```python
# Contoh pembuatan input field dinamis
for feature in feature_columns:
    label = tk.Label(frame, text=f"{feature}:")
    entry = tk.Entry(frame)
    self.input_fields[feature] = entry
```

**Action Buttons**: Tombol untuk memicu prediksi dan reset form

```python
predict_btn = tk.Button(frame, text="PREDIKSI", command=self.predict)
clear_btn = tk.Button(frame, text="BERSIHKAN", command=self.clear_fields)
```

**Result Display Area**: Widget untuk menampilkan hasil prediksi dan tingkat kepercayaan

#### 3. Validasi Input dan Error Handling

**Input Validation**: Memastikan input berupa angka yang valid dan sesuai range

```python
try:
    value = float(entry.get())
    if value is None or math.isnan(value):
        raise ValueError("Input tidak valid")
except ValueError:
    messagebox.showerror("Error", "Harap masukkan angka yang valid")
```

**Comprehensive Error Handling**: Menangani berbagai jenis exception termasuk:

- Input kosong atau tidak lengkap
- Format angka tidak valid
- Kesalahan dalam proses prediksi
- File model tidak ditemukan

#### 4. Integrasi dengan Model Machine Learning

**Model Serialization**: Menyimpan parameter model untuk digunakan di GUI

```python
def save_model_parameters(params, filename):
    with open(filename, 'w') as f:
        for key, value in params.items():
            f.write(f"{key}: {value}\n")
```

**Prediction Integration**: Mengintegrasikan model dengan GUI untuk prediksi real-time

```python
def predict_from_input(self, input_data):
    # Preprocess input data
    processed_data = self.preprocess(input_data)
    # Make prediction using trained model
    prediction = self.model.predict(processed_data)
    confidence = self.model.predict_proba(processed_data)
    return prediction, confidence
```

### ✅ Checklist Modul D

- [ ] GUI aplikasi berhasil dibuat dengan layout yang rapi
- [ ] Input fields untuk semua fitur yang diperlukan
- [ ] Tombol prediksi berfungsi dengan baik
- [ ] Hasil prediksi ditampilkan dengan jelas
- [ ] Tingkat kepercayaan (confidence) ditampilkan
- [ ] Tombol clear/reset berfungsi
- [ ] Error handling implementasi untuk input tidak valid
- [ ] Model tersimpan dalam format yang dapat digunakan GUI

---

## 💡 Tips dan Strategi

### ⏰ Manajemen Waktu

- **Modul B (120 menit)**: Alokasi 90 menit coding, 30 menit dokumentasi
- **Modul C (60 menit)**: Alokasi 40 menit evaluasi, 20 menit optimasi
- **Modul D (120 menit)**: Alokasi 100 menit coding GUI, 20 menit testing

### 🚀 Tips Coding

1. **Gunakan Comment** yang jelas untuk setiap langkah
2. **Simpan File** secara berkala dengan nama yang berbeda
3. **Test secara Incremental** - jangan tunggu sampai selesai semua
4. **Backup Code** di external storage atau cloud

### 🎯 Penilaian

- **Modul B (40 points)**: Implementasi decision tree yang benar
- **Modul C (20 points)**: Evaluasi model yang akurat
- **Modul D (30 points)**: GUI yang functional dan user-friendly

### 🆘 Troubleshooting Common Issues

```python
# Jika ada error import, pastikan library terinstall
try:
    import sklearn
except ImportError:
    print("Install scikit-learn: pip install scikit-learn")

# Jika GUI tidak muncul, pastikan Tkinter terinstall
try:
    import tkinter
except ImportError:
    print("Tkinter mungkin perlu diinstall terpisah")
```

---

## 📁 Struktur File Final

```!/bin/bash
project_folder/
├── dataset_preprocessed.csv
├── decision_tree_visualization.png
├── confusion_matrix.png
├── trained_model.pkl
├── main.py
├── gui_app.py
├── requirements.txt
└── README.md (documentation)
```

**Selamat Bertanding!** 🎉 Semoga sukses dalam LKS AI Kabupaten Malang 2025!
