import numpy as np
import pandas as pd
from numpy import log2
import tkinter as tk
from tkinter import ttk
from tkinter import Scrollbar, Text, Frame, Pack, Grid, Place
import matplotlib as mpl
import seaborn as sbn
from collections import Counter

df = pd.read_csv(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")

# def entrophy(data):
#     values, counts = np.unique(data, return_counts=True)
#     probs = counts / counts.sum()
#     return -np.sum(probs * np.log2(probs)) 

def entropy(df):
    total = len(df)
    counter = Counter(df)
    entrophy = 0

    for jumlah in counter.values():
        p = jumlah / total
        entrophy -= p * log2(p)

    return entrophy

print(f"entropy: {entropy(df)}")

def gain(data, split_atribute_name, target_name=0):
    total_entropy = entropy(data[target_name])
    vals, counts = np.unique(data[split_atribute_name], return_counts=True)

    weighted_entropy = 0
    for i in range(len(vals)):
        subset = data[data[split_atribute_name] == vals[i]]
        weighted_entropy += (counts[i]/np.sum(counts)) * entropy(subset[target_name])

    return total_entropy - weighted_entropy

def build_tree(data, features, target_name=0):
    target_values = data[target_name]

    if len(np.unique(target_values)) == 1:
        return np.unique(target_values)[0]
    if len(features) == 0:
        return target_values.mode()[0]

    gains = [gain(data, f, target_name) for f in features]
    best_features = features[np.argmax(gains)]

    tree = {best_features: {}}
    for value in np.unique(data[best_features]):
        subset = data[data[best_features] == value].drop(columns=[best_features])
        subtree = build_tree(subset, [f for f in features if f != best_features], target_name)
        tree[best_features][value] = subtree

    return tree

def predict(query, tree):
    for key in query:
        if key in tree:
            try:
                subtree = tree[key][query[key]]
                if isinstance(subtree, dict):
                    return predict(query, subtree)
                else:
                    return subtree
            except:
                return "null"

print(predict(df, 'idk'))


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


window = tk.Tk()
# window.configure()
window.geometry("500x720")
window.title("LKS AI")

input_frame = tk.Text(window, wrap="word")
input_frame.pack(side="left", padx=10, pady=10, fill="both", expand=True)

scrollbar = ttk.Scrollbar(input_frame, orient="vertical", command=input_frame.yview)
scrollbar.pack(side="right", fill="y")

input_frame.config(yscrollcommand=scrollbar.set)

# root = tk.Tk()

# text_area = tk.Text(root, wrap="word", height=10, width=40)
# text_area.pack(side="left", fill="both", expand=True)

# # Create a vertical Scrollbar
# scrollbar = ttk.Scrollbar(root, orient="vertical", command=text_area.yview)
# scrollbar.pack(side="right", fill="y")

# # Configure the Text widget to update the scrollbar
# text_area.config(yscrollcommand=scrollbar.set)

# # Insert some content into the Text widget
# for i in range(50):
#     text_area.insert(tk.END, f"This is line {i+1}\n")

# root.mainloop()
AGE = tk.StringVar()
SEX = tk.StringVar()
CP = tk.StringVar()
TRESTBPS = tk.StringVar()
CHOL = tk.StringVar()
FBS = tk.StringVar()
RESTECG = tk.StringVar()
THALACH = tk.StringVar()
EXANG = tk.StringVar()
OLDPEAK = tk.StringVar()
SLOPE = tk.StringVar()
CA = tk.StringVar()
THAL = tk.StringVar()
TARGET = tk.StringVar()

primary_label = ttk.Label(input_frame, text="kosongkan jika data tidak ada")
primary_label.pack(padx=5, pady=5, fill="x", expand=True)

age = ttk.Label(input_frame, text="masukkan umur:")
age.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=AGE, )
entry.pack(padx=5, fill="x", expand=True)

sex = ttk.Label(input_frame, text="masukkan jenis kelamin:")
sex.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=SEX)
entry.pack(padx=5, fill="x", expand=True)

cp = ttk.Label(input_frame, text="masukkan jenis sakit dada:")
cp.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=CP)
entry.pack(padx=5, fill="x", expand=True)

trestbps = ttk.Label(input_frame, text="masukkan tekanan darah:")
trestbps.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=TRESTBPS)
entry.pack(padx=5, fill="x", expand=True)

chol = ttk.Label(input_frame, text="masukkan kolesterol:")
chol.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=CHOL)
entry.pack(padx=5, fill="x", expand=True)

fbs = ttk.Label(input_frame, text="masukkan gula darah:")
fbs.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=FBS)
entry.pack(padx=5, fill="x", expand=True)

restecg = ttk.Label(input_frame, text="masukkan hasil ECG:")
restecg.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=RESTECG)
entry.pack(padx=5, fill="x", expand=True)

thalach = ttk.Label(input_frame, text="masukkan detak jantung maksimum:")
thalach.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=THALACH)
entry.pack(padx=5, fill="x", expand=True)

exang = ttk.Label(input_frame, text="masukkan angina:")
exang.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=EXANG)
entry.pack(padx=5, fill="x", expand=True)

oldpeak = ttk.Label(input_frame, text="masukkan oldpeak:")
oldpeak.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=OLDPEAK)
entry.pack(padx=5, fill="x", expand=True)

slope = ttk.Label(input_frame, text="masukkan slope:")
slope.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=SLOPE)
entry.pack(padx=5, fill="x", expand=True)

ca = ttk.Label(input_frame, text="masukkan vessel:")
ca.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=CA)
entry.pack(padx=5, fill="x", expand=True)

thal = ttk.Label(input_frame, text="masukkan thal:")
thal.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=THAL)
entry.pack(padx=5, fill="x", expand=True)

target = ttk.Label(input_frame, text="masukkan target:")
target.pack(padx=5, pady=5, fill="x", expand=True)
entry = ttk.Entry(input_frame, textvariable=TARGET)
entry.pack(padx=5, fill="x", expand=True)

def submit_data():
    pass

submit = ttk.Button(input_frame, text="kirim", command=lambda: submit_data())
submit.pack(padx=5, pady=5, fill="x", expand=True)

window.mainloop()