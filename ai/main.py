import numpy as np
import pandas as pd
from numpy import log2
import tkinter as tk
from tkinter import ttk
from tkinter import Scrollbar, Text, Frame, Pack, Grid, Place
import matplotlib as mpl
import seaborn as sbn

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

window = tk.Tk()
# window.configure()
window.geometry("500x720")
window.title("LKS AI")

input_frame = ttk.Frame(window)
input_frame.pack(padx=10, pady=10, fill="x", expand=True)

class scrollBar(Text):
    def __init__(self, master=None, **kw):
        self.frame = Frame(input_frame)
        self.vbar = Scrollbar(self.frame)
        self.vbar.pack(side="right", fill="y")
        
        kw.update({"yscrollcommand": self.vbar.set})
        Text.__init__(self, self.frame, **kw)
        self.pack(side="left", fill="both", expand=True)
        self.vbar["command"] = self.yview
        
        text_meths = vars(Text).keys()
        methods = vars(Pack).keys() | vars(Grid).keys() | vars(Place).keys()
        methods = methods.difference(text_meths)

        for m in methods:
            if m[0] != '_' and m != 'config' and m != 'configure':
                setattr(self, m, getattr(self.frame, m))

    def __str__(self):
        return str(self.frame)

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

primary_label = ttk.Label(input_frame, text="kosongkan jika tidak ada data")
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