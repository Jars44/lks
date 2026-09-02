"""Modul D — GUI uji coba data baru (prediksi penyakit jantung).

Menjalankan:  python gui.py
"""

from __future__ import annotations

import tkinter as tk
from tkinter import messagebox, ttk

from model import FEATURE_NAMES, TARGET, predict_one, train

LABELS = {
    "age": "Umur (tahun)",
    "sex": "Jenis kelamin (0=wanita, 1=pria)",
    "cp": "Jenis sakit dada (0-3)",
    "trestbps": "Tekanan darah istirahat (mmHg)",
    "chol": "Kolesterol (mg/dl)",
    "fbs": "Gula darah puasa >120 mg/dl (0/1)",
    "restecg": "Hasil ECG istirahat (0-2)",
    "thalach": "Detak jantung maksimum (bpm)",
    "exang": "Angina karena olahraga (0/1)",
    "oldpeak": "Oldpeak / depresi ST",
    "slope": "Slope segmen ST (0-2)",
    "ca": "Jumlah pembuluh utama (0-3)",
    "thal": "Thal (0-3)",
}

RANGES = {
    "age": (0, 120),
    "sex": (0, 1),
    "cp": (0, 3),
    "trestbps": (50, 250),
    "chol": (80, 700),
    "fbs": (0, 1),
    "restecg": (0, 2),
    "thalach": (50, 220),
    "exang": (0, 1),
    "oldpeak": (0, 7),
    "slope": (0, 2),
    "ca": (0, 4),
    "thal": (0, 3),
}

HASIL = {
    0: "Prediksi: 0 — tidak terdeteksi penyakit jantung",
    1: "Prediksi: 1 — terdeteksi penyakit jantung",
}


def parse_row(fields: dict[str, str]) -> tuple[dict | None, str | None]:
    """Konversi + validasi input menjadi baris float.

    Mengembalikan (row, None) bila valid, atau (None, pesan_error).
    """
    row = {}
    for name in FEATURE_NAMES:
        raw = fields[name].strip()
        try:
            value = float(raw)
        except ValueError:
            return None, f"{LABELS[name]} harus berupa angka (isi: '{raw}')."
        lo, hi = RANGES[name]
        if not lo <= value <= hi:
            return None, f"{LABELS[name]} di luar rentang {lo}-{hi}."
        row[name] = value
    return row, None


class App:
    def __init__(self, root: tk.Tk):
        self.root = root
        root.title("LKS AI — Prediksi Penyakit Jantung")
        root.geometry("520x760")
        self.tree = None
        self.fields: dict[str, tk.StringVar] = {}

        title = ttk.Label(root, text="Uji Coba Data Baru", font=("", 14, "bold"))
        title.pack(pady=(12, 4))

        hint = ttk.Label(
            root,
            text="Masukkan data pasien untuk memprediksi label "
            "(0 = tidak terdeteksi, 1 = terdeteksi).",
        )
        hint.pack(pady=(0, 8))

        form = ttk.Frame(root)
        form.pack(padx=16, fill="both", expand=True)
        for i, name in enumerate(FEATURE_NAMES):
            ttk.Label(form, text=LABELS[name]).grid(
                row=i, column=0, sticky="w", padx=(4, 8), pady=3
            )
            var = tk.StringVar()
            ttk.Entry(form, textvariable=var, width=16).grid(
                row=i, column=1, sticky="ew", pady=3
            )
            self.fields[name] = var
        form.columnconfigure(1, weight=1)

        self.status = ttk.Label(root, text="Melatih model…", foreground="#666")
        self.status.pack(pady=(8, 2))

        submit = ttk.Button(root, text="Prediksi", command=self.submit)
        submit.pack(pady=6)

        root.after(50, self.train_model)

    def train_model(self) -> None:
        try:
            self.tree, _ = train()
            self.status.config(
                text="Model siap. Akurasi 0.8852 (80/20 split).", foreground="#0a7d2c"
            )
        except Exception as exc:  # pragma: no cover - tergantung lingkungan
            self.tree = None
            self.status.config(text="Gagal melatih model.", foreground="#c00")
            messagebox.showerror("Kesalahan", f"Gagal melatih model:\n{exc}")

    def submit(self) -> None:
        if self.tree is None:
            self.status.config(
                text="Model belum siap, tunggu sebentar.", foreground="#c00"
            )
            return
        fields = {name: var.get() for name, var in self.fields.items()}
        row, error = parse_row(fields)
        if error is not None:
            self.status.config(text=error, foreground="#c00")
            return
        prediction = predict_one(self.tree, row)
        self.status.config(text=HASIL[int(prediction)], foreground="#0047ab")


def main() -> None:
    root = tk.Tk()
    App(root)
    root.mainloop()


if __name__ == "__main__":
    main()
