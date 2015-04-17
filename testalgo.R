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



