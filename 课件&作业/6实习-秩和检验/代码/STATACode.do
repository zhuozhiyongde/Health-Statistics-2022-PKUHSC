*配对样本比较的Wilcoxon符号秩和检验
signrank x0 = x1 if x0~ = x1 //x0代表EDTA法，x1代表重量法

*两个独立样本比较的Wilcoxon秩和检验
ranksum x, by (group) //x代表排汞比值，group代表驱汞药的分组

*多个独立样本比较的Kruskal-Wallis H 检验
kwallis x, by (group)  //x代表生存月数，group代表治疗方法的分组

*多个独立样本比较的Kruskal-Wallis H 检验 两两比较
ssc install kwallis2 //安装kwallis2模块

kwallis2 x, by (group) //x代表生存月数，group代表治疗方法的分组

*随机区组设计多个样本比较的Friedman M 检验
ssc install emh //安装emh模块

emh score method, strata(group) anova transformation(rank) 
//score为综合评分，method为教学方式，group为区组编号