# Panduan Pengerjaan Modul B, C, dan D - LKS AI Kabupaten Malang 2025

## 📊 Modul B: Data Classification (120 Menit)

### 🎯 Tujuan dan Konsep Teoritis

**Tujuan Utama**: Membangun model klasifikasi menggunakan algoritma Decision Tree untuk memprediksi data baru dengan akurasi optimal melalui implementasi manual dari nol.

**Konsep Decision Tree**: Decision Tree adalah algoritma supervised learning yang membangun struktur pohon keputusan berdasarkan fitur-fitur data. Setiap node internal merepresentasikan tes pada sebuah fitur, setiap cabang merepresentasikan hasil tes, dan setiap leaf node merepresentasikan kelas atau nilai prediksi.

**Prinsip Kerja Dasar**:

- **Root Node**: Node awal yang mewakili seluruh dataset
- **Internal Nodes**: Node yang merepresentasikan fitur pengujian
- **Branches**: Jalur yang menghubungkan node berdasarkan hasil pengujian
- **Leaf Nodes**: Node akhir yang berisi prediksi kelas

**Metrik Penting dalam Decision Tree**:

- **Information Gain**: Mengukur penurunan entropy setelah dataset di-split berdasarkan suatu fitur
- **Entropy**: Mengukur ketidakpastian atau ketidakteraturan dalam dataset
- **Gini Impurity**: Alternatif lain untuk mengukur ketidakteraturan (lebih cepat dihitung)

**Formula Matematis**:

**Entropy Formula**:

```text
Entropy(S) = -Σ (pᵢ × log₂(pᵢ))
```

dimana:

- S = dataset
- pᵢ = proporsi instance milik kelas i
- Σ = penjumlahan untuk semua kelas

**Information Gain Formula**:

```text
Information Gain(S, A) = Entropy(S) - Σ (|Sᵥ|/|S|) × Entropy(Sᵥ)
```

dimana:

- S = dataset parent
- A = fitur kandidat
- Sᵥ = subset data untuk nilai v dari fitur A
- |Sᵥ| = jumlah instance dalam subset
- |S| = jumlah instance dalam dataset parent

**Gini Impurity Formula**:

```text
Gini(S) = 1 - Σ (pᵢ)²
```

### 📝 Strategi dan Langkah-langkah Implementasi Detail

#### 1. Persiapan Data dan Preprocessing

**Langkah 1.1: Load Dataset**

```python
import pandas as pd
import numpy as np

# Load dataset dari file CSV/XLS
df = pd.read_excel('ai/assets/Datasset LKS AI Kabupaten Malang 2025.csv.xls')
print("Dataset shape:", df.shape)
print("Columns:", df.columns.tolist())
print("Sample data:")
print(df.head())
```

**Langkah 1.2: Exploratory Data Analysis (EDA)**

```python
# Cek informasi dataset
print(df.info())

# Cek statistik deskriptif
print(df.describe())

# Cek distribusi kelas target
print(df['target_column'].value_counts())  # Ganti dengan nama kolom target

# Cek missing values
print(df.isnull().sum())
```

**Langkah 1.3: Handle Missing Values**

```python
# Untuk data numerik: isi dengan mean/median
numeric_columns = df.select_dtypes(include=[np.number]).columns
for col in numeric_columns:
    if df[col].isnull().sum() > 0:
        df[col].fillna(df[col].mean(), inplace=True)

# Untuk data kategorikal: isi dengan mode
categorical_columns = df.select_dtypes(include=['object']).columns
for col in categorical_columns:
    if df[col].isnull().sum() > 0:
        df[col].fillna(df[col].mode()[0], inplace=True)
```

**Langkah 1.4: Encoding Categorical Variables**

```python
from sklearn.preprocessing import LabelEncoder

# Encode kolom kategorikal
le = LabelEncoder()
for col in categorical_columns:
    if col != 'target_column':  # Jangan encode target jika sudah numerik
        df[col] = le.fit_transform(df[col])

# Jika target adalah kategorikal
if df['target_column'].dtype == 'object':
    df['target_column'] = le.fit_transform(df['target_column'])
```

**Langkah 1.5: Manual Train-Test Split**

```python
def manual_train_test_split(X, y, test_size=0.2, random_state=42):
    """
    Manual implementation of train-test split
    """
    np.random.seed(random_state)
    indices = np.arange(len(X))
    np.random.shuffle(indices)

    test_count = int(len(X) * test_size)
    test_indices = indices[:test_count]
    train_indices = indices[test_count:]

    X_train = X.iloc[train_indices] if hasattr(X, 'iloc') else X[train_indices]
    X_test = X.iloc[test_indices] if hasattr(X, 'iloc') else X[test_indices]
    y_train = y.iloc[train_indices] if hasattr(y, 'iloc') else y[train_indices]
    y_test = y.iloc[test_indices] if hasattr(y, 'iloc') else y[test_indices]

    return X_train, X_test, y_train, y_test

# Pisahkan features dan target
X = df.drop('target_column', axis=1)  # Ganti dengan nama kolom target
y = df['target_column']

# Split data
X_train, X_test, y_train, y_test = manual_train_test_split(X, y, test_size=0.2)
print(f"Train shape: {X_train.shape}, Test shape: {X_test.shape}")
```

#### 2. Implementasi Manual Decision Tree

**Langkah 2.1: Fungsi Entropy Calculation**

```python
def calculate_entropy(y):
    """
    Menghitung entropy dari dataset
    """
    if len(y) == 0:
        return 0

    # Hitung proporsi setiap kelas
    unique_classes, counts = np.unique(y, return_counts=True)
    probabilities = counts / len(y)

    # Hitung entropy
    entropy = 0
    for p in probabilities:
        if p > 0:  # Hindari log(0)
            entropy -= p * np.log2(p)

    return entropy

# Test entropy calculation
print(f"Entropy of training set: {calculate_entropy(y_train)}")
```

**Langkah 2.2: Fungsi Information Gain**

```python
def calculate_information_gain(X, y, feature):
    """
    Menghitung information gain untuk fitur tertentu
    """
    # Entropy parent
    parent_entropy = calculate_entropy(y)

    # Nilai unik dari fitur
    unique_values = np.unique(X[feature])

    weighted_entropy = 0
    total_samples = len(y)

    for value in unique_values:
        # Subset data untuk nilai tertentu
        subset_indices = X[feature] == value
        subset_y = y[subset_indices]

        # Weighted entropy
        weight = len(subset_y) / total_samples
        subset_entropy = calculate_entropy(subset_y)
        weighted_entropy += weight * subset_entropy

    # Information gain
    information_gain = parent_entropy - weighted_entropy

    return information_gain

# Test information gain untuk semua fitur
feature_gains = {}
for feature in X_train.columns:
    gain = calculate_information_gain(X_train, y_train, feature)
    feature_gains[feature] = gain
    print(f"Information Gain for {feature}: {gain}")

# Fitur terbaik
best_feature = max(feature_gains, key=feature_gains.get)
print(f"Best feature: {best_feature} with gain: {feature_gains[best_feature]}")
```

**Langkah 2.3: Fungsi untuk Mencari Best Split**

```python
def find_best_split(X, y):
    """
    Mencari fitur dengan information gain tertinggi
    """
    best_feature = None
    best_gain = -1

    for feature in X.columns:
        gain = calculate_information_gain(X, y, feature)
        if gain > best_gain:
            best_gain = gain
            best_feature = feature

    return best_feature, best_gain

# Test find best split
best_feat, best_gain_val = find_best_split(X_train, y_train)
print(f"Best split feature: {best_feat}, Gain: {best_gain_val}")
```

**Langkah 2.4: Implementasi Decision Tree Builder**

```python
class DecisionTreeNode:
    def __init__(self, feature=None, value=None, left=None, right=None, prediction=None):
        self.feature = feature      # Fitur untuk split
        self.value = value          # Nilai threshold untuk split
        self.left = left            # Subtree kiri
        self.right = right          # Subtree kanan
        self.prediction = prediction # Prediksi untuk leaf node

def build_decision_tree(X, y, depth=0, max_depth=5):
    """
    Membangun decision tree secara rekursif
    """
    # Kondisi stopping
    if len(np.unique(y)) == 1:  # Semua data memiliki kelas sama
        return DecisionTreeNode(prediction=y.iloc[0])

    if depth >= max_depth:  # Maksimal depth tercapai
        majority_class = y.value_counts().index[0]
        return DecisionTreeNode(prediction=majority_class)

    if len(X.columns) == 0:  # Tidak ada fitur lagi
        majority_class = y.value_counts().index[0]
        return DecisionTreeNode(prediction=majority_class)

    # Cari best split
    best_feature, best_gain = find_best_split(X, y)

    if best_gain == 0:  # Tidak ada gain, buat leaf
        majority_class = y.value_counts().index[0]
        return DecisionTreeNode(prediction=majority_class)

    # Buat node
    node = DecisionTreeNode(feature=best_feature)

    # Split data berdasarkan fitur terbaik
    unique_values = np.unique(X[best_feature])

    if len(unique_values) == 2:  # Binary split
        left_indices = X[best_feature] == unique_values[0]
        right_indices = X[best_feature] == unique_values[1]

        X_left, y_left = X[left_indices], y[left_indices]
        X_right, y_right = X[right_indices], y[right_indices]

        node.left = build_decision_tree(X_left, y_left, depth+1, max_depth)
        node.right = build_decision_tree(X_right, y_right, depth+1, max_depth)
    else:
        # Untuk multi-class, gunakan pendekatan yang berbeda
        # Implementasi sederhana: split berdasarkan median
        median_value = np.median(X[best_feature])
        left_indices = X[best_feature] <= median_value
        right_indices = X[best_feature] > median_value

        X_left, y_left = X[left_indices], y[left_indices]
        X_right, y_right = X[right_indices], y[right_indices]

        node.value = median_value
        node.left = build_decision_tree(X_left, y_left, depth+1, max_depth)
        node.right = build_decision_tree(X_right, y_right, depth+1, max_depth)

    return node

# Build the tree
tree = build_decision_tree(X_train, y_train, max_depth=3)
print("Decision tree built successfully!")
```

**Langkah 2.5: Fungsi Prediction**

```python
def predict_sample(tree, sample):
    """
    Prediksi untuk satu sample
    """
    if tree.prediction is not None:
        return tree.prediction

    feature_value = sample[tree.feature]

    if tree.value is None:  # Categorical split
        if feature_value in [tree.left, tree.right]:  # Need to handle properly
            # Simplified version - assume binary categorical
            return predict_sample(tree.left, sample)
    else:  # Numerical split
        if feature_value <= tree.value:
            return predict_sample(tree.left, sample)
        else:
            return predict_sample(tree.right, sample)

def predict(tree, X):
    """
    Prediksi untuk seluruh dataset
    """
    predictions = []
    for _, sample in X.iterrows():
        pred = predict_sample(tree, sample)
        predictions.append(pred)
    return np.array(predictions)

# Test prediction
y_pred_train = predict(tree, X_train)
y_pred_test = predict(tree, X_test)

print("Predictions completed!")
```

#### 3. Evaluasi Model Sederhana

**Langkah 3.1: Hitung Accuracy**

```python
def calculate_accuracy(y_true, y_pred):
    """
    Menghitung akurasi prediksi
    """
    correct = np.sum(y_true == y_pred)
    total = len(y_true)
    return correct / total

train_accuracy = calculate_accuracy(y_train, y_pred_train)
test_accuracy = calculate_accuracy(y_test, y_pred_test)

print(f"Training Accuracy: {train_accuracy:.4f}")
print(f"Testing Accuracy: {test_accuracy:.4f}")
```

#### 4. Visualisasi dan Interpretasi

**Langkah 4.1: Visualisasi Tree (Text-based)**

```python
def print_tree(node, depth=0, prefix=""):
    """
    Print decision tree dalam format text
    """
    indent = "  " * depth

    if node.prediction is not None:
        print(f"{indent}Leaf: Predict {node.prediction}")
        return

    print(f"{indent}Node: {node.feature}")

    if node.value is not None:
        print(f"{indent}  <= {node.value:.2f}")
        print_tree(node.left, depth+1, "L: ")
        print(f"{indent}  > {node.value:.2f}")
        print_tree(node.right, depth+1, "R: ")
    else:
        print_tree(node.left, depth+1, "L: ")
        print_tree(node.right, depth+1, "R: ")

print("Decision Tree Structure:")
print_tree(tree)
```

**Langkah 4.2: Feature Importance**

```python
def calculate_feature_importance(tree, feature_names):
    """
    Menghitung feature importance berdasarkan gain
    """
    importance = {feature: 0 for feature in feature_names}

    def traverse_tree(node, total_samples):
        if node.prediction is not None or node.feature is None:
            return

        # Hitung gain untuk node ini (perlu disesuaikan dengan implementasi)
        # Simplified version
        importance[node.feature] += 1  # Count usage

        # Traverse children
        traverse_tree(node.left, total_samples)
        traverse_tree(node.right, total_samples)

    traverse_tree(tree, len(X_train))

    # Normalize
    total = sum(importance.values())
    if total > 0:
        for feature in importance:
            importance[feature] /= total

    return importance

feature_importance = calculate_feature_importance(tree, X_train.columns)
print("Feature Importance:")
for feature, imp in sorted(feature_importance.items(), key=lambda x: x[1], reverse=True):
    print(f"{feature}: {imp:.4f}")
```

### 🛠️ Troubleshooting dan Tips

**Common Issues dan Solutions:**

1. **Memory Error pada Dataset Besar**

   - Solusi: Gunakan pandas dengan chunksize atau sample data
   - Alternatif: Implementasi dengan numpy arrays

2. **Overfitting**

   - Solusi: Tambahkan max_depth parameter
   - Tip: Monitor training vs testing accuracy

3. **Categorical Features dengan Banyak Kategori**

   - Solusi: Gunakan one-hot encoding atau grouping
   - Tip: Pilih fitur dengan cardinality rendah

4. **Imbalanced Classes**

   - Solusi: Gunakan weighted entropy atau resampling
   - Tip: Check class distribution sebelum training

5. **Numerical Precision Issues**
   - Solusi: Gunakan epsilon untuk perbandingan floating point
   - Tip: Round values ke decimal tertentu

**Performance Optimization Tips:**

- Gunakan numpy arrays untuk komputasi cepat
- Cache hasil perhitungan entropy
- Implementasi parallel processing untuk feature selection
- Gunakan data structures yang efisien

**Debugging Steps:**

1. Print intermediate values (entropy, gains)
2. Test dengan dataset kecil yang diketahui
3. Visualize tree structure secara bertahap
4. Compare dengan scikit-learn implementation

### ✅ Checklist Modul B (Expanded)

- [ ] Dataset berhasil dimuat dan dianalisis
- [ ] Missing values ditangani dengan benar
- [ ] Categorical variables di-encode
- [ ] Manual train-test split berhasil (80:20)
- [ ] Fungsi entropy calculation bekerja
- [ ] Information gain calculation akurat
- [ ] Decision tree berhasil dibangun
- [ ] Prediction function berfungsi
- [ ] Training dan testing accuracy dihitung
- [ ] Tree structure dapat divisualisasikan
- [ ] Feature importance terhitung
- [ ] Kode bebas dari error dan overfitting
- [ ] Dokumentasi lengkap dengan komentar

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
