import numpy as np
import pandas as pd
from numpy import log2
import matplotlib as mpl
import seaborn as sbn
from collections import Counter

df = pd.read_csv(r"/ai/assets/Datasset LKS AI Kabupaten Malang 2025.csv.xls")

def entropy(df):
    total = len(df)
    counter = Counter(df)
    entrophy = 0

    for jumlah in counter.values():
        p = jumlah / total
        entrophy -= p * log2(p)

    return entrophy

print(f"entropy: {entropy(df)}")