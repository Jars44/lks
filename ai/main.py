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

print("Informasi Dataset:")
print(f"Bentuk dataset: {df.shape}")
print(f"Bentuk Fitur: {features.shape}")
print(f"Bentuk Target: {target.shape}")

print("\nNilai yang Hilang:")
print(missing_values)

print("\nStatistik Deskriptif:")
print(descriptive_stats)

print("\nDistribusi Target:")
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
print(f"\nEntropi Target: {target_entropy}")

# Visualisasi Distribusi Fitur Numerik
numerical_features = ['age', 'trestbps', 'chol']
df[numerical_features].hist(bins=15, figsize=(15, 5))
plt.suptitle('Distribusi Fitur Numerik')
plt.show()

# Visualisasi Korelasi antar Fitur
plt.figure(figsize=(12, 10))
correlation_matrix = df.corr()
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt=".2f")
plt.title('Heatmap Korelasi Fitur')
plt.show()

# Visualisasi Distribusi Target
plt.figure(figsize=(6, 4))
sns.countplot(x=target)
plt.title('Distribusi Target')
plt.xlabel('Target')
plt.ylabel('Jumlah')
