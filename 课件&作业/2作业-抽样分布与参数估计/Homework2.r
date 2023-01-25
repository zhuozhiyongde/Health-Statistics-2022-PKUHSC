# -*- coding: utf-8 -*-
# @Author  :Arthals
# @File    :Homework2.r
# @Time    :2023/01/25 18:48:48
# @Software:   Visual Studio Code

rm(list = ls())

# 第一题
rawdata <- read.csv(
    "课件&作业/2作业-分类变量-标准化率/cleandata.csv",
    header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA")
) # 读取数据

dim(rawdata) # 查看数据集的维度
names(rawdata)
summary(rawdata)


# 生成年龄分组频数表
rawdata$agegrp <- cut(
    rawdata$age, c(seq(15, 90, 15)),
    include.lowest = TRUE, right = FALSE
)
# 这个函数的作用是给原数据新加了一列分类变量agegrp，这一列的值是根据原数据的age列的值来划分的

# 生成教育程度分组频数表
rawdata$edu <- factor(
    rawdata$edu,
    levels = c("未上学", "小学", "中学", "大学及以上", "未知")
)

# 生成吸烟情况分组频数表
rawdata$smk <- factor(
    rawdata$smk,
    levels = c("从不吸烟", "过去吸烟", "现在吸烟")
)

# 生成饮酒情况分组频数表
rawdata$dnk <- factor(
    rawdata$dnk,
    levels = c("从不饮酒", "过去饮酒", "现在饮酒")
)

# 生成BMI指数变量bmi
rawdata$bmi <- rawdata$weight * 10000 / (rawdata$height^2) # 计算BMI指数
# 生成BMI指数频数表
rawdata$bmigrp <- cut(
    rawdata$bmi, c(14, 24, 28, 40),
    include.lowest = TRUE,
    right = FALSE
)

# 生成收缩压分组频数表
rawdata$sbpgrp <- cut(
    rawdata$sbp, c(seq(70, 170, 20)),
    include.lowest = TRUE,
    right = FALSE
)

# 生成舒张压分组频数表
rawdata$dbpgrp <- cut(
    rawdata$dbp, c(seq(50, 110, 10)),
    include.lowest = TRUE,
    right = FALSE
)

# 设置标签、单位
label(rawdata$agegrp) <- "年龄"
label(rawdata$edu) <- "教育程度"
label(rawdata$smk) <- "吸烟情况"
label(rawdata$dnk) <- "饮酒情况"
label(rawdata$bmigrp) <- "BMI指数"
label(rawdata$sbpgrp) <- "收缩压"
label(rawdata$dbpgrp) <- "舒张压"
units(rawdata$agegrp) <- "岁"
units(rawdata$sbpgrp) <- "mmHg"
units(rawdata$dbpgrp) <- "mmHg"

# 生成table1
library(table1)
table_one <- table1(~ agegrp + edu + smk + dnk + bmigrp + sbpgrp + dbpgrp |
    sex, data = rawdata, overall = "总计")
table_one

# 第二题
rm(list = ls())
# 报告研究对象的高血压患病率粗率
rawdata <- read.csv(
    "课件&作业/2作业-分类变量-标准化率/cleandata.csv",
    header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA")
) # 读取数据
rawdata$agegrp <- cut(
    rawdata$age, c(seq(15, 90, 15)),
    include.lowest = TRUE, right = FALSE
)
rawdata$is_high_bp <- factor(
    ifelse(rawdata$sbp >= 140 | rawdata$dbp >= 90, 1, 0),
    levels = c(0, 1),
    labels = c("否", "是")
)
label(rawdata$is_high_bp) <- "是否患有高血压（粗率）"
is_high_bp_table <- table1(~ is_high_bp | sex, data = rawdata, overall = "总计")
is_high_bp_table

# 报告研究对象的高血压患病率标准化率
standard_population_total <- c(
    328315484, 339918126, 265660198, 132752961, 42857259
)

standard_population_male <- c(
    166750441, 173521604, 135222590, 66986350, 19396171
)

standard_population_female <- c(
    161565043, 166396522, 130437608, 65766611, 23461088
)

rawdata$sex <- as.factor(rawdata$sex)
names(rawdata$sex) <- c("男", "女")


# 按照年龄进行标化
male_agegrp <- c()
for (age in levels(rawdata$agegrp)) {
    male_agegrp <- c(
        male_agegrp,
        nrow(
            rawdata[
                rawdata$agegrp == age &
                    rawdata$sex == "男" &
                    rawdata$is_high_bp == "是",
            ]
        ) / nrow(
            rawdata[
                rawdata$agegrp == age &
                    rawdata$sex == "男",
            ]
        )
    )
}
male_agegrp
illed_male <- male_agegrp * standard_population_male
illed_male

female_agegrp <- c()
for (age in levels(rawdata$agegrp)) {
    female_agegrp <- c(
        female_agegrp,
        nrow(
            rawdata[
                rawdata$agegrp == age &
                    rawdata$sex == "女" &
                    rawdata$is_high_bp == "是",
            ]
        ) / nrow(
            rawdata[
                rawdata$agegrp == age &
                    rawdata$sex == "女",
            ]
        )
    )
}
female_agegrp
illed_female <- female_agegrp * standard_population_female
illed_female

total_agegrp <- c()
for (age in levels(rawdata$agegrp)) {
    total_agegrp <- c(
        total_agegrp,
        nrow(
            rawdata[
                rawdata$agegrp == age &
                    rawdata$is_high_bp == "是",
            ]
        ) / nrow(
            rawdata[
                rawdata$agegrp == age,
            ]
        )
    )
}
total_agegrp
illed_total <- total_agegrp * standard_population_total
illed_total

# round


# 生成标准化率表
sd_table <- rbind(illed_male, illed_female, illed_total)
header <- c("15-29", "30-44", "45-59", "60-74", "75-89")
rownames(sd_table) <- c("男", "女", "总计")
colnames(sd_table) <- header
sd_table

# round the table
sd_table <- round(sd_table)


sd_table <- t(sd_table)
# save as csv
write.csv(sd_table, "课件&作业/2作业-分类变量-标准化率/标准化率.csv")

total_table <- cbind(standard_population_male, standard_population_female, standard_population_total)
colnames(total_table) <- c("男", "女", "总计")
rownames(total_table) <- header

rate_table <- round(sd_table / total_table, 2)
rate_table
write.csv(rate_table, "课件&作业/2作业-分类变量-标准化率/标准化率比.csv")


# sum rows in sd_table
sd_table <- apply(sd_table, 2, sum)
sd_table
total_table <- apply(total_table, 2, sum)
total_table
rate_table <- sd_table / total_table
rate_table
round(rate_table, 2)

# 第三题
options(warn = 0)
table1(~ is_high_bp | sex * agegrp, data = rawdata, overall = "总计")
options(warn = 1)
