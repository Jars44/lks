"""LKS AI Kabupaten Malang 2025 — Modul A, B, C.

Pipeline: Data Preparation & EDA → Klasifikasi (Decision Tree manual) → Evaluasi Model.
Logika model berada di `model.py`. Modul D (GUI) di `gui.py`.
"""

from __future__ import annotations

import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns

from model import (
    DEFAULT_DATASET,
    TARGET,
    feature_importances,
    print_tree,
    train,
)


def descriptive(df: pd.DataFrame) -> None:
    """Cetak ringkasan dataset (Modul A)."""
    print("Informasi dataset:")
    print(f"  Bentuk: {df.shape}")
    print(f"  Fitur:  {df.shape[1] - 1}")
    print(f"  Target: {TARGET}")
    print("\nNilai kosong per kolom:")
    print(df.isnull().sum().to_string())
    print("\nStatistik deskriptif:")
    print(df.describe().to_string())
    print("\nDistribusi target:")
    print(df[TARGET].value_counts().to_string())


def visualize(df: pd.DataFrame) -> None:
    """Visualisasi Modul A: histogram, heatmap korelasi, distribusi target."""
    numeric = df.select_dtypes(include=[np.number]).columns.tolist()
    if TARGET in numeric:
        numeric.remove(TARGET)

    df[numeric].hist(bins=15, figsize=(15, 5))
    plt.suptitle("Distribusi Fitur Numerik")
    plt.tight_layout()
    plt.show()

    plt.figure(figsize=(12, 10))
    sns.heatmap(df.corr(), annot=True, cmap="coolwarm", fmt=".2f")
    plt.title("Heatmap Korelasi Fitur")
    plt.tight_layout()
    plt.show()

    plt.figure(figsize=(6, 4))
    sns.countplot(x=df[TARGET])
    plt.title("Distribusi Target")
    plt.xlabel("Target")
    plt.ylabel("Jumlah")
    plt.tight_layout()
    plt.show()


def plot_confusion(cm, classes, title="Confusion Matrix"):
    plt.figure(figsize=(8, 6))
    sns.heatmap(
        cm,
        annot=True,
        fmt="d",
        cmap="Blues",
        xticklabels=classes,
        yticklabels=classes,
    )
    plt.title(title)
    plt.xlabel("Prediksi")
    plt.ylabel("Aktual")
    plt.tight_layout()
    plt.show()


def plot_importances(scores: dict, top: int = 10) -> None:
    items = list(scores.items())[:top]
    names = [k for k, _ in items]
    vals = [v for _, v in items]
    plt.figure(figsize=(10, 4))
    sns.barplot(x=vals, y=names, color="#4c72b0")
    plt.title("Feature Importance (information gain)")
    plt.xlabel("Total gain tertimbang jumlah sampel")
    plt.tight_layout()
    plt.show()


def main() -> None:
    df = pd.read_csv(DEFAULT_DATASET, encoding="utf-8-sig")
    df = df.dropna()

    # === Modul A: Persiapan & EDA ===
    descriptive(df)
    visualize(df)

    # === Modul B: Klasifikasi ===
    tree, metrics = train(dataset=df)
    print("\nStruktur pohon keputusan:")
    print_tree(tree)

    # === Modul C: Evaluasi Model ===
    print(f"\nAkurasi  : {metrics['acc']:.4f}")
    print(f"Presisi  : {metrics['prec']:.4f}")
    print(f"Recall   : {metrics['rec']:.4f}")
    print(f"F1-Score : {metrics['f1']:.4f}")
    print("Matriks konfusi (baris=aktual, kolom=prediksi):")
    print(metrics["cm"])
    plot_confusion(metrics["cm"], metrics["classes"])
    plot_importances(feature_importances(tree))


if __name__ == "__main__":
    main()
