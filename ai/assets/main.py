import numpy
import pandas as pd
import tkinter
import matplotlib
import seaborn

df = pd.read_excel(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")
df = df.drop_duplicates()
