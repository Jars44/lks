"""Model klasifikasi Decision Tree (entropy / information gain) — LKS AI 2025.

Implementasi manual tanpa sklearn. Dipakai bersama oleh main.py, gui.py, dan
main.ipynb (Modul B, C, D).
"""

from __future__ import annotations

from collections import Counter
from pathlib import Path

import numpy as np
import pandas as pd
from numpy import log2

DEFAULT_DATASET = Path(__file__).resolve().parent / "assets" / "dataset.csv"
TARGET = "target"
FEATURE_NAMES = [
    "age",
    "sex",
    "cp",
    "trestbps",
    "chol",
    "fbs",
    "restecg",
    "thalach",
    "exang",
    "oldpeak",
    "slope",
    "ca",
    "thal",
]


class Node:
    __slots__ = ("feature", "threshold", "left", "right", "value", "gain", "n")

    def __init__(
        self,
        feature=None,
        threshold=None,
        left=None,
        right=None,
        value=None,
        gain=0.0,
        n=0,
    ):
        self.feature = feature
        self.threshold = threshold
        self.left = left
        self.right = right
        self.value = value
        self.gain = gain
        self.n = n

    def __repr__(self):
        if self.value is not None:
            return f"Leaf({self.value})"
        return f"Node({self.feature} <= {self.threshold}, n={self.n})"


def entropy(y):
    """Entropy H(y) basis 2."""
    total = len(y)
    if total == 0:
        return 0.0
    result = 0.0
    for count in Counter(y).values():
        p = count / total
        result -= p * log2(p)
    return result


def _entropy_from_counts(counts):
    """Entropy dari vektor jumlah sampel per kelas."""
    total = counts.sum()
    if total == 0:
        return 0.0
    p = counts[counts > 0] / total
    return float(-(p * np.log2(p)).sum())


def find_best_split(X, y):
    """Cari (fitur, threshold, gain) dengan information gain terbesar.

    Tervektorisasi: urutkan nilai tiap fitur, hitung gain semua kandidat
    threshold (titik tengah antar nilai unik) lewat kumulatif per kelas.
    """
    y_arr = np.asarray(y)
    classes = np.unique(y_arr)
    n = len(y_arr)
    parent_entropy = entropy(y_arr)
    best_gain = 0.0
    best_feature = None
    best_threshold = None
    for feature in X.columns:
        vals = X[feature].to_numpy()
        order = np.argsort(vals, kind="stable")
        sv = vals[order]
        sy = y_arr[order]
        uniq, starts = np.unique(sv, return_index=True)
        if len(uniq) < 2:
            continue
        onehot = (sy[:, None] == classes[None, :]).astype(np.float64)
        per_block = np.add.reduceat(onehot, starts, axis=0)
        cum = np.cumsum(per_block, axis=0)
        totals = cum[:, 0] + cum[:, 1] if len(classes) == 2 else cum.sum(axis=1)
        for i in range(len(uniq) - 1):
            left_counts = cum[i]
            left_total = totals[i]
            right_total = n - left_total
            if left_total == 0 or right_total == 0:
                continue
            gain = (
                parent_entropy
                - (left_total / n) * _entropy_from_counts(left_counts)
                - (right_total / n) * _entropy_from_counts(totals[-1] - left_counts)
            )
            if gain > best_gain:
                best_gain = gain
                best_feature = feature
                best_threshold = float((uniq[i] + uniq[i + 1]) / 2.0)
    return best_feature, best_threshold, best_gain


def build_tree(X, y, depth=0, max_depth=8, min_samples_split=4, min_samples_leaf=2):
    """Bangun decision tree rekursif dengan information gain."""
    if len(np.unique(y)) == 1:
        return Node(value=y.iloc[0], n=len(y))
    if depth >= max_depth or len(y) < min_samples_split or X.shape[1] == 0:
        return Node(value=y.mode()[0], n=len(y))
    feature, threshold, gain = find_best_split(X, y)
    if feature is None:
        return Node(value=y.mode()[0], n=len(y))
    mask = X[feature] <= threshold
    left_y, right_y = y[mask], y[~mask]
    if len(left_y) < min_samples_leaf or len(right_y) < min_samples_leaf:
        return Node(value=y.mode()[0], n=len(y))
    left = build_tree(
        X[mask], left_y, depth + 1, max_depth, min_samples_split, min_samples_leaf
    )
    right = build_tree(
        X[~mask], right_y, depth + 1, max_depth, min_samples_split, min_samples_leaf
    )
    return Node(
        feature=feature,
        threshold=threshold,
        left=left,
        right=right,
        gain=gain,
        n=len(y),
    )


def prune(tree):
    """Runtuhkan node internal yang kedua anaknya leaf dengan kelas sama."""
    if tree.value is not None:
        return tree
    tree.left = prune(tree.left)
    tree.right = prune(tree.right)
    if (
        tree.left.value is not None
        and tree.right.value is not None
        and tree.left.value == tree.right.value
    ):
        return Node(value=tree.left.value, n=tree.n)
    return tree


def predict_one(tree, row):
    """Prediksi satu baris (dict atau pandas Series)."""
    node = tree
    while node.value is None:
        node = node.left if row[node.feature] <= node.threshold else node.right
    return node.value


def predict_batch(tree, X):
    """Prediksi seluruh DataFrame fitur."""
    return np.array([predict_one(tree, row) for _, row in X.iterrows()])


def confusion_matrix(y_true, y_pred):
    """Confusion matrix; baris = aktual, kolom = prediksi."""
    classes = sorted(np.unique(np.concatenate((y_true, y_pred))))
    index = {cls: i for i, cls in enumerate(classes)}
    cm = np.zeros((len(classes), len(classes)), dtype=int)
    for true, pred in zip(y_true, y_pred):
        cm[index[true], index[pred]] += 1
    return cm, classes


def accuracy(y_true, y_pred):
    return float(np.mean(np.asarray(y_true) == np.asarray(y_pred)))


def precision_recall_f1(y_true, y_pred):
    """Precision, recall, F1 macro-average per kelas."""
    cm, _ = confusion_matrix(y_true, y_pred)
    precisions, recalls = [], []
    for i in range(len(cm)):
        tp = cm[i, i]
        fp = cm[:, i].sum() - tp
        fn = cm[i, :].sum() - tp
        precisions.append(tp / (tp + fp) if tp + fp else 0.0)
        recalls.append(tp / (tp + fn) if tp + fn else 0.0)
    p = float(np.mean(precisions))
    r = float(np.mean(recalls))
    f1 = 2 * p * r / (p + r) if p + r else 0.0
    return p, r, f1


def train(
    dataset: Path | pd.DataFrame = DEFAULT_DATASET,
    max_depth: int = 5,
    min_samples_split: int = 16,
    min_samples_leaf: int = 8,
):
    """Latih model; kembalikan (tree, metrics). Tidak ada plotting.

    Pembagian 80/20 memakai seed 42 (np.random.shuffle) agar sejajar dengan
    baseline Modul B di main.py.
    """
    df = (
        dataset
        if isinstance(dataset, pd.DataFrame)
        else pd.read_csv(dataset, encoding="utf-8-sig")
    )
    df = df.dropna()
    X = df.drop(columns=[TARGET])
    y = df[TARGET]

    np.random.seed(42)
    indices = np.arange(len(df))
    np.random.shuffle(indices)
    train_size = int(0.8 * len(df))
    train_idx, test_idx = indices[:train_size], indices[train_size:]
    X_train, y_train = X.iloc[train_idx], y.iloc[train_idx]
    X_test, y_test = X.iloc[test_idx], y.iloc[test_idx]

    tree = build_tree(
        X_train,
        y_train,
        max_depth=max_depth,
        min_samples_split=min_samples_split,
        min_samples_leaf=min_samples_leaf,
    )
    tree = prune(tree)
    y_pred = predict_batch(tree, X_test)
    cm, classes = confusion_matrix(y_test, y_pred)
    prec, rec, f1 = precision_recall_f1(y_test, y_pred)
    metrics = {
        "X_train": X_train,
        "y_train": y_train,
        "X_test": X_test,
        "y_test": y_test,
        "y_pred": y_pred,
        "cm": cm,
        "classes": classes,
        "acc": accuracy(y_test, y_pred),
        "prec": prec,
        "rec": rec,
        "f1": f1,
    }
    return tree, metrics


def feature_importances(tree):
    """Importansi fitur = total information gain tertimbang jumlah sampel."""
    total = max(tree.n, 1)
    scores = {}
    stack = [tree]
    while stack:
        node = stack.pop()
        if node.value is not None:
            continue
        scores[node.feature] = (
            scores.get(node.feature, 0.0) + node.gain * node.n / total
        )
        stack.extend((node.left, node.right))
    return dict(sorted(scores.items(), key=lambda kv: -kv[1]))


def print_tree(node, depth=0):
    indent = "  " * depth
    if node.value is not None:
        print(f"{indent}Leaf: {node.value}")
        return
    print(f"{indent}Feature {node.feature} <= {node.threshold}")
    print_tree(node.left, depth + 1)
    print(f"{indent}Feature {node.feature} > {node.threshold}")
    print_tree(node.right, depth + 1)


if __name__ == "__main__":
    tree, m = train()
    print(f"Train size: {len(m['y_train'])}, Test size: {len(m['y_test'])}")
    print(f"Accuracy : {m['acc']:.4f}")
    print(f"Precision: {m['prec']:.4f}")
    print(f"Recall   : {m['rec']:.4f}")
    print(f"F1-Score : {m['f1']:.4f}")
    print("Confusion matrix (baris=aktual, kolom=prediksi):")
    print(m["cm"])
    print("Feature importances:", feature_importances(tree))

    assert m["acc"] >= 0.85, f"akurasi rendah: {m['acc']:.4f}"
    sample = m["X_train"].iloc[0]
    assert predict_one(tree, sample) == m["y_train"].iloc[0]
    for i in (1, 5, 10):
        row = m["X_train"].iloc[i]
        assert predict_one(tree, row) == m["y_train"].iloc[i]
    print("Self-check OK.")
