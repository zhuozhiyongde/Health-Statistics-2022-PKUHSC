# 读取数据
data <- read.csv(
    "Arthritis.csv"
)
# 查看数据集的前几行观测
head(data)
# 总结数据特征
summary(data)

# 计算算数均数
mean_age <- mean(data$Age)
mean_age
# 计算几何均数
geometry.mean_age <- exp(mean(log(data$Age)))
geometry.mean_age

# 计算中位数
median_age <- median(data$Age)
median_age
# 计算百分位数-四分位数
quantile_age <- quantile(
    data$Age,
    # 设定百分位数的间隔为25%，即：25%、50%、75%
    probs = seq(0, 1, 0.25), na.rm = FALSE, names = TRUE
)
quantile_age

# 计算众数
### tmp为每个年龄出现的次数
tmp <- table(data$Age)
tmp
### index为出现次数最多的年龄及其索引
index <- which.max(tmp)
index
### 输出年龄的众数及其出现次数
mode_age <- tmp[index]
mode_age

# 计算极差
range_age <- max(data$Age) - min(data$Age)
range_age
# 计算四分位数间距
Q75_age <- quantile(data$Age, probs = 0.75)
Q75_age
Q25_age <- quantile(data$Age, probs = 0.25)
Q25_age
Q <- Q75_age - Q25_age
Q

# 计算方差
var_age <- var(data$Age)
var_age
# 计算标准差
sd_age <- sd(data$Age)
sd_age
# 计算变异系数
cv_age1 <- raster::cv(data$Age)
cv_age1
cv_age2 <- sd_age / mean_age * 100
cv_age2 # 百分数形式

# 绘制箱式图
boxplot(data$Age, col = c("gold"), ylab = "年龄")

# 频数/频率分布直方图法
hist(data$Age,
    breaks = c(1, 30, 40, 50, 60, 70, 100),
    # freq = T: 频数分布直方图
    freq = T, xlab = "年龄", ylab = "频数", main = "频数分布直方图"
    # # freq = F: 频率分布直方图
    # freq = F, xlab = "年龄", ylab = "频率", main="频率分布直方图"
)

# 概率密度曲线比较法
### Step1.hist()画频率分布直方图
hist(data$Age,
    prob = T, ylim = c(0, 0.05),
    main = "年龄的概率密度图",
    xlab = "年龄", ylab = "密度"
)
### Step2.lines()画估计的概率密度曲线
lines(density(data$Age), col = "blue", lwd = 2)
### Step3.lines()画理想中的正态概率密度曲线
xfit <- seq(min(data$Age), max(data$Age), length = 20)
yfit <- dnorm(xfit, mean(data$Age), sd(data$Age))
lines(xfit, yfit, col = "red", lwd = 2)

# P-P图 ###
plot((rank(data$Age) - 0.5) / length(data$Age),
    pnorm(mean = mean(data$Age), sd = sd(data$Age), data$Age),
    xlab = "实际累积概率", ylab = "期望累积概率", main = "P-P图"
)
lines(x = c(0, 100), y = c(0, 100), col = 2, lwd = 2)

# Q-Q图 ###
qqnorm(data$Age)
qqline(data$Age, col = 2, lwd = 2)

# 偏度、峰度 ###
install.packages("moments")
library(moments)
skewness(data$Age) # 偏度
kurtosis(data$Age) # 峰度

# Shapiro-Wilk检验 (小样本, 3~5000)
shapiro.test(data$Age)

# Kolmogorov-Smirnov检验(大样本, >5000)
ks.test(
    data$Age, "pnorm",
    mean(data$Age), sd(data$Age)
)
# Delete warning in Kolmogorov-Smirnov检验
ks.test(
    data$Age + runif(length(data$Age), -0.05, 0.05), "pnorm",
    mean(data$Age), sd(data$Age)
)

# 写出数据集data
write.csv(data, "F:/Huwh/PHD/Other/培养/助教/卫生统计课_本科_2022秋/课件/实习1/data.csv")
