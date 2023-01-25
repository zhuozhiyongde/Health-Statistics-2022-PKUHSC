{
    setwd(".")
    getwd()
    rm(list = ls())


    rawdata <- read.csv(
        "课件&作业/2作业-分类变量-标准化率/cleandata.csv",
        header = TRUE, stringsAsFactors = FALSE, na.strings = c("", "NA")
    ) # 读取数据
    dim(rawdata) # 查看数据集的维度
    names(rawdata)
    summary(rawdata)
    str(rawdata)
    head(rawdata)

    library(table1)
    library(dplyr)


    summary(rawdata$age)
    rawdata <- dplyr::mutate(rawdata,
        agegrp = cut(age, c(seq(15, 90, 15)),
            include.lowest = TRUE, right = FALSE
        )
    ) # 生成年龄分组变量agegrp
    summary(rawdata$agegrp) # 生成年龄分组频数表


    table(rawdata$edu)
    rawdata <- dplyr::mutate(rawdata,
        edu = factor(edu, levels = c("未上学", "小学", "中学", "大学及以上", "未知"))
    )
    summary(rawdata$edu)


    table(rawdata$smk)
    rawdata <- dplyr::mutate(rawdata,
        smk = factor(smk, levels = c("从不吸烟", "过去吸烟", "现在吸烟"))
    )
    summary(rawdata$smk)


    table(rawdata$dnk)
    rawdata <- dplyr::mutate(rawdata,
        dnk = factor(dnk, levels = c("从不饮酒", "过去饮酒", "现在饮酒"))
    )
    summary(rawdata$dnk)


    rawdata <- dplyr::mutate(rawdata,
        bmi = weight * 10000 / (height^2)
    ) # 生成BMI指数变量bmi
    rawdata <- dplyr::mutate(rawdata,
        bmigrp = cut(bmi, c(14, 24, 28, 40),
            include.lowest = TRUE,
            right = FALSE
        )
    )
    summary(rawdata$bmi) # 生成BMI指数频数表
    summary(rawdata$bmigrp) # 生成BMI指数分组频数表
    # boxplot(rawdata$bmi, main = "BMI指数箱线图", xlab = "BMI指数", ylab = "频数")



    summary(rawdata$sbp)
    rawdata <- dplyr::mutate(rawdata,
        sbpgrp = cut(sbp, c(seq(70, 170, 20)),
            include.lowest = TRUE, right = FALSE
        )
    )
    summary(rawdata$sbpgrp)

    summary(rawdata$dbp)
    rawdata <- dplyr::mutate(rawdata,
        dbpgrp = cut(dbp, c(seq(50, 110, 10)),
            include.lowest = TRUE, right = FALSE
        )
    )
    summary(rawdata$dbpgrp)

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
    table_one <- table1(~ agegrp + edu + smk + dnk + bmigrp + sbpgrp + dbpgrp |
        sex, data = rawdata, overall = "总计")
    table_one
}


summary(rawdata$sbp)
summary(rawdata$dbp)
hist(rawdata$sbp)
hist(rawdata$dbp)
boxplot(rawdata$sbp)
boxplot(rawdata$dbp)


rawdata <- dplyr::mutate(
    rawdata,
    is_high_bp = ifelse(sbp >= 140 | dbp >= 90, 1, 0)
)
table(rawdata$is_high_bp)
rawdata <- dplyr::mutate(
    rawdata,
    is_high_bp = factor(is_high_bp,
        levels = c(0, 1),
        labels = c("否", "是")
    )
)
summary(rawdata$is_high_bp)
label(rawdata$is_high_bp) <- "是否患有高血压（粗率）"
is_high_bp_table <- table1(~ is_high_bp | sex, data = rawdata, overall = "总计")
is_high_bp_table


{
    standard_population_total <- c(
        328315484, 339918126, 265660198, 132752961, 42857259
    )
    standard_population_male <- c(
        166750441, 173521604, 135222590, 66986350, 19396171
    )
    standard_population_female <- c(
        161565043, 166396522, 130437608, 65766611, 23461088
    )
}
# table(rawdata$sex)

table1(~ is_high_bp | agegrp + sex, data = rawdata, overall = "总计")
table1(~ is_high_bp | agegrp, data = rawdata, overall = "总计")

for (i in seq_along(total_agegrp)) {
    print(total_agegrp[i])
}

# rawdata <- dplyr::mutate(
#     rawdata,
#     standard_population_bp =
# )

# rawdata <- dplyr::mutate(rawdata,
#     sbpgrp = cut(sbp, c(70, 140, 170),
#         include.lowest = TRUE, right = FALSE
#     )
# )
# summary(rawdata$sbpgrp)
# rawdata <- dplyr::mutate(rawdata,
#     sbpgrp = factor(sbpgrp,
#         labels = c("正常", "高血压")
#     )
# )
# summary(rawdata$sbpgrp)


# rawdata <- dplyr::mutate(rawdata,
#     dbpgrp = cut(dbp, c(50, 90, 120),
#         include.lowest = TRUE, right = FALSE
#     )
# )
# summary(rawdata$dbpgrp)
# rawdata <- dplyr::mutate(rawdata,
#     dbpgrp = factor(dbpgrp,
#         labels = c("正常", "高血压")
#     )
# )
# summary(rawdata$dbpgrp)

df <- prop.table(table(rawdata$agegrp, rawdata$is_high_bp), 1)
barplot(df, beside = TRUE)

df_male <- subset(rawdata, sex == "男")
summary(df_male)

# for(i in names(rawdata$))
names(table(rawdata$agegrp))


standard_illed_total_name <- c() # 做出一个空列表，存储表头
standard_illed_total_pop <- c() # 做出一个空列表，存储标化后患病人数
for (i in names(table(rawdata$agegrp))) { # 遍历年龄分组
    standard_illed_total_name <- c(standard_illed_total_name, i) # 将年龄分组添加到表头列表

    # 计算当前年龄段患病概率
    prob <- nrow(subset(
        rawdata, agegrp == i & is_high_bp == "是"
    )) / nrow(subset(rawdata, agegrp == i))


    # 将标化后患病人数添加到标化后患病人数列表中
    standard_illed_total_pop <- c(
        standard_illed_total_pop,
        prob * standard_population_total[
            which(names(table(rawdata$agegrp)) == i)
        ]
    )
}
standard_illed_total_name
standard_illed_total_pop

output <- data.frame(
    standard_illed_total_name,
    standard_illed_total_pop
)
output <- t(output)
output

dbinom(115, 500, 0.23)
sum(dbinom(110:120, 500, 0.23))

x <- c()
j <- c()
for (i in 0:499) {
    x <- c(x, i)
    j <- c(j, pbinom(i, 500, 0.23) - (
        pnorm(i + 1, 115, 9.41010096) - pnorm(i, 115, 9.41010096)
    ))
}
plot(x, j, type = "l")


# 问 如何输出一个表，表头为 standard_illed_total_name 列表，只有一个行向量，内容为 standard_illed_total_pop 列表



# 
df_female <- subset(rawdata, sex == "女")
summary(df_female)
class(rawdata$agegrp)

table1(~ is_high_bp | agegrp, data = df_male)

df <- prop.table(table(df_male$agegrp, df_male$is_high_bp), 1)
barplot(df, beside = TRUE)
