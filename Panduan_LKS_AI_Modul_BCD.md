# Panduan Teknis LKS AI Kabupaten Malang 2025 - Modul B, C, dan D

## 📋 Daftar Isi

- [Prasyarat Teknis](#-prasyarat-teknis)
- [Modul B: Data Classification](#-modul-b-data-classification)
- [Modul C: Evaluasi Model](#-modul-c-evaluasi-model)
- [Modul D: GUI untuk Uji Coba Data Baru](#-modul-d-gui-untuk-uji-coba-data-baru)
- [Tips dan Strategi](#-tips-dan-strategi)

---

## 🛠 Prasyarat Teknis

### Software yang Diperlukan:

- **Python 3.9+**
- **Visual Studio Code** (IDE yang disarankan)
- **Anaconda** (opsional, untuk package management)
- **Jupyter Notebook** (opsional)

### Library Python yang Diperbolehkan:

```bash
pip install numpy pandas scikit-learn matplotlib seaborn tkinter
```

### Spesifikasi Hardware Minimal:

- Processor: Intel i5 atau setara
- RAM: 8GB
- Storage: 500GB
- OS: Windows 10 atau lebih baru

---

## 📊 Modul B: Data Classification (120 Menit)

### 🎯 Tujuan

Melakukan klasifikasi data menggunakan algoritma decision tree untuk memprediksi data baru.

### 📝 Langkah-langkah Pengerjaan

#### 1. Persiapan Data

```python
import pandas as pd
import numpy as np
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn import tree
import matplotlib.pyplot as plt

# Load dataset hasil dari Modul A
data = pd.read_csv('dataset_preprocessed.csv')

# Pisahkan fitur dan label
X = data.drop('target_column', axis=1)  # Ganti 'target_column' dengan nama kolom target
y = data['target_column']

# Split data 80% training, 20% testing
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
```

#### 2. Implementasi Decision Tree

```python
# Buat model decision tree dengan parameter optimal
model = DecisionTreeClassifier(
    max_depth=5,           # Batas kedalaman pohon
    min_samples_split=2,   # Minimal sampel untuk split
    min_samples_leaf=1,    # Minimal sampel di leaf node
    random_state=42,       # Untuk reproducibility
    criterion='gini'       # Kriteria split: 'gini' atau 'entropy'
)

# Train model
model.fit(X_train, y_train)

# Prediksi pada data test
y_pred = model.predict(X_test)
```

#### 3. Visualisasi Decision Tree

```python
# Visualisasi pohon keputusan
plt.figure(figsize=(20,10))
tree.plot_tree(model,
               feature_names=X.columns,
               class_names=[str(x) for x in model.classes_],
               filled=True,
               rounded=True,
               proportion=True)
plt.title("Visualisasi Decision Tree")
plt.savefig('decision_tree_visualization.png', dpi=300, bbox_inches='tight')
plt.show()
```

#### 4. Penjelasan Matematis (Opsional untuk Bonus)

```python
# Hitung importance feature
feature_importance = pd.DataFrame({
    'feature': X.columns,
    'importance': model.feature_importances_
}).sort_values('importance', ascending=False)

print("Feature Importance:")
print(feature_importance)
```

### ✅ Checklist Modul B

- [ ] Data berhasil di-split 80:20
- [ ] Model decision tree ter-training
- [ ] Visualisasi pohon keputusan tersimpan
- [ ] Feature importance terhitung
- [ ] Penjelasan matematis tersedia (jika ada waktu)

---

## 📈 Modul C: Evaluasi Model (60 Menit)

### 🎯 Tujuan

Mengevaluasi model klasifikasi menggunakan confusion matrix dan metrik evaluasi.

### 📝 Langkah-langkah Pengerjaan

#### 1. Evaluasi dengan Confusion Matrix

```python
from sklearn.metrics import confusion_matrix, classification_report, accuracy_score
import seaborn as sns

# Hitung confusion matrix
cm = confusion_matrix(y_test, y_pred)

# Visualisasi confusion matrix
plt.figure(figsize=(8,6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues',
            xticklabels=model.classes_,
            yticklabels=model.classes_)
plt.title('Confusion Matrix')
plt.ylabel('Actual Label')
plt.xlabel('Predicted Label')
plt.savefig('confusion_matrix.png', dpi=300, bbox_inches='tight')
plt.show()
```

#### 2. Hitung Metrik Evaluasi

```python
# Hitung accuracy
accuracy = accuracy_score(y_test, y_pred)
print(f"Accuracy: {accuracy:.4f}")

# Classification report lengkap
print("\nClassification Report:")
print(classification_report(y_test, y_pred))

# Hitung metrik manual
precision = cm[1,1] / (cm[1,1] + cm[0,1]) if (cm[1,1] + cm[0,1]) > 0 else 0
recall = cm[1,1] / (cm[1,1] + cm[1,0]) if (cm[1,1] + cm[1,0]) > 0 else 0
f1 = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0

print(f"Precision: {precision:.4f}")
print(f"Recall: {recall:.4f}")
print(f"F1-Score: {f1:.4f}")
```

#### 3. Optimasi Model (Jika Diperlukan)

```python
if accuracy < 0.8:  # Threshold bisa disesuaikan
    print("Melakukan optimasi model...")

    # Coba hyperparameter tuning
    model_optimized = DecisionTreeClassifier(
        max_depth=7,
        min_samples_split=5,
        min_samples_leaf=2,
        random_state=42
    )

    model_optimized.fit(X_train, y_train)
    y_pred_optimized = model_optimized.predict(X_test)
    accuracy_optimized = accuracy_score(y_test, y_pred_optimized)

    print(f"Accuracy sebelum optimasi: {accuracy:.4f}")
    print(f"Accuracy setelah optimasi: {accuracy_optimized:.4f}")

    # Update model jika lebih baik
    if accuracy_optimized > accuracy:
        model = model_optimized
        y_pred = y_pred_optimized
        accuracy = accuracy_optimized
```

### ✅ Checklist Modul C

- [ ] Confusion matrix terhitung dan tervisualisasi
- [ ] Accuracy score terhitung
- [ ] Classification report lengkap
- [ ] Optimasi model dilakukan (jika diperlukan)
- [ ] Model final tersimpan

---

## 🖥 Modul D: GUI untuk Uji Coba Data Baru (120 Menit)

### 🎯 Tujuan

Membuat GUI sederhana untuk input data baru dan menampilkan hasil prediksi.

### 📝 Langkah-langkah Pengerjaan

#### 1. Setup GUI dengan Tkinter

```python
import tkinter as tk
from tkinter import ttk, messagebox
import pandas as pd
import numpy as np

class PredictionApp:
    def __init__(self, root, model, feature_columns):
        self.root = root
        self.model = model
        self.feature_columns = feature_columns
        self.root.title("Sistem Prediksi AI - LKS Malang 2025")
        self.root.geometry("600x500")
        self.root.configure(bg='#f0f0f0')

        self.create_widgets()

    def create_widgets(self):
        # Title
        title_label = tk.Label(self.root, text="SISTEM PREDIKSI DATA BARU",
                              font=("Arial", 16, "bold"), bg='#f0f0f0', fg='#2c3e50')
        title_label.pack(pady=20)

        # Input frame
        input_frame = tk.Frame(self.root, bg='#f0f0f0')
        input_frame.pack(pady=10)

        self.input_fields = {}
        for i, feature in enumerate(self.feature_columns):
            row_frame = tk.Frame(input_frame, bg='#f0f0f0')
            row_frame.pack(fill="x", padx=20, pady=5)

            label = tk.Label(row_frame, text=f"{feature}:", width=20,
                           anchor="w", bg='#f0f0f0', font=("Arial", 10))
            label.pack(side="left")

            entry = tk.Entry(row_frame, width=20, font=("Arial", 10))
            entry.pack(side="left", padx=10)
            self.input_fields[feature] = entry

        # Button frame
        button_frame = tk.Frame(self.root, bg='#f0f0f0')
        button_frame.pack(pady=20)

        predict_btn = tk.Button(button_frame, text="PREDIKSI",
                               command=self.predict,
                               bg="#3498db", fg="white",
                               font=("Arial", 12, "bold"),
                               padx=20, pady=10)
        predict_btn.pack(side="left", padx=10)

        clear_btn = tk.Button(button_frame, text="BERSIHKAN",
                             command=self.clear_fields,
                             bg="#e74c3c", fg="white",
                             font=("Arial", 12, "bold"),
                             padx=20, pady=10)
        clear_btn.pack(side="left", padx=10)

        # Result frame
        result_frame = tk.Frame(self.root, bg='#f0f0f0')
        result_frame.pack(pady=20)

        self.result_label = tk.Label(result_frame, text="Hasil Prediksi: -",
                                    font=("Arial", 14, "bold"), bg='#f0f0f0', fg='#27ae60')
        self.result_label.pack()

        self.confidence_label = tk.Label(result_frame, text="Tingkat Kepercayaan: -",
                                       font=("Arial", 12), bg='#f0f0f0')
        self.confidence_label.pack()

    def predict(self):
        try:
            # Collect input values
            input_data = []
            for feature in self.feature_columns:
                value = self.input_fields[feature].get()
                if not value:
                    messagebox.showerror("Error", f"Harap isi field {feature}")
                    return
                input_data.append(float(value))

            # Convert to numpy array and reshape
            input_array = np.array(input_data).reshape(1, -1)

            # Make prediction
            prediction = self.model.predict(input_array)[0]
            probability = np.max(self.model.predict_proba(input_array))

            # Display results
            self.result_label.config(text=f"Hasil Prediksi: {prediction}")
            self.confidence_label.config(text=f"Tingkat Kepercayaan: {probability:.2%}")

        except ValueError:
            messagebox.showerror("Error", "Harap masukkan angka yang valid")
        except Exception as e:
            messagebox.showerror("Error", f"Terjadi kesalahan: {str(e)}")

    def clear_fields(self):
        for entry in self.input_fields.values():
            entry.delete(0, tk.END)
        self.result_label.config(text="Hasil Prediksi: -")
        self.confidence_label.config(text="Tingkat Kepercayaan: -")

# Main function to run the app
def run_gui_app(model, feature_columns):
    root = tk.Tk()
    app = PredictionApp(root, model, feature_columns)
    root.mainloop()

# Save model for GUI
import joblib
joblib.dump(model, 'trained_model.pkl')
print("Model saved as 'trained_model.pkl'")
```

#### 2. File Utama untuk Menjalankan GUI

```python
# File: main.py
import joblib
import pandas as pd
from gui_app import run_gui_app

# Load trained model
model = joblib.load('trained_model.pkl')

# Load dataset to get feature names
data = pd.read_csv('dataset_preprocessed.csv')
feature_columns = data.drop('target_column', axis=1).columns.tolist()

print("Starting GUI Application...")
run_gui_app(model, feature_columns)
```

### ✅ Checklist Modul D

- [ ] GUI aplikasi berhasil dibuat
- [ ] Input fields untuk semua fitur
- [ ] Tombol prediksi berfungsi
- [ ] Hasil prediksi ditampilkan
- [ ] Tingkat kepercayaan ditampilkan
- [ ] Tombol clear berfungsi
- [ ] Error handling implementasi
- [ ] Model tersimpan dalam format .pkl

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

```
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
