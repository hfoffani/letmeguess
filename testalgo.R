test.read <- function() {
    dataset <- 'data/x'
    testset <- read.csv(dataset, header=F, stringsAsFactors=F)
    names(testset) <- c('input', 'y')
}

test.accuracy <- function(testset, funcpredict) {
    res <- sapply(testset$input, funcpredict, c(0.001, 0.05, 0.15, 0.899), USE.NAMES=F)
    ok <- sum( res == testset$y ) / nrow(testset)
    return(ok)
}
