# -*- encoding: utf-8 -*-
#@Author  :   Arthals
#@File    :   temp.py
#@Time    :   2022/11/18 11:32:46
#@Contact :   zhuozhiyongde@126.com
#@Software:   Visual Studio Code

import os.path

# trans list into csv
A = [
    45, 56, 57, 57, 60.3, 63, 64, 64, 64, 66, 66, 66, 66, 67, 70, 70, 70, 71,
    74, 74, 76, 73, 93, 95
]
B = [
    51, 51, 54, 54, 59, 61, 61, 61, 62, 68, 68, 70, 70, 71, 70, 87, 89, 91, 93
]
C = [46, 31, 56, 48, 43, 24, 18, 36, 44, 36, 36, 24, 18, 36, 44, 36]

f = open("Data3.csv", "w+", encoding="utf-8")
for index, value in enumerate(A):
    line = str(value)
    if index < len(B):
        line += "," + str(B[index])
    if index < len(C):
        line += "," + str(C[index])
    f.write(line+"\n")
f.close()
