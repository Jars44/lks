import numpy as np
import pandas as pd
from numpy import log2
import matplotlib.pyplot as plt
import seaborn as sns
from collections import Counter

df = pd.read_csv(r"ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")

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

print("\Descirptive statistics:")
print(descriptive_stats)

print("\Target distribution:")
print(target.value_counts())

def entropy(df):
    total = len(df)
    counter = Counter(df)
    entrophy = 0

    for jumlah in counter.values():
        p = jumlah / total
        entrophy -= p * log2(p)

    return entrophy

target_entropy = entropy(target)
print(f"Target entropy: {target_entropy}")

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