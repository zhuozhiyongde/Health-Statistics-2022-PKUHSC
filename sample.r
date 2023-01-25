x <- c("male", "female")
y <- factor(x)
y
cat(y[1], y[2])
x <- c(2, 5, NA, 8, NA, 11)
x # 2  5 NA  8 NA 11
x <- x[!is.na(x)]
x # 2 5 8 11

# 生成序列函数(seq,sequence)
1:n # 生成1到n的整数序列，步长为1
3:-3 # 生成3到-3的整数序列，步长为-1
seq(from = 1, to = 10, by = 2) # 生成1到10的整数序列，步长为2，可简写为下面的形式
seq(1, 10, by = 2) # 生成1到10的整数序列，步长为2

# 注意顺序优先级
1:10 + 2 # 3  4  5  6  7  8  9 10 11 12
1:(10 + 1) # 1  2  3  4  5  6  7  8  9 10 11

# 重复函数(rep,repeat)
rep(1:3, 2) # 1 2 3 1 2 3
rep(1:3, each = 2, times = 2) # 1 1 2 2 3 3
# 第一个参数x代表重复的对象，times代表向量x重复的次数，each代表x中每个元素每次重复的次数

# 生成均匀分布的随机数(ranif,random uniform)
runif(n = 10, min = 0, max = 1) # 生成10个均匀分布的随机数，可简写为下面的形式
runif(10, 0, 1) # 生成10个均匀分布的随机数
# n代表生成的随机数个数，min代表最小值，max代表最大值

# 生成正态分布的随机数(rnorm,random normal)
rnorm(n = 10, mean = 0, sd = 1) # 生成10个均值为0，标准差为1的正态分布随机数，可简写为下面的形式
rnorm(10, 0, 1) # 生成10个均值为0，标准差为1的正态分布随机数
# n代表生成的随机数个数，mean代表均值，sd(standard deviation)代表标准差

# 抽样函数(sample)
sample(1:10, size = 5, replace = TRUE, prob = c(rep(0.1, each = 10)))
# 从1到10中随机抽取5个数，可重复抽取，可简写为下面的形式
sample(1:10, 5) # 从1到10中随机抽取5个数
# size代表抽取的数的个数，replace代表是否可重复抽取

# 向量名字(names)
x <- 1:5
names(x) <- c("a", "b", "c", "d", "e")
x["a"] # 1

# 向量索引([],index)
x <- 1:5
# 整数下标
x[1:3] # 1 2 3
# 逻辑下标，逻辑下标的长度必须和向量的长度相同，且逻辑下标表达式中的x即为遍历时向量元素的值
x[which(x > 3)] # 4 5
# 字符串下标
names(x) <- c("a", "b", "c", "d", "e")
x[c("a", "b")] # 1 2

# 子集(subset)
x <- 1:5
subset(x, x > 3) # 4 5
# 子集函数可以用于从数据框（data frame，你可以暂时理解为excel）中提取数据，如下面的例子
x <- data.frame(a = 1:5, b = 6:10)
#   a  b
# 1 1  6
# 2 2  7
# 3 3  8
# 4 4  9
# 5 5 10
subset(x, a > 3)
#   a  b
# 4 4  9
# 5 5 10

# 获取x中a列的数据
x <- data.frame(a = 1:5, b = 6:10)
x$a # 1 2 3 4 5
x[["a"]] # 1 2 3 4 5

# 矩阵
# 矩阵的创建
x <- matrix(
    1:6,
    nrow = 2, ncol = 3, byrow = TRUE,
    dimnames = list(c("a", "b"), c("c", "d", "e"))
)
#   c d e
# a 1 2 3
# b 4 5 6
# 1:6代表矩阵的元素，nrow代表矩阵的行数，ncol代表矩阵的列数，byrow代表是否逐行填充，dimnames代表矩阵的行列名
# byrow参数默认为FALSE，即逐列填充
# 矩阵的行列名可以用下面的方法获取
dimnames(x) # [[1]] c("a", "b") [[2]] c("c", "d", "e")
rownames(x) # [1] "a" "b"
colnames(x) # [1] "c" "d" "e"
# 矩阵的行列数可以用下面的方法获取
dim(x) # 2 3
nrow(x) # 2
ncol(x) # 3
# 矩阵的转置
t(x) # 等价于x'，即行列互换


# 数据框(data frame)
# 数据框的创建
x <- data.frame(
    a = 1:5, b = 6:10, c = c("p", "k", "u", "n", "b"),
    row.names = c("a", "b", "c", "d", "e")
)
# data.frame(name1=col1, name2=col2, ..., stringsAsFactors=TRUE)
# 默认情况下，数据框中的字符串会被转换成因子， 如果不希望字符串转成因子，可以传递参数 stringsAsFactors=FALSE

# 读取CSV文件创建数据框
# read.csv(“./person.csv“，fileEncoding=“GB18030“)
# read.csv(“./person_utf8.csv“，fileEncoding=“UTF-8“)
# 一般情况下，文件以UTF-8编码保存，此时不需要指定ileEncoding参数。如果文件以GB18030编码保存，需要指定fileEncoding参数

# summary
# summary函数可以用于查看数据框的基本信息
summary(x)
#        a           b           c
#  Min.   :1   Min.   : 6   Length:5
#  1st Qu.:2   1st Qu.: 7   Class :character
#  Median :3   Median : 8   Mode  :character
#  Mean   :3   Mean   : 8
#  3rd Qu.:4   3rd Qu.: 9
#  Max.   :5   Max.   :10

# 数据框的索引
x <- data.frame(
    a = 1:5, b = 6:10, c = c("p", "k", "u", "n", "b"),
    row.names = c("a", "b", "c", "d", "e")
)
x$a # 1 2 3 4 5
x[["b"]] # 6  7  8  9 10
x[2:3] # 第2列到第3列构成的子数据框
#    b c
# a  6 p
# b  7 k
# c  8 u
# d  9 n
# e 10 b

# 数据框操作
x <- data.frame(
    a = 1:5, b = 6:10, c = c("p", "k", "u", "n", "b"),
    row.names = c("a", "b", "c", "d", "e")
)

# 增加列
x$d <- 11:15
#   a  b c  d
# a 1  6 p 11
# b 2  7 k 12
# c 3  8 u 13
# d 4  9 n 14
# e 5 10 b 15

# 修改列
x$d <- 21:25
#   a  b c  d
# a 1  6 p 21
# b 2  7 k 22
# c 3  8 u 23
# d 4  9 n 24
# e 5 10 b 25

# 删除列
x$d <- NULL
#   a  b c
# a 1  6 p
# b 2  7 k
# c 3  8 u
# d 4  9 n
# e 5 10 b

# 增加行
rbind(x, data.frame(a = 6, b = 11, c = "c", row.names = "f"))
#   a  b c
# a 1  6 p
# b 2  7 k
# c 3  8 u
# d 4  9 n
# e 5 10 b
# f 6 11 c

# 本质是将两个数据框合并（注意每列的数据类型要对应），合并后的数据框的行数是两个数据框行数之和

# with函数
# with函数可以用于简化对数据框的操作
# with(data, expression)
# 例如，对数据框x，计算a列的均值
with(x, mean(a)) # 3
# 与下面的写法等价
mean(x$a) # 3
# 看起来似乎没有简化多少，但这是因为现在只对单行操作，如果对多行操作，with函数就会显得非常有用了，如绘制图表
with(x, plot(a, b))

# R语言编程基础
# 条件语句
# if语句
# if (condition) {
#     expression
# } else if (condition) {
#     expression
# } else {
#     expression
# }
# 例如，判断一个数是正数还是负数
x <- 1
if (x > 0) {
    print("positive")
} else {
    print("negative")
}
# [1] "positive"

# if语句是有值的，可以用于赋值
# 判断成绩
score <- 80
grade <- if (score > 100 || score < 0) {
    "invaild"
} else if (score > 60) {
    "pass"
} else {
    "fail"
}
grade
# [1] "pass"

# repeat 语句
# repeat {
#     expression
#     if (condition) {
#         break
#     }
# }
# 例如，计算1到100的和
sum <- 0
i <- 1
repeat {
    sum <- sum + i
    i <- i + 1
    if (i > 100) {
        break
    }
}
sum
# [1] 5050

# while 语句
# while (condition) {
#     expression
# }
# 例如，计算1到100的和
sum <- 0
i <- 1
while (i <= 100) {
    sum <- sum + i
    i <- i + 1
}
sum
# [1] 5050

# for 语句
# for (variable in sequence) {
#     expression
# }
# 例如，计算1到100的和
sum <- 0
for (i in 1:100) {
    sum <- sum + i
}

# next 与 break
# next 类似于 Python 中的 continue，跳过本次循环，继续下一次循环
# 例如，计算1到100的和，但是跳过10的倍数
sum <- 0
for (i in 1:100) {
    if (i %% 10 == 0) {
        next
    }
    sum <- sum + i
}
sum
# [1] 4500

# break 跳出循环
# 例如，计算一个数是否为素数
is_prime <- function(x) {
    if (x <= 1) {
        return(FALSE)
    }
    for (i in 2:(x - 1)) {
        if (x %% i == 0) {
            return(FALSE)
        }
    }
    return(TRUE)
}
# 创建函数
# 函数的定义
# myFunc <- function (arg1, arg2, ...) {
#     expression
# }
# 例如，计算两个数的和
add <- function(x, y) {
    return(x + y)
}
add(1, 2)
# [1] 3
# 如果不写return, 则默认返回最后一行的值
# myFunc是函数名，arg1, arg2是参数，...表示可变参数，expression是函数体
# 更进一步的参数匹配等偏编程的知识并不在本课程的范围内，可以参考R语言官方文档

# factor
factor(x, levels, labels, ordered) # 创建因子，即分类变量，每个类别称为一个水平
# x：向量, unique(x)的元素个数应较少，对应各个分类
# levels：可选，因子的水平，可设置x中元素之外的值，可用于指定有序因子中水平的顺序。
# labels：可选，各个水平的标签，需要和levels等长且顺序保持一致，结果是实现了水平重命名。
# ordered：是否产生有序因子，默认为FALSE
# 例如，创建一个有序因子
x <- factor(
    c("yes", "yes", "no", "yes", "no"),
    ordered = TRUE, levels = c("no", "yes")
)
# [1] yes yes no  yes no
# Levels: no < yes

# 图表绘制
# plot，绘制散点图
# plot(x, y, type, main, sub, xlab, ylab, xlim, ylim, col)
# x：x轴数据
# y：y轴数据
# type：图表类型，p表示散点图，l表示折线图，b表示条形图
# main：图表标题
# xlab：x轴标题; ylab：y轴标题
# xlim：x轴范围; ylim：y轴范围
# col：颜色
# 例如，绘制一个散点图
x <- c(1, 2, 3, 4, 5)
y <- c(1, 4, 9, 16, 25)
plot(
    x, y,
    type = "p",
    main = "散点图", xlab = "x", ylab = "y",
    col = "#8C0000"
)
# lim是一个向量，表示x轴和y轴的范围，例如，xlim = c(0, 10)表示x轴范围为0到10
# type参数指定绘制类型，详细说明可以参见R语言官方文档

# barplot，绘制条形图
# barplot(x, main, xlab, ylab, xlim, ylim, col, horiz=FALSE, beside=FASLE))
# x：数据
# main：图表标题
# xlab：x轴标题; ylab：y轴标题
# xlim：x轴范围; ylim：y轴范围
# col：颜色
# horiz：是否水平绘制，默认为FALSE
# beside：是否并排绘制，默认为FALSE
# 例如，绘制一个条形图
x <- c(1, 2, 3, 4, 5)
y <- c(1, 4, 9, 16, 25)
barplot(
    y,
    main = "条形图", xlab = "x", ylab = "y",
    col = "red"
)
# 水平条形图
barplot(
    y,
    main = "条形图", xlab = "x", ylab = "y",
    col = "#8C0000",
    horiz = TRUE
)
# 输入矩阵时，beside参数
x <- matrix(c(1, 2, 3, 4, 5, 6), nrow = 2)
barplot(
    x,
    main = "条形图", xlab = "x", ylab = "y",
    col = c("#6800AA", "#8C0000"),
    beside = FALSE
)
# barplot with formula
# barplot(y ~ x, data, main, xlab, ylab, xlim, ylim, col, horiz=FALSE, beside=FASLE))
# y：y轴数据
# x：x轴数据
# data：数据框
# main：图表标题
# xlab：x轴标题; ylab：y轴标题
# xlim：x轴范围; ylim：y轴范围
# col：颜色
# horiz：是否水平绘制，默认为FALSE
# beside：是否并排绘制，默认为FALSE
# 例如，绘制一个条形图
x <- c(1, 2, 3, 1, 9)
y <- c(1, 4, 9, 16, 25)
barplot(
    y ~ x,
    main = "条形图", xlab = "x", ylab = "y",
    col = "red"
)



# hist，绘制直方图
# hist(x, breaks, main, xlab, ylab, xlim, ylim, col)
# x：数据
# breaks：分组个数
# main：图表标题
# xlab：x轴标题; ylab：y轴标题
# xlim：x轴范围; ylim：y轴范围
# col：颜色
# 例如，绘制一个正态分布直方图
x <- rnorm(1000)
hist(
    x,
    breaks = 20,
    main = "直方图", xlab = "x", ylab = "y",
    col = "#8C0000"
)

# boxplot，绘制箱线图
# boxplot(x, main, xlab, ylab, xlim, ylim, col)
# x：数据
# main：图表标题
# xlab：x轴标题; ylab：y轴标题
# xlim：x轴范围; ylim：y轴范围
# col：颜色
# 例如，绘制一个箱线图
x <- rnorm(1000)
boxplot(
    x,
    main = "箱线图", xlab = "x", ylab = "y",
    col = "#8C0000"
)

# lines and points
# lines(x, y, type, lty, lwd, col)
# points(x, y, type, pch, cex, col)
# x：x轴数据
# y：y轴数据
# type：绘制类型，详细说明可以参见R语言官方文档
# lty：线条类型，详细说明可以参见R语言官方文档
# lwd：线条宽度
# col：颜色
# pch：点的形状，详细说明可以参见R语言官方文档
# cex：点的大小
# 例如，在绘制的正弦函数图上绘制余弦函数线
x <- seq(0, 2 * pi, length = 100)
y <- sin(x)
plot(
    x, y,
    main = "三角函数", xlab = "x", ylab = "y",
    type = "l", lty = 2, lwd = 2, col = "#8C0000"
)
lines(
    x, cos(x),
    type = "l", lty = 2, lwd = 2, col = "#6800AA"
)
# 在绘制的正弦函数图上绘制正切函数点
points(
    x, tan(x),
    type = "p", pch = 1, cex = 1, col = "#FACC15"
)

# read.csv
# read.csv(file, encoding = "UTF-8")
# file：文件路径
# encoding：编码，默认为UTF-8
# 例如，读取一个csv文件
data <- read.csv("sample.csv", encoding = "UTF-8")
names(data)
# [1] "block" "group" "score"
head(data) # 查看前6行数据
#   block group score
# 1     1     A   8.4
# 2     1     B   9.6
# 3     1     C   9.8
# 4     1     D  11.7
# 5     2     A  11.6
# 6     2     B  12.7
tail(data) # 查看后6行数据
data$score # 查看score列数据
# [1]  8.4  9.6  9.8 11.7 11.6 12.7 11.8 12.0
# 读取后的csv文件是一个数据框

# d、p、q、r
# d、p、q、r分别表示概率密度函数、累积密度函数、分位数函数、随机数生成函数
# dbinom(x, size, prob) # 二项分布
dbinom(1, 10, 0.5) # 二项分布密度函数
plot(0:10,
    pbinom(0:10, 10, 0.5),
    type = "h", col = "#8C0000", main = "概率累积分布函数"
)

plot(seq(0, 1, length = 100),
    qbinom(seq(0, 1, length = 100), 10, 0.5),
    type = "h", col = "#8C0000", main = "分位数函数"
)

x <- rbinom(100, 10, 0.5) # 二项分布随机数生成函数
plot(1:100, sort(x), col = "#8C0000", main = "随机数生成函数")
