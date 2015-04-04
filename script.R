# 1. read dictionary   +
# 2. read 2-gram       +
#   2.1 read n-gram    +
# 3. hash 2-gram
# 4. from 2-gram to dict of lists of pairs

# di <- read.dict()
# n1 <- read.ngram(1)
# n2 <- read.ngram(2)
# n3 <- read.ngram(3)
# n4 <- read.ngram(4)

read.dict <- function () {
    w <- read.csv('data/di.csv', header=F, stringsAsFactors=F)
    names(w) <- c('word','id')
    return(w)
}

read.ngram <- function (n) {
    l1 <- list('y','count')
    l2 <- list('x1','y','count')
    l3 <- list('x1','x2','y','count')
    l4 <- list('x1','x2','x3','y','count')
    ln <- list(l1,l2,l3,l4)
    # return(unlist(ln[[n]]))
    
    fi <- paste('data/n', n, '.csv', sep="")
    ngr <- read.csv(fi, header=F)
    
    names(ngr) <- unlist(ln[[n]])
    return(ngr)
}

