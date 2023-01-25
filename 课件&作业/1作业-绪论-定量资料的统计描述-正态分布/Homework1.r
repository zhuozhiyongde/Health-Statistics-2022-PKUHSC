# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework1.r
# @Time    :2023/01/25 17:47:40
# @Software:   Visual Studio Code

rm(list = ls()) # 清空工作空间

# 此作业源代码丢失，为重写代码/作业，为简略只做第一问，第二问类似可做。

# 第一题
# 使用R软件对time 、 value变量进行定量资料的统计描述，包括集中趋势、离散趋势、绘制箱式图、正态性检验，将软件的统计分析界面整理到A4纸上
data <- read.csv("课件&作业/作业1-定量资料的统计描述-正态分布/实习1-课后作业数据.csv")

time <- data$time
value <- data$value

# 以time为例
# 统计描述
summary(time) # 算数均数、中位数、四分位数、最大值、最小值

# 集中趋势
mean(time) # 算数均数
exp(mean(log(time))) # 几何均数
table(time)[which.max(table(time))] # 众数

# 离散趋势
max(time) - min(time) # 极差
quantile(time, probs = 0.75) - quantile(time, probs = 0.25) # 四分位数间距
var(time) # 方差
sd(time) # 标准差
sd(time) / mean(time) * 100 # 变异系数,百分数形式

# 绘制箱式图
boxplot(time, main = "boxplot of time", col = "#8C0000")

# 正态性检验
shapiro.test(time) # Shapiro-Wilk正态性检验
# 峰度和偏度，用直方图观察
hist(time, main = "histogram of time", col = "#8C0000")
# 峰度和偏度，安装包moments检验
install.packages("moments") # 安装包
library(moments) # 载入包
skewness(time) # 偏度
# 1.057964>0, 正偏、右偏, 正态分布的偏度为0
kurtosis(time) # 峰度
# 3.803648>3, 正态分布的峰度为3
