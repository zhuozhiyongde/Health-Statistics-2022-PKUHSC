#
# Example from OECD 2006
#
# The data set 'trout' contains
# dose levels of 10, 25, 60, 150 and 1000 ppm,
# and a control as well as
# the response in trout weight in mg
#

data(trout)
attach(trout)
xmean <- tapply(Y, DOSE, mean)
xn <- tapply(Y, DOSE, length)
xsd <- tapply(Y, DOSE, sd)
xse <- xsd / sqrt(xn)

ans <- data.frame(MEAN = round(xmean,1), SE = round(xse, 3), n = xn)
rownames(ans) <- levels(DOSE)

#
ans

#
# Check for normality
#
fit <- aov(Y ~ DOSE - 1)
shapiro.test(residuals(fit))

##
## Check for homogeneous variances
##
require(car)
leveneTest(fit)

##
## Perform Tanhame-Dunnett test
##
td.out <- tamhaneDunnettTest(Y, DOSE, alternative = 'less')
summary(td.out)

##
## Perform Dunnett test
##
summary(dunnettTest(Y, DOSE, alternative = 'less'))
require(multcomp)
summary(glht(fit, linfct=mcp(DOSE = "Dunnett"), alternative = 'less'))

#
# Test for monotonicity
# normalised ranks
#
k <- length(xn)
mat <- contr.poly(k)
mat <- mat[,1:2]
colnames(mat) <- c("Linear trend", "Quadratic trend")
mat <- t(mat)

m <- length(Y)
Rij <- rank(Y)
Rn <- Rij / m
Rfit <- aov(Rn ~ DOSE)
summary(glht(Rfit, linfct = mcp(DOSE = mat)))

##
## Perform step-down Jonckheere test
##
res <- stepDownTrendTest(Y ~ DOSE, trout, test = "jonck",
                         alternative = "less")
summary(res)

#
# Perform pairwise Wilcox test with Holm adjustment
#
summary(manyOneUTest(Y ~ DOSE, trout,
                     alternative = "less",
                     p.adjust = "holm"))

#
# Perform Williams trend test
#
williamsTest(Y ~ DOSE, trout, alternative = "less")

#
# Perform Shirley's test
#
shirleyWilliamsTest(Y ~ DOSE, trout, alternative = "less")

detach(trout)
