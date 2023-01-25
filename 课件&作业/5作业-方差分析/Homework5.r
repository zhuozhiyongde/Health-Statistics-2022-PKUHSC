# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework5.r
# @Time    :2023/01/25 21:49:55
# @Software:   Visual Studio Code


# Part1
data <- read.csv("Homework5/Part1.csv")
summary(data)

g <- factor(rep(1:3, c(10, 10, 10)))

# 1.1 数据特征描述
summary(data$bd)

# 进行方差分析

g1 <- subset(data$bd, data$g == 1)
g2 <- subset(data$bd, data$g == 2)
g3 <- subset(data$bd, data$g == 3)


z1 <- abs(g1 - mean(g1))
z2 <- abs(g2 - mean(g2))
z3 <- abs(g3 - mean(g3))
z <- c(z1, z2, z3)
output <- anova(lm(z ~ g))

output$"F value"
output$"Pr(>F)"

# Pr = 0.4897>0.10 认为具有方差齐性

output <- anova(lm(data$bd ~ g))
output

# Pr = 0.001533<0.05, 认为至少两组总体均数不等

mean(g1) - mean(g2)
t_12 <- (mean(g1) - mean(g2)) / sqrt(462.4 * (1 / 10 + 1 / 10))
t_12
pt_12 <- 2 * pt(t_12, 27)
pt_12
adjust_pt_12 <- pt_12 * 3
adjust_pt_12


mean(g1) - mean(g3)
t_13 <- (mean(g1) - mean(g3)) / sqrt(462.4 * (1 / 10 + 1 / 10))
t_13
pt_13 <- 2 * pt(t_13, 27)
pt_13
adjust_pt_13 <- pt_13 * 3
adjust_pt_13


mean(g2) - mean(g3)
t_23 <- (mean(g2) - mean(g3)) / sqrt(462.4 * (1 / 10 + 1 / 10))
t_23
pt_23 <- 2 * pt(t_23, 27)
pt_23
adjust_pt_23 <- pt_23 * 3
adjust_pt_23


pairwise.t.test(data$bd, g, p.adjust.method = "bonf")


# Part2
# ↓ 不知道在做什么的尝试
# bgc <- read.csv("Homework5/Part2.csv")$bgc
# g <- factor(rep(1:4, c(4, 4, 4, 4)))
# m <- factor(rep(1:4, times = 4))

# data <- data.frame(g, m, bgc)
# aov <- aov(bgc ~ g + m, data = data)
# summary(aov)



# cbind(g, m, bgc)

# Part2
bgc <- read.csv("Homework5/Part2.csv")$bgc
data <- matrix(bgc, 4, 4, byrow = TRUE)
data

m_treat <- rep(apply(data, 2, mean), 4)
m_treat
m_block <- rep(apply(data, 1, mean), c(4, 4, 4, 4))
m_block
m_bgc <- mean(bgc)

ss_treat <- sum((m_treat - m_bgc)^2)
ss_treat
ss_block <- sum((m_block - m_bgc)^2)
ss_block
ss_residuals <- sum((bgc - m_treat - m_block + m_bgc)^2)
ss_residuals
ss_total <- sum((bgc - m_bgc)^2)
ss_total
ms_treat <- ss_treat / 3
ms_treat
ms_block <- ss_block / 3
ms_block
ms_residuals <- ss_residuals / 9
ms_residuals
f_treat <- ms_treat / ms_residuals
f_treat
f_block <- ms_block / ms_residuals
f_block
pr_treat <- 1 - pf(ms_treat / ms_residuals, 3, 9)
pr_treat
pr_block <- 1 - pf(ms_block / ms_residuals, 3, 9)
pr_block


# 简便做法
output <- data.frame(
    Y = bgc,
    Treat = factor(rep(1:4, times = 4)),
    Block = factor(rep(1:4, c(4, 4, 4, 4)))
)
output
output.aov <- aov(Y ~ Treat + Block, data = output)
output.aov
summary(output.aov)
# anova.tab <- function(fm) {
#     tab <- summary(fm)
#     k <- length(tab[[1]]) - 2
#     temp <- c(sum(tab[[1]][, 1]), sum(tab[[1]][, 2]), rep(NA, k))
#     tab[[1]]["Total", ] <- temp
#     tab
# }
# anova.tab(output.aov)
