import numpy as np
import pandas as pd
import tkinter as tk
from tkinter import ttk
import matplotlib as mpl
import seaborn as sbn
from numpy import log2

df = pd.read_csv(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")
# x = df.drop('label', axis=1)
# y = df['label']

# total = 10
# pA = 8 / total
# pB = 2 / total
# entropy = - (pA * log2(pA) + pB * log2(pB))

# print(entropy)
# def entropy():
#     df = pd.read_csv(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")
#     n = np()


# age = df["age"]
# # sex = df["sex"] = ["female" if x == 0 else x for x in df.sex]
# # sex = df["sex"] = ["male" if x == 1 else x for x in df.sex]
# # df = df["sex"].replace(to_replace=0, value="female")
# # df = df["sex"].replace(to_replace=1, value="male")
# df = df["sex"].apply(lambda x: "female" if x == 0 else "male")
# df = df["fbs"].apply(lambda x: "false" if x == 0 else "true")
# df = df["exang"].apply(lambda x: "no" if x == 0 else "yes")
# df = df["target"].apply(lambda x: "no disease" if x == 0 else "disease")
# # print(sex)
# print(df)

# print(df["sex"].replace(1, "male"))
# print(df["sex"].replace(0, "female"))

# df["chol"] = df["chol"].split(',', 1, expand=True)
# for x in df.index:
#     if df.loc[x] == ' ':
#         df.replace("missing")

# for x in df.index:
#     if df.loc[x,"oldpeak"] == '':
#         df.loc[x,"oldpeak"] = 0
# print(df)
ALOK = tk.StringVar()

window = tk.Tk()
# window.configure()
window.geometry("500x400")
window.resizable(False, False)
window.title("LKS AI")

input_frame = ttk.Frame(window)
input_frame.pack(padx=10, pady=10, fill="x", expand=True)

age = ttk.Label(input_frame, text="masukkan umur:")
age.pack(padx=10, pady=10, fill="x", expand=True)

sex = ttk.Label(input_frame, text="masukkan jenis kelamin:")
sex.pack(padx=10, pady=10, fill="x", expand=True)

cp = ttk.Label(input_frame, text="masukkan jenis sakit dada:")
cp.pack(padx=10, pady=10, fill="x", expand=True)

trestbps = ttk.Label(input_frame, text="masukkan tekanan darah:")
trestbps.pack(padx=10, pady=10, fill="x", expand=True)

chol = ttk.Label(input_frame, text="masukkan kolesterol:")
chol.pack(padx=10, pady=10, fill="x", expand=True)

fbs = ttk.Label(input_frame, text="masukkan gula darah:")
fbs.pack(padx=10, pady=10, fill="x", expand=True)

restecg = ttk.Label(input_frame, text="masukkan hasil ECG:")
restecg.pack(padx=10, pady=10, fill="x", expand=True)

thalach = ttk.Label(input_frame, text="masukkan detak jantung maksimum:")
thalach.pack(padx=10, pady=10, fill="x", expand=True)

exang = ttk.Label(input_frame, text="masukkan angina:")
exang.pack(padx=10, pady=10, fill="x", expand=True)

oldpeak = ttk.Label(input_frame, text="masukkan oldpeak:")
oldpeak.pack(padx=10, pady=10, fill="x", expand=True)

slope = ttk.Label(input_frame, text="masukkan slope:")
slope.pack(padx=10, pady=10, fill="x", expand=True)

ca = ttk.Label(input_frame, text="masukkan kolesterol:")
ca.pack(padx=10, pady=10, fill="x", expand=True)

thal = ttk.Label(input_frame, text="masukkan thal:")
thal.pack(padx=10, pady=10, fill="x", expand=True)

target = ttk.Label(input_frame, text="masukkan target:")
target.pack(padx=10, pady=10, fill="x", expand=True)

entry = ttk.Entry(input_frame, textvariable=ALOK)
entry.pack(padx=10, pady=10, fill="x", expand=True)

window.mainloop()