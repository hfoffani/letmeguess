library(timeit)
library(lineprof)


test.read <- function(fn) {
    dataset <- paste('data', fn,sep='/')
    testset <- read.csv(dataset, header=F, stringsAsFactors=F, sep="|")
    names(testset) <- c('input', 'y')
    return( testset )
}

test.accuracy <- function(testset, FUN, ...) {
    res <- sapply(testset$input, FUN, ..., USE.NAMES=F)
    ok <- sum( res[1,] == testset$y ) / nrow(testset)
    return( ok )
}

# tmp <- timeit({
#     test.accuracy(testset, simpsons.predict, c(0.001, 0.05, 0.15, 0.899), )
# })

# ./valsuite2.sh ../benchmark/data/quizzes.txt > tq.txt
# test.accuracy(tq, text.predict)
# [1] 0.133

#  tmp <- timeit({ test.accuracy( tq, text.predict ) })
# optim(c(-1.2,1),fr, control=list(fnscale=-0.01))$par
#
fsumleq1 <- function(x) { sum(x)-1 }
fsumeq1 <- function(x) { sum(x)-1 }
# COBYLA (Constrained Optimization BY Linear Approximations)
opts <- list( "algorithm" = "NLOPT_LN_COBYLA",
              "xtol_rel" = 1.0e-7,
              "maxeval" = 1000,
              print_level = 3
              # ,"local_opts" = local_opts 
)
# nloptr(   x0 = c(.25,.25,.25,.25),
#           eval_f = fopt,
#           lb = c(0,0,0,0),
#           ub = c(1,1,1,1),
#           eval_g_ineq = fsumleq1,
#           opts = opts
# )

profanities <- function() {
    dfprof <- read.csv('data/prof.txt', stringsAsFactors=F,header=F)
    names(dfprof) <- c('word')
    tprof <- data.table(dfprof)
    setkey(tprof, word)
    saveRDS(tprof, 'data/prof.rds')
}

cleanprof <- function(p) {
    clean <- ifelse(p %in% profan$word, sub('^(.).*', '\\1***', p), p)
    return( clean )
}

fopt <- function(pars) {
    1 - test.accuracy( opti2, text.predict, pars )
}

source('shinytextpredict/helper.R')
tq <- test.read('tq.txt')
lineprof_textpredict <- function() {
    test.accuracy( tq, text.predict )
}

