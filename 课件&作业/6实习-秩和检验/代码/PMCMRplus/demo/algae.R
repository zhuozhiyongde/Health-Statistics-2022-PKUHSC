##
## ALGAE GROWTH INHIBITION data set
## OECD 2006 p. 24
##
data(algae)
summary(algae)

##
## Example 2a. Atrazine Example Flourescence at Day 2
## NOEC Determination Atrazine by Two Methods
##

ncol <- length(algae[1,])

##
## build average for Day 2 (3 replicates)
##
Av2 <- rowSums(algae[,(ncol-2):ncol]) / 3
g <- as.factor(algae$concentration)

doseval <- unique(algae$concentration)
COUNT <- tapply(algae$concentration, g, length)
MEAN <- tapply(Av2, g, mean)
MEDIAN <- tapply(Av2, g, median)
STD_DEV <- tapply(Av2, g, sd)
STD_ERR <- STD_DEV / sqrt(COUNT)

## number of treatments
k <- length(doseval)

## groupnames
grpn <- paste0("D", 0:(k-1))

grp.stat <- data.frame(doseval, COUNT, MEAN, MEDIAN, STD_DEV,
                       STD_ERR)
rownames(grp.stat) <- grpn
levels(g) <- grpn
##
## Compare with OECD 2006, p. 25
## Note: as STD_DEV and STD_ERR are correct,
## MEAN and MEDIAN in OECD 2006, p. 25 are incorrect!
##
round(grp.stat, 4)

##
## test for normality of one-way ANOVA residuals
##
newdat <- data.frame(g, Av2)
mod <- aov(Av2 ~ g, newdat)
normtest <- shapiro.test(residuals(mod))
STD <- sd(residuals(mod))

## for skewness and kurtosis we use package e1071
if (require(e1071)){
SKEW <- skewness(residuals(mod), type=2) ## type = 2 is like SAS / SPSS
KURT <- kurtosis(residuals(mod), type=2) ## type = 2 is like SAS / SPSS

swt <- data.frame(STD, SKEW, KURT, SW_STAT = normtest$statistic,
                  P_VALUE = normtest$p.value)
##
## Compare output with OECD 2006, p. 25
##
round(swt, 5)
}

##
## test for equal variances of one-way ANOVA residuals
## package car function leveneTest()
## Compare output with OECD 2006, p. 25
##
if (require(car)){
    leveneTest(residuals(mod) ~ g)
} else {
    bartlett.test(residuals(mod) ~ g)
}

## Compare output with OECD 2006, p. 26
summary(tamhaneDunnettTest(Av2, g, alternative = "less"))

##
## Further tests, not in OECD 2006
##
summary(dunnettTest(Av2, g, alternative = "less")) # not appropriate, as var(i,j) != var(k,j)
summary(kwManyOneDunnTest(Av2, g, alt="less", p.adj="holm"))
summary(kwManyOneDunnTest(Av2, g, alt="less", p.adj="single"))
summary(manyOneUTest(Av2, g, alt="less", p.adj="holm"))
summary(vanWaerdenManyOneTest(Av2, g, alt="less", p.adj="single")) ## likely not appropriate, as var unequal

##
## trend tests
##
summary(stepDownTrendTest(Av2, g,
                          alternative = "less",
                          test = "jonck"))

summary(stepDownTrendTest(Av2, g,
                          alternative = "less",
                          test = "cuzick"))

summary(stepDownTrendTest(Av2, g,
                          alternative = "less",
                          test = "spearm"))
