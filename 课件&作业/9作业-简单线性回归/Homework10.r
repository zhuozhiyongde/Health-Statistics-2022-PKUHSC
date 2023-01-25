# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework10.r
# @Time    :2023/01/25 22:16:23
# @Software:   Visual Studio Code


# 第一题
d <- matrix(c(
    2.99, 51.3, 73.6,
    3.11, 48.9, 83.9,
    1.91, 42.8, 78.3,
    2.63, 55.0, 77.1,
    2.86, 45.3, 81.7,
    1.91, 45.3, 74.8,
    2.98, 51.4, 73.7,
    3.28, 53.8, 79.4,
    2.52, 49.0, 72.6,
    3.27, 53.9, 79.5,
    3.10, 48.8, 83.8,
    3.28, 52.6, 88.4,
    1.92, 42.7, 78.2,
    3.27, 52.5, 88.3,
    2.64, 55.1, 77.2,
    2.85, 45.2, 81.6,
    3.16, 51.4, 78.3,
    2.51, 48.7, 72.5,
    3.15, 51.3, 78.2,
    1.92, 45.2, 74.7
), 20, 3, byrow = TRUE)
# vital_capacity
vc <- d[, 1]
# weight
wg <- d[, 2]
# chest_girth
cg <- d[, 3]

plot(vc, cg,
    main = "vital_capacity vs chest_girth",
    xlab = "vital_capacity",
    ylab = "chest_girth"
)

# 相关性分析



cor.test(vc, cg)
lm(vc ~ cg)
summary(lm(vc ~ cg))

# sqrt(sum(((1 - 0.08819) * cg + 1.60311)^2) / 18)
lxx <- sum((cg - mean(cg))^2)
lxy <- sum((vc - mean(vc)) * (cg - mean(cg)))
b1 <- lxy / lxx
b1

predict(lm(vc ~ cg), data.frame(cg = c(79)), interval = c("confidence"))
predict(lm(vc ~ cg), data.frame(cg = c(79)), interval = c("prediction"))
0.05468 * 79 - 1.54535
