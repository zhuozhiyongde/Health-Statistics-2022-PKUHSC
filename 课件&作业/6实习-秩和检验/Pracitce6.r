# Part 1
before <- c(
    31.5, 30.0, 28.6, 39.7,
    45.2, 20.3, 37.3, 24.0,
    36.2, 20.5, 23.1, 29.0,
    33.1, 35.2, 28.9, 26.4,
    25.9, 23.8, 30.4, 31.6,
    27.9, 33.0, 34.0, 32.7
)

after <- c(
    2.0, 3.2, 2.3, 3.1, 1.9,
    2.2, 1.5, 1.8, 3.2, 3.0,
    2.8, 2.1
)
boxplot(before, after)

wilcox.test(before, after,
    paired = FALSE, alternative = "two.sided",
    exact = FALSE, correct = FALSE
)

# Part 2
treat <- c(rep(1:5, c(1, 5, 13, 9, 2)))
treat
compare <- c(rep(1:5, c(1, 14, 10, 5, 0)))
compare
medicine <- factor(rep(1:2, c(30, 30)))
medicine
result <- c(treat, compare)

wilcox.test(result ~ medicine, exact = FALSE)

# Part 3
ga <- c(0, 0, 0, 0, 2, 1, 0, 0, 1, 2, 0, 2, 0, 1, 0, 1)
gb <- c(2, 0, 2, 1, 1, 2, 1, 2, 1, 2, 0, 2, 1, 2, 1, 2)

wilcox.test(ga, gb,
    paired = TRUE,
    alternative = "two.sided",
    exact = FALSE,
    correct = TRUE
)

# Practice 1
data <- read.csv("Practice7/数据/R_SAS数据/data1.csv")
data
edta <- data$EDTA
weight <- data$weight

boxplot(edta, weight)
wilcox.test(edta, weight,
    paired = TRUE,
    alternative = "two.sided", # 双侧检验
    exact = FALSE, # 精确概率法（<50时设定为TRUE，若有TIES，则算不出来，仍设定为FALSE）
    correct = FALSE # 连续性矫正（±0.5）
)


