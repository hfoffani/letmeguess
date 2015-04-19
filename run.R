processcsv <- function() {
    di <- text.read.dict()
    n1 <- text.read.ngram(1)
    n2 <- text.read.ngram(2)
    n3 <- text.read.ngram(3)
    n4 <- text.read.ngram(4)
    # TOTAL <- sum(n1$count)
    saveRDS(di, 'data/di.rds')
    saveRDS(n1, 'data/n1.rds')
    saveRDS(n2, 'data/n2.rds')
    saveRDS(n3, 'data/n3.rds')
    saveRDS(n4, 'data/n4.rds')
}

footprint <- function (units="Kb") {
    cat('DI', '\t', format(object.size(di), units=units), '\n')
    cat('N1', '\t', format(object.size(n1), units=units), '\n')
    cat('N2', '\t', format(object.size(n2), units=units), '\n')
    cat('N3', '\t', format(object.size(n3), units=units), '\n')
    cat('N4', '\t', format(object.size(n4), units=units), '\n')
}


# di <- readRDS('data/di.rds')
# n1 <- readRDS('data/n1.rds')
# n2 <- readRDS('data/n2.rds')
# n3 <- readRDS('data/n3.rds')
# n4 <- readRDS('data/n4.rds')

# text.guessoword(c(1,6,20),n1,n2,n3,n4)
# text.guessword(c(1,6),n1,n2,n3,n4)

# text.predict('how are you')
# text.predict('how is she')

#testsmall <- testset[sample(nrow(testset), 100),]

#tmp <- timeit({ test.accuracy(testset, simpsons.predict) })
#summary(tmp)
#plot(tmp)
#mean(tmp)
# 100 en 27 seg.

# some tricks in R.
f <- function(i) {
    r <- sample.int(3)[1] + m
    m <<- r
    r
}


