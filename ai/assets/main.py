import numpy as np
import pandas as pd
import tkinter as tk
import matplotlib as mpl
import seaborn as sbn
from numpy import log2

df = pd.read_csv(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")
# x = df.drop('label', axis=1)
# y = df['label']

total = 10
pA = 8 / total
pB = 2 / total
entropy = - (pA * log2(pA) + pB * log2(pB))

print(entropy)
# def entropy():
#     df = pd.read_csv(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")
#     n = np()


# df["chol"] = df["chol"].split(',', 1, expand=True)
# for x in df.index:
#     if df.loc[x] == ' ':
#         df.replace("missing")
for x in df.index:
    if df.loc[x,"oldpeak"] == '':
        df.loc[x,"oldpeak"] = 0
print(df)