test.read <- function() {
    dataset <- 'data/x'
    testset <- read.csv(dataset, header=F, stringsAsFactors=F)
    names(testset) <- c('input', 'y')
}

test.accuracy <- function(testset, funcpredict) {
    res <- sapply(testset$input, funcpredict, USE.NAMES=F)
    ok <- sum( res == testset$y ) / nrow(testset)
    return(ok)
}
