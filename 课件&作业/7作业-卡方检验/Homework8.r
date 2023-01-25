# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework8.r
# @Time    :2023/01/25 22:15:46
# @Software:   Visual Studio Code


# Part 1
data <- read.csv("Homework8/Data1.csv")
data <- matrix(data$cases,
    nrow = 3, byrow = TRUE,
    dimnames = list(
        c("never", "occasionally", "often"),
        c("dorm", "apartment", "off-campus", "home")
    )
)

data
# Chisq test
chisq.test(data)

# convert into probs
# data <- prop.table(data)
data

exp_data <- function(data = data, r_number, c_number) {
    exp_dat <- data.frame()
    for (i in 1:r_number) {
        for (j in 1:c_number) {
            # Makes row i and column j into the expected value
            exp_dat[i, j] <- (sum(data[i, ]) * sum(data[, j])) / sum(data)
        }
    }
    exp_dat # Print expected values
}
exp_data <- exp_data(data = data, r_number = 3, c_number = 4)
# Chisq test
chisq.test(data)


# Part 2
# data4 <- matrix(c(100, 100, 80, 320),
#     nrow = 2, byrow = TRUE,
#     dimnames = list(
#         c("offspring_drink", "offspring_nodrink"),
#         c("parents_drink", "parents_nodrink")
#     )
# )
# 研究设计：
# 结局指标：
data4 <- matrix(c(18, 50, 12, 27),
    nrow = 2, byrow = TRUE,
    dimnames = list(
        c("after_neg", "after_pos"),
        c("before_neg", "before_pos")
    )
)
data4

mcnemar.test(data4, correct = FALSE)
binom.test(50, 62, 0.5, alternative = "greater")
