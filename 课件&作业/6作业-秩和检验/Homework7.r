# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework7.r
# @Time    :2023/01/25 22:15:08
# @Software:   Visual Studio Code


# Part1
data <- read.csv("Homework7/Data1.csv")
before <- data$before
after <- data$after

boxplot(before, after)
wilcox.test(before, after,
    paired = TRUE,
    alternative = "greater",
    exact = FALSE,
    correct = FALSE
)

# Part2
data <- read.csv("Homework7/Data2.csv")
new_drug <- data[which(data$drug == 1), "radio"]
regular_drug <- data[which(data$drug == 2), "radio"]
var.test(data$radio ~ data$drug)
t.test(new_drug, regular_drug, var.equal = FALSE)


wilcox.test(new_drug, regular_drug,
    paired = FALSE,
    exact = FALSE
)


# Part3
data <- read.csv("Homework7/Data3.csv")
g_a <- data$A
g_b <- data$B
g_c <- data$C

group <- factor(
    c(
        rep("1", length(g_a)),
        rep("2", length(g_b)),
        rep("3", length(g_c))
    )
)
pha_rate <- c(g_a, g_b, g_c)
kruskal.test(pha_rate ~ group)


# Part4
data <- read.csv("Homework7/Data4.csv")
score <- data$score
group <- data$group
block <- data$block

friedman.test(score ~ group | block)

qchisq(0.95, 1)
