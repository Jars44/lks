# Panduan pengerjaan module b, c, dan d

## 📊 Modul B: Data Classification (120 Menit)

### 🎯 Tujuan

Melakukan klasifikasi data menggunakan algoritma decision tree untuk memprediksi data baru.

### 📝 Langkah-langkah Pengerjaan

#### 1. Persiapan Data

```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

# Load dataset hasil dari Modul A
data = pd.read_csv('dataset_preprocessed.csv')

# Pisahkan fitur dan label
X = data.drop('target_column', axis=1)  # Ganti 'target_column' dengan nama kolom target
y = data['target_column']

# Split data 80% training, 20% testing (manual implementation)
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
    
    X_train = X.iloc[train_indices]
    X_test = X.iloc[test_indices]
    y_train = y.iloc[train_indices]
    y_test = y.iloc[test_indices]
    
    return X_train, X_test, y_train, y_test

X_train, X_test, y_train, y_test = manual_train_test_split(X, y, test_size=0.2, random_state=42)
```

#### 2. Implementasi Decision Tree (Manual)
**Catatan Penting**: Karena scikit-learn tidak termasuk dalam library yang diperbolehkan, peserta perlu mengimplementasikan decision tree secara manual menggunakan numpy dan pandas.

```python
# Implementasi manual decision tree (contoh sederhana)
import numpy as np
import pandas as pd

def manual_decision_tree(X_train, y_train, X_test, max_depth=5):
    """
    Implementasi sederhana decision tree manual
    Ini adalah contoh dasar - peserta perlu mengembangkan sesuai kebutuhan
    """
    # Hitung entropy atau gini untuk setiap fitur
    # Implementasi split criteria manual
    # Bangun pohon secara rekursif
    
    # Contoh sederhana: majority voting untuk klasifikasi
    unique_classes, counts = np.unique(y_train, return_counts=True)
    majority_class = unique_classes[np.argmax(counts)]
    
    # Prediksi sederhana (harus dikembangkan lebih lanjut)
    predictions = [majority_class] * len(X_test)
    
    return predictions

# Gunakan implementasi manual
y_pred = manual_decision_tree(X_train, y_train, X_test)
```

#### 3. Visualisasi Decision Tree (Manual)
```python
# Karena tidak ada scikit-learn, buat visualisasi manual sederhana
import matplotlib.pyplot as plt
import matplotlib.patches as patches

def visualize_manual_tree():
    """
    Visualisasi sederhana struktur decision tree
    Peserta dapat mengembangkan visualisasi yang lebih detail
    """
    fig, ax = plt.subplots(figsize=(10, 6))
    
    # Contoh visualisasi node sederhana
    nodes = [
        ("Root", (0.5, 0.9), "Feature X <= 0.5"),
        ("Left", (0.3, 0.6), "Class A"),
        ("Right", (0.7, 0.6), "Feature Y <= 1.0"),
        ("Right-Left", (0.5, 0.3), "Class B"),
        ("Right-Right", (0.9, 0.3), "Class C")
    ]
    
    for node_name, pos, decision in nodes:
        circle = patches.Circle(pos, 0.05, fill=True, color='lightblue')
        ax.add_patch(circle)
        ax.text(pos[0], pos[1], node_name, ha='center', va='center', fontsize=8)
        ax.text(pos[0], pos[1]-0.07, decision, ha='center', va='center', fontsize=6)
    
    # Tambahkan garis penghubung
    connections = [((0.5, 0.9), (0.3, 0.6)), ((0.5, 0.9), (0.7, 0.6)), 
                  ((0.7, 0.6), (0.5, 0.3)), ((0.7, 0.6), (0.9, 0.3))]
    
    for start, end in connections:
        ax.plot([start[0], end[0]], [start[1], end[1]], 'k-', lw=1)
    
    plt.title("Visualisasi Manual Decision Tree")
    plt.axis('off')
    plt.savefig('manual_decision_tree.png', dpi=300, bbox_inches='tight')
    plt.show()

visualize_manual_tree()
```

#### 4. Penjelasan Matematis (Wajib)
```python
# Hitung importance feature manual (contoh menggunakan information gain)
def calculate_information_gain(X, y, feature):
    """
    Hitung information gain untuk suatu feature secara manual
    """
    # Hitung entropy total
    total_entropy = calculate_entropy(y)
    
    # Hitung entropy untuk setiap nilai feature
    feature_values = X[feature].unique()
    weighted_entropy = 0
    
    for value in feature_values:
        subset_y = y[X[feature] == value]
        weight = len(subset_y) / len(y)
        weighted_entropy += weight * calculate_entropy(subset_y)
    
    information_gain = total_entropy - weighted_entropy
    return information_gain

def calculate_entropy(labels):
    """
    Hitung entropy untuk sekumpulan labels
    """
    from collections import Counter
    counts = Counter(labels)
    probabilities = [count / len(labels) for count in counts.values()]
    entropy = -sum(p * np.log2(p) for p in probabilities if p > 0)
    return entropy

# Hitung information gain untuk semua features
feature_importance = {}
for feature in X.columns:
    ig = calculate_information_gain(X, y, feature)
    feature_importance[feature] = ig

# Urutkan berdasarkan importance
sorted_importance = sorted(feature_importance.items(), key=lambda x: x[1], reverse=True)
print("Feature Importance (Information Gain):")
for feature, importance in sorted_importance:
    print(f"{feature}: {importance:.4f}")
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

#### 1. Evaluasi dengan Confusion Matrix (Manual)
```python
# Implementasi manual confusion matrix
def manual_confusion_matrix(y_true, y_pred, classes):
    """
    Buat confusion matrix secara manual
    """
    cm = np.zeros((len(classes), len(classes)), dtype=int)
    
    # Map classes to indices
    class_to_idx = {cls: idx for idx, cls in enumerate(classes)}
    
    for true, pred in zip(y_true, y_pred):
        true_idx = class_to_idx[true]
        pred_idx = class_to_idx[pred]
        cm[true_idx][pred_idx] += 1
    
    return cm

# Dapatkan classes unik
unique_classes = sorted(np.unique(np.concatenate([y_test, y_pred])))
cm = manual_confusion_matrix(y_test, y_pred, unique_classes)

# Visualisasi manual confusion matrix
plt.figure(figsize=(8,6))
sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', 
            xticklabels=unique_classes, 
            yticklabels=unique_classes)
plt.title('Confusion Matrix (Manual Implementation)')
plt.ylabel('Actual Label')
plt.xlabel('Predicted Label')
plt.savefig('confusion_matrix_manual.png', dpi=300, bbox_inches='tight')
plt.show()
```

#### 2. Hitung Metrik Evaluasi (Manual)
```python
# Hitung accuracy manual
def manual_accuracy(y_true, y_pred):
    correct = sum(1 for true, pred in zip(y_true, y_pred) if true == pred)
    return correct / len(y_true)

accuracy = manual_accuracy(y_test, y_pred)
print(f"Accuracy: {accuracy:.4f}")

# Hitung precision, recall, f1 manual
def manual_classification_report(y_true, y_pred, classes):
    report = {}
    
    for cls in classes:
        # True positives
        tp = sum(1 for true, pred in zip(y_true, y_pred) if true == cls and pred == cls)
        # False positives
        fp = sum(1 for true, pred in zip(y_true, y_pred) if true != cls and pred == cls)
        # False negatives
        fn = sum(1 for true, pred in zip(y_true, y_pred) if true == cls and pred != cls)
        
        precision = tp / (tp + fp) if (tp + fp) > 0 else 0
        recall = tp / (tp + fn) if (tp + fn) > 0 else 0
        f1 = 2 * (precision * recall) / (precision + recall) if (precision + recall) > 0 else 0
        
        report[cls] = {
            'precision': precision,
            'recall': recall,
            'f1-score': f1,
            'support': sum(1 for label in y_true if label == cls)
        }
    
    return report

# Generate manual classification report
report = manual_classification_report(y_test, y_pred, unique_classes)
print("\nManual Classification Report:")
for cls, metrics in report.items():
    print(f"Class {cls}:")
    print(f"  Precision: {metrics['precision']:.4f}")
    print(f"  Recall: {metrics['recall']:.4f}")
    print(f"  F1-Score: {metrics['f1-score']:.4f}")
    print(f"  Support: {metrics['support']}")
```

#### 3. Optimasi Model Manual (Jika Diperlukan)
```python
if accuracy < 0.8:  # Threshold bisa disesuaikan
    print("Melakukan optimasi model manual...")
    
    # Contoh optimasi sederhana: coba threshold yang berbeda untuk splitting
    # Peserta dapat mengembangkan teknik optimasi yang lebih canggih
    
    # Simpan hasil terbaik
    best_accuracy = accuracy
    best_predictions = y_pred
    
    # Coba beberapa strategi sederhana
    strategies = ['majority', 'feature_based', 'random']
    
    for strategy in strategies:
        if strategy == 'majority':
            # Majority voting sederhana
            optimized_pred = [np.bincount(y_train).argmax()] * len(y_test)
        elif strategy == 'feature_based':
            # Berdasarkan feature importance
            # Implementasi sesuai feature yang paling penting
            pass  # Peserta implementasi
        else:
            # Random prediction (baseline)
            optimized_pred = np.random.choice(y_train.unique(), len(y_test))
        
        current_accuracy = manual_accuracy(y_test, optimized_pred)
        
        if current_accuracy > best_accuracy:
            best_accuracy = current_accuracy
            best_predictions = optimized_pred
            print(f"Strategi '{strategy}' meningkatkan accuracy menjadi: {current_accuracy:.4f}")
    
    # Update dengan hasil terbaik
    y_pred = best_predictions
    accuracy = best_accuracy
    print(f"Accuracy akhir setelah optimasi: {accuracy:.4f}")
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

# Simpan parameter model untuk GUI (karena tidak ada scikit-learn)
def save_model_parameters(model_params, filename='model_parameters.txt'):
    """
    Simpan parameter model secara manual
    """
    with open(filename, 'w') as f:
        for key, value in model_params.items():
            f.write(f"{key}: {value}\n")
    print(f"Model parameters saved as '{filename}'")

# Contoh parameter yang perlu disimpan
model_params = {
    'feature_importance': feature_importance,
    'majority_class': np.bincount(y_train).argmax(),
    'training_data_size': len(X_train),
    # Tambahkan parameter lain yang diperlukan
}

save_model_parameters(model_params)
```

#### 2. File Utama untuk Menjalankan GUI

```python
# File: main.py
import joblib
import pandas as pd
from gui_app import run_gui_app

# Load model parameters untuk GUI
def load_model_parameters(filename='model_parameters.txt'):
    """
    Load parameter model secara manual
    """
    params = {}
    with open(filename, 'r') as f:
        for line in f:
            key, value = line.strip().split(': ', 1)
            params[key] = value
    return params

model_params = load_model_parameters()

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
