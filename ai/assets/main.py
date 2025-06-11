import numpy
import pandas as pd
import tkinter
import matplotlib
import seaborn

df = pd.read_csv(r"O:\Tugas\lks\ai\assets\Datasset LKS AI Kabupaten Malang 2025.csv.xls")
df = df.drop_duplicates()
# df["chol"] = df["chol"].split(',', 1, expand=True)
# for x in df.index:
#     if df.loc[x] == ' ':
#         df.replace("missing")
for x in df.index:
    if df.loc[x,"oldpeak"] == '':
        df.loc[x,"oldpeak"] = 0
print(df)