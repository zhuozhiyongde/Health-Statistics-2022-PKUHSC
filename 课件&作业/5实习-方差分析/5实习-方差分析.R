#理论课脚本

#复习

x1<-c(134,146,104,119,124,161,107,93,113,129)
x2<-c(97,123,70,118,101,85,107,132,94,111)
x<-c(x1,x2)
g<-factor(rep(1:2,c(10,10)))

var.test(x~g);t.test(x~g,var.equal=T)
var.test(x1,x2);t.test(x1,x2,var.equal=T)

#例10.1

y1<-c(72,51,57,53,74,52,59,55,57,65,46,57,46,62,50,56,54,57,50)
y2<-c(54,57,48,41,34,54,38,49,58,40,51,44,52,42,55,44,48)
y3<-c(62,37,46,59,35,70,56,45,50,52,52,57,38,40,42)
y<-c(y1,y2,y3)
g<-factor(rep(1:3,c(19,17,15)))

#分组描述，各组平均m

m<-aggregate(y,by=list(g),FUN="mean")[,2]

#总平均mean
mean<-mean(y)

#各个y值用组平均代替

m_i <- rep(m,c(19,17,15))

#y的离均差(y-mean)被分解为（y-m_i）和（m_i-mean）两部分

d<-cbind(y,g,mean,m_i,y-mean,y-m_i,m_i-mean)

#验算sum(ab)=0

sum( d[,6] * d[,7]) 

#y的离均差平方和称为总变异，它等于（y-m_i）平方和 + （m_i-mean）平方和
 
sum(d[,5]^2) 
sum(d[,6]^2) + sum(d[,7]^2) 

SST<-sum((y-mean)^2)

var(y)*50

#（y-m_i）平方和称为组内变异，有另一种计算方法

SSW<-sum((y-m_i)^2)
var(y1)*18+var(y2)*16+var(y3)*14

#（m_i-mean）平方和称为组间变异，也有另外计算方法

SSB<-sum((m_i-mean)^2)

SST-SSW

sum((m-mean(y))^2*c(19,17,15))

#levene方差齐性检验

z1<-abs(y1-mean(y1))
z2<-abs(y2-mean(y2))
z3<-abs(y3-mean(y3))
z<-c(z1,z2,z3)
anova(lm(z~g))

#bartlett方差齐性检验

#推断三组总体方差是否相等的Bartlett检验
#其核心思想是通过求取不同组之间的卡方统计量，然后根据卡方统计量的值来判断组间方差是否相等。
#该方法极度依赖于数据是正态分布，如果数据非正态分布，则出来的结果偏差很大。

bartlett.test(y~g)

MSW<-SSW/(51-3)

a<-(19-1)*log(MSW/var(y1))+(17-1)*log(MSW/var(y2))+(15-1)*log(MSW/var(y3))

b<-1+(1/(3*2))*(1/18+1/16+1/14-1/48)

a/b

1-pchisq(a/b,2)

#完全随机设计方差分析，若P<0.05，则进一步作均数间两两比较

#1.LSD法
#问：此t检验与成组t检验有何改进
pairwise.t.test(y,g,p.adjust.method="none")

#2.bonferroni法
#考虑到两两比较，若H0成立将增大1型错误概率的问题，需调整检验水准
#设调整后的检验水准为alpha_*，将犯综合1型错误概率设定为alpha=0.05
#则多次比较不犯综合1型错误概率为1-alpha=0.95=(1-alpha_*)^c,c为比较次数
#当3组样本均数两两比较(c=3)时，调整后的检验水准alpha_*为
1-0.95^(1/3)

#当alpha=0.05较小时，上面结果用alpha/c=0.05/3近似。即LSD法P值和0.0167的检验水准比较
pairwise.t.test(y,g,p.adjust.method="none")

#如果不调整alpha值，仍取0.05，则可以将LSD法P值*比较次数，得到校正P值
pairwise.t.test(y,g,p.adjust.method="bonf")

#3.SNK法
#下载安装agricolae包
#调用agricolae包
library(agricolae)
#运行以下命令
fit_snk <- SNK.test(y, "g",group=FALSE)
fit_snk$comparison

#或者手工计算q统计量，见课件P33

#根据q值，结合跨度和组内自由度，确定P值的命令
1-ptukey(4.546,3,48)






#实习课脚本


#一、复习：独立两样本均数比较作α=0.05的成组t检验，若H0成立，问犯第一类统计错误概率是多少？

#从N(0,1)中随机抽取两样本x1,x2
x1<-rnorm(10,0,1)
x2<-rnorm(10,0,1)

#作成组t检验，得出P值
t.test(x1,x2,var.equal=T)$"p.value"

#P<α则拒绝H0,此时犯第一类统计错误

#犯第一类统计错误的例子

repeat {
x1<-rnorm(10,0,1)
x2<-rnorm(10,0,1)
if (t.test(x1,x2,var.equal=T)$"p.value"<0.05) break
}

#实验：独立两样本均数比较作α=0.05的成组t检验，若H0成立，问犯第一类统计错误概率是多少？
p<-c()
for (i in 1:100000) {
x1<-rnorm(10,0,1)
x2<-rnorm(10,0,1)
p[i]<-t.test(x1,x2,var.equal=T)$"p.value"
}
mean(p<0.05)

#二、完全随机设计方差分析
#独立三样本均数比较，不能作三次成组t检验(α=0.05)，因为：若H0成立将增大犯1型错误的概率
out<-c()
for (i in 1:100000) {
x1<-rnorm(10,0,1)
x2<-rnorm(10,0,1)
x3<-rnorm(10,0,1)
p <-c(t.test(x1,x2,var.equal=T)$"p.value",
      t.test(x1,x3,var.equal=T)$"p.value",
      t.test(x2,x3,var.equal=T)$"p.value")
out[i]<-any(p<0.05)
}
mean(out)

#独立多样本均数比较，应作完全随机设计方差分析(或称单因素方差分析)

#完全随机设计资料的概念

#完全随机设计资料举例
y1<-c(72,51,57,53,74,52,59,55,57,65,46,57,46,62,50,56,54,57,50)
y2<-c(54,57,48,41,34,54,38,49,58,40,51,44,52,42,55,44,48)
y3<-c(62,37,46,59,35,70,56,45,50,52,52,57,38,40,42)
y<-c(y1,y2,y3)
g<-factor(rep(1:3,c(19,17,15)))

#对该资料作统计描述
aggregate(y,by=list(g),FUN="mean")
aggregate(y,by=list(g),FUN="var")

#推断三组总体方差是否相等的Bartlett检验
#其核心思想是通过求取不同组之间的卡方统计量，然后根据卡方统计量的值来判断组间方差是否相等。
#该方法极度依赖于数据是正态分布，如果数据非正态分布，则出来的结果偏差很大。
bartlett.test(y~g)

#经方差齐性检验，P>0.10，求合并方差
n1<-length(y1)
n2<-length(y2)
n3<-length(y3)
N<-n1+n2+n3
(var(y1)*(n1-1)+var(y2)*(n2-1)+var(y3)*(n3-1))/(N-3)

#合并方差的另一种计算方法
(sum((y1-mean(y1))^2)+sum((y2-mean(y2))^2)+sum((y3-mean(y3))^2))/(N-3)

#（一）完全随机设计方差分析的分析步骤
#1.将总变异SST分解为组内变异SSW和组间变异SSB
#1）求总变异SST
SST<-var(y)*(N-1)
sum((y-mean(y))^2)

#2）求组内变异SSW
SSW<-(var(y1)*(n1-1)+var(y2)*(n2-1)+var(y3)*(n3-1))
(sum((y1-mean(y1))^2)+sum((y2-mean(y2))^2)+sum((y3-mean(y3))^2))

#3）求组间变异SSB
SSB<-SST-SSW
(mean(y1)-mean(y))^2*n1+(mean(y2)-mean(y))^2*n2+(mean(y3)-mean(y))^2*n3

#2.将总自由度df_T分解为组内自由度df_W和组间自由度df_B
df_W<-51-3
df_B<-3-1

#3.计算组内均方MSW和组间均方MSB
MSB<-SSB/df_B
MSW<-SSW/df_W

#4.计算F值
F<-MSB/MSW

#5.若H0成立，F服从自由度df_B，df_W的F分布，据此确定P值
1-pf(F,2,48)

#6.F分布的知识
x<-seq(0,6,0.01)
fx<-df(x,2,48)
plot(x,fx,type="l")
qf(0.95,2,48)
1-pf(F,2,48)

#7单因素方差分析的软件r实现
anova(lm(y~g))
summary(aov(y~g))

#提取其中组间均方和组内均方的方法
anova(lm(y~g))$"Mean Sq" [1]
anova(lm(y~g))$"Mean Sq" [2]

#（二）完全随机设计方差分析的基本思想
#组内均方反映y的随机误差，其期望值为sigma^2
#组间均方反映y的随机误差和处理因素带来的变异，其期望值为(sigma^2+处理效应)
#若H0成立，即处理无效应，则组内均方和组间均方都反映y的随机误差
#实验：由均数20，标准差3的正态总体里抽取3个样本，作单因素方差分析，并取出组内均方和组间均方
MSB<-c()
MSW<-c()
group<-factor(rep(1:3,c(10,10,10)))
for (i in 1:100000) {
x1<-rnorm(10,20,3)
x2<-rnorm(10,20,3)
x3<-rnorm(10,20,3)
x<-c(x1,x2,x3)
MSB[i]<-anova(lm(x~group))$"Mean Sq" [1]
MSW[i]<-anova(lm(x~group))$"Mean Sq" [2]
}
mean(MSW)
mean(MSB)

#（三）适用范围更广的Levene方差齐性检验
#步骤：1.将y值转换为z值
z1<-abs(y1-mean(y1))
z2<-abs(y2-mean(y2))
z3<-abs(y3-mean(y3))
z<-c(z1,z2,z3)

#步骤：2.对z值作单因素方差分析
anova(lm(z~g))

#（四）完全随机设计方差分析，若P<0.05，则进一步作均数间两两比较

#1.LSD法
#问：此t检验与成组t检验有何改进
pairwise.t.test(y,g,p.adjust.method="none")

#2.bonferroni法
#考虑到两两比较，若H0成立将增大1型错误概率的问题，需调整检验水准
#设调整后的检验水准为alpha_*，将犯综合1型错误概率设定为alpha=0.05
#则多次比较不犯综合1型错误概率为1-alpha=0.95=(1-alpha_*)^c,c为比较次数
#当3组样本均数两两比较(c=3)时，调整后的检验水准alpha_*为
1-0.95^(1/3)

#当alpha=0.05较小时，上面结果用alpha/c=0.05/3近似。即LSD法P值和0.0167的检验水准比较
pairwise.t.test(y,g,p.adjust.method="none")

#如果不调整alpha值，仍取0.05，则可以将LSD法P值*比较次数，得到校正P值
pairwise.t.test(y,g,p.adjust.method="bonf")

#3.SNK法
#下载安装agricolae包
#调用agricolae包
library(agricolae)
#运行以下命令
fit_snk <- SNK.test(y, "g",group=FALSE)
fit_snk$comparison

#或者手工计算q统计量，见课件P33

#根据q值，结合跨度和组内自由度，确定P值的命令
1-ptukey(4.546,3,48)

#三、随机区组设计方差分析
#数据输入方法
y<-c( 95,	95,	89,	83,
95,	94,	88,	84,
106,	105,	97,	90,
98,	97,	95,	90,
102,	98,	97,	88,
112,	112,	101,	94,
105,	103,	97,	88,
95,	92,	90,	80 )

treat<-factor(rep(1:4,8))
block<-factor(rep(1:8,c(4,4,4,4,4,4,4,4)))

cbind(y,treat,block)

#将y定义为8行4列矩阵，进行统计描述
d<-matrix(y,8,4,byrow=T)
apply(d,2,mean)
apply(d,1,mean)

#作随机区组设计方差分析
anova(lm(y~treat+block))

#其中总变异SST和总自由度(32-1)为
var(y)*31

#处理组变异SS_treat和处理自由度(4-1)为
sum((apply(d,2,mean)-mean(y))^2*8)

#区组变异SS_block和区组自由度(8-1)为
sum((apply(d,1,mean)-mean(y))^2*4)

#如果随机区组设计资料误用单因素方差分析，会使F值的分母变大

anova(lm(y~treat))
