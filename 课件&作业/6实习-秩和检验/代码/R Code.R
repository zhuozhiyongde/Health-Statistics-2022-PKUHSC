setwd("C:/Users/Lenovo/Desktop/data")

# 1.配对样本比较的Wilcoxon符号秩和检验 ####
# 读取数据
data1 <- read.csv("data1.csv")
EDTA <- data1$EDTA; weight <- data1$weight
# 查看数据
boxplot(EDTA, weight)
# Wilcoxon符号秩和检验
wilcox.test(EDTA, weight, paired = T,
            alternative = "two.sided", exact = F, correct = F)

# 2.两个独立样本比较的Wilcoxon秩和检验 ####
# 读取数据
data2 <- read.csv("data2.csv")
drug1 <- data2[which(data2$drug==1), "ratio"]
drug2 <- data2[which(data2$drug==2), "ratio"]
# 查看数据
boxplot(drug1, drug2)
# Wilcoxon秩和检验
wilcox.test(ratio~drug, data = data2, exact =F)

# 3.多个独立样本比较的Kruskal-Wallis H 检验 ####
# 读取数据
data3 <- read.csv("data3.csv")
group1 <- data3[which(data3$group==1), "time"]
group2 <- data3[which(data3$group==2), "time"]
group3 <- data3[which(data3$group==3), "time"]
# 查看数据
boxplot(group1, group2, group3)
# Kruskal-Wallis H检验
kruskal.test(time ~ group, data = data3)

# 多重比较 ###
## 法1-pairwise.wilcox.test(Bonferroni)
with(data=data3, 
     pairwise.wilcox.test(
       x=time, g=group, p.adjust.method = "bonferroni"))
# 法2~4均基于PMCMRplus包实现
install.packages("PMCMRplus")
library(PMCMRplus)
## 法2-Nemenyi's all-pairs comparison test
res <- kwAllPairsNemenyiTest(time~group, data=data3, dist ="Tukey")
summary(res)
## 在法2-Nemenyi中，Only for method = "Chisq" a tie correction is employed.
res <- kwAllPairsNemenyiTest(time~group, data=data3, dist ="Chisquare")
summary(res)
## 法3-Dunn's all-pairs comparison test
res <- kwAllPairsDunnTest(time~group, data=data3, p.adjust.method = "bonferroni")
summary(res)
## 法4-single-step means Tukey's p-adjustment
res <- kwAllPairsConoverTest(time~group, data=data3, p.adjust.method = "single-step")
summary(res)

# 4.随机区组设计多个样本比较的Friedman M 检验 ####
# 读取数据
data4 <- read.csv("data4.csv")
# Friedman M检验
friedman.test(score ~ group|block, data = data4)
# 多重比较-Nemenyi法
res <- frdAllPairsNemenyiTest(score~group|block, data=data4)
summary(res)


