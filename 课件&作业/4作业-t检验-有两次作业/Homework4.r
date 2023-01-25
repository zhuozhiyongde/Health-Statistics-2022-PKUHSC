# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework4.r
# @Time    :2023/01/25 21:43:21
# @Software:   Visual Studio Code


# Part 1
hemo <- read.csv("Homework4/Data/Part1.csv")$Hemoglobin
summary(hemo)

t.test(hemo, mu = 124.7) # t = -3.9863, df = 19, p-value = 0.0007905


# Part 2
treat <- read.csv("Homework4/Data/Part2.csv")
before <- treat$before
after <- treat$after

diff <- after - before
summary(diff)

t.test(diff, mu = 0) # t = -3.7154, df = 9, p-value = 0.004804


# Part 3
medicine <- read.csv("Homework4/Data/Part3.csv")
used <- na.omit(medicine$Used)
not_used <- medicine$NotUsed
summary(used)

var.test(used, not_used)
t.test(used, not_used, var.equal = TRUE)
