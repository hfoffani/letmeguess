test.read <- function() {
    dataset <- 'data/x'
    testset <- read.csv(dataset, header=F, stringsAsFactors=F)
    names(testset) <- c('input', 'y')
}

test.accuracy <- function(testset, FUN, ...) {
    res <- sapply(testset$input, FUN, ..., USE.NAMES=F)
    ok <- sum( res == testset$y ) / nrow(testset)
    return(ok)
}

# tmp <- timeit({
#     test.accuracy(testset, simpsons.predict, c(0.001, 0.05, 0.15, 0.899), )
# })

