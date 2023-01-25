## frmcp.R
## part of PMCMR
##
## Copyright (C) 2017 Thorsten Pohlert
## GPL-3
##
## Friedman multiple comparisons
##
## Sources:
## [1] R. Eisinga, T Heskes, B. Pelzer, M. Te Grotenhuis (2017)
##     Exact p-values for pairwise comparison of Friedman rank sums,
##     with application to comparing classifiers.
##     BMC Bioinformatics 18:68
##
## [2] J. M. Ruiter et al. (2013) Evaluation of qPCR curve analysis
##     methods for reliable biomarker discovery: Bias, resolution,
##     precision, and implications. Methods 59, 32--46.
##
## Example from Eisinga et al. (2017, pp. 14--15).
## The data-set in Eisinga et al. (2017)
## was taken from Ruijter et al. 2013, Table 2.
##
##
data(qPCR)
Y <- as.matrix(qPCR)
Y

outT <- frdAllPairsNemenyiTest(Y)
outN <- frdAllPairsSiegelTest(Y, p.adj="bonf")

##
## The function frdAllPairsExactTest calls the function pexactfrsd()
## from Eisinga et al. 2017
##
outE <- frdAllPairsExactTest(Y, p.adj="bonf")
outX <- frdAllPairsMillerTest(Y)
outC <- frdAllPairsConoverTest(Y, p.adj="single-step")
outC2 <- frdAllPairsConoverTest(Y, p.adj="bonferroni")
outQ <- quadeAllPairsTest(Y, dist = "TDist", p.adj = "bonferroni")

##
## Prepare output as in Table 5 of Eisinga et al. (2017)
##
k <- 11
gnames <- c(colnames(outT$statistic), rownames(outT$statistic)[k-1])
mat1 <- matrix(NA, ncol=11, nrow = 11)
rownames(mat1) <- gnames
colnames(mat1) <- gnames
mat2 <- mat1
mat3 <- mat1
mat4 <- mat1

for (j in 1:(k-1)){
    for (i in (j+1):k){
        mat1[i, j] <- round(outN$p.value[i-1, j], 3)
        mat1[j, i] <- round(outE$statistic[i-1, j], 0)
        mat2[i, j] <- round(outE$p.value[i-1, j], 3)
        mat2[j, i] <- round(outT$p.value[i-1, j], 3)
        mat3[i, j] <- round(outX$p.value[i-1, j], 3)
        mat3[j, i] <- round(outC$p.value[i-1, j], 3)
        mat4[i, j] <- round(outC2$p.value[i-1, j], 3)
        mat4[j, i] <- round(outQ$p.value[i-1, j], 3)
    }
}

##
## Compare results above with Table 5 of Eisinga et. al. (2017).
## Upper triangle: absolute differences between the groups.
## Lower triangle: p-values of the Bonferroni-adjusted normal
## approximation.
mat1

## Upper triangle: Studentized range approximate p-values.
## Lower triangle: Bonferroni-adjusted exact p-values.
mat2


##
##Results below are not reported in literature
## Upper triangle: Conover's test with single-step adjusted p-values.
## Lower triangle: Chisquare p-values.
mat3

##
## Upper triangle: Quade's multiple comparison test with Bonferroni-
## adjusted p-values of the student t-distribution.
## Lower triangle: Conover's test with Bonferroni-adjusted p-values
mat4

##
## Global tests, from package PMCMR
##
friedmanTest(Y, dist="FDist")
friedmanTest(Y, dist="Chisq")
quade.test(Y)

##
## Trend test, from package PMCMR
## 
pageTest(Y, alternative = "greater")

## Clean up
rm(list = ls(all = TRUE))
