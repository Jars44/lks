import numpy as np
import pandas as pd
from numpy import log2
import matplotlib.pyplot as plt
import seaborn as sns
from collections import Counter

df = pd.read_csv(r"ai/assets/Datasset-LKS-AI-Kabupaten-Malang-2025.csv.xls")

# Data Preparation
missing_values = df.isnull().sum()
df = df.dropna() 

features = df.drop(columns=['target']) 
target = df['target']

# EDA
descriptive_stats = df.describe()

print("Dataset information:")
print(f"Dataset shape: {df.shape}")
print(f"Features shape: {features.shape}")
print(f"Target shape: {target.shape}")

print("\nMissing values:")
print(missing_values)

print("\Descriptive statistics:")
print(descriptive_stats)

print("\Target distribution:")
print(target.value_counts())

# Visualization
numerical_features = df.select_dtypes(include=[np.number]).columns.tolist()

if 'target' in numerical_features:
    numerical_features.remove('target')

df[numerical_features].hist(bins=15, figsize=(15, 5))
plt.suptitle('Distribusi Fitur Numerik')
plt.show()

plt.figure(figsize=(12, 10))
correlation_matrix = df.corr()
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt=".2f")
plt.title('Heatmap Korelasi Fitur')
plt.show()

plt.figure(figsize=(6, 4))
sns.countplot(x=target)
plt.title('Target Distribution')
plt.xlabel('Target')
plt.ylabel('Jumlah')
plt.show()

def entropy(df):
    total = len(df)
    counter = Counter(df)
    entrophy = 0

    for jumlah in counter.values():
        p = jumlah / total
        entrophy -= p * log2(p)

    return entrophy

# Data Classification
np.random.seed(42)
indices = np.arange(len(df))
np.random.shuffle(indices)
train_size = int(0.8 * len(df))
train_indices = indices[:train_size]
test_indices = indices[train_size:]
X_train = features.iloc[train_indices]
y_train = target.iloc[train_indices]
X_test = features.iloc[test_indices]
y_test = target.iloc[test_indices]

class Node:
    def __init__(self, feature=None, threshold=None, left=None, right=None, value=None):
        self.feature = feature
        self.threshold = threshold
        self.left = left
        self.right = right
        self.value = value  # For leaf nodes

def find_best_split(X, y):
    best_gain = 0
    best_feature = None
    best_threshold = None
    current_entropy = entropy(y)
    for feature in X.columns:
        thresholds = sorted(X[feature].unique())
        for threshold in thresholds:
            left_y = y[X[feature] <= threshold]
            right_y = y[X[feature] > threshold]
            if len(left_y) == 0 or len(right_y) == 0:
                continue
            gain = current_entropy - (len(left_y) / len(y)) * entropy(left_y) - (len(right_y) / len(y)) * entropy(right_y)
            if gain > best_gain:
                best_gain = gain
                best_feature = feature
                best_threshold = threshold
    return best_feature, best_threshold

def build_tree(X, y, depth=0, max_depth=5):
    if len(np.unique(y)) == 1:
        return Node(value=y.iloc[0])
    if depth >= max_depth or X.shape[1] == 0:
        return Node(value=y.mode()[0])
    best_feature, best_threshold = find_best_split(X, y)
    if best_feature is None:
        return Node(value=y.mode()[0])
    left_indices = X[best_feature] <= best_threshold
    right_indices = X[best_feature] > best_threshold
    left = build_tree(X[left_indices], y[left_indices], depth + 1, max_depth)
    right = build_tree(X[right_indices], y[right_indices], depth + 1, max_depth)
    return Node(feature=best_feature, threshold=best_threshold, left=left, right=right)

tree_root = build_tree(X_train, y_train, max_depth=5)

def print_tree(node, depth=0):
    indent = '  ' * depth
    if node.value is not None:
        print(f'{indent}Leaf: {node.value}')
        return
    print(f'{indent}Feature {node.feature} <= {node.threshold}')
    print_tree(node.left, depth + 1)
    print(f'{indent}Feature {node.feature} > {node.threshold}')
    print_tree(node.right, depth + 1)

print("\nDecision Tree Structure:")
print_tree(tree_root)
