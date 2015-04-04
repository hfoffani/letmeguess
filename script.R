# 1. read dictionary   +
# 2. read 2-gram       +
#   2.1 read n-gram    +
# 3. hash 2-gram
# 4. from 2-gram to dict of lists of pairs

# di <- text.read.dict()
# n1 <- text.read.ngram(1)
# n2 <- text.read.ngram(2)
# n3 <- text.read.ngram(3)
# n4 <- text.read.ngram(4)

text.read.dict <- function () {
    w <- read.csv('data/di.csv', header=F, stringsAsFactors=F)
    names(w) <- c('word','id')
    return(w)
}

text.read.ngram <- function (n) {
    l1 <- list('y','count')
    l2 <- list('x1','y','count')
    l3 <- list('x1','x2','y','count')
    l4 <- list('x1','x2','x3','y','count')
    ln <- list(l1,l2,l3,l4)
    # return(unlist(ln[[n]]))
    
    fi <- paste('data/n', n, '.csv', sep="")
    ngr <- read.csv(fi, header=F)
    
    names(ngr) <- unlist(ln[[n]])
    tot <- sum(ngr$count)
    ngr$count <- ngr$count / tot
    return(ngr)
}


wordid <- function( w, di ) {
    return(match(w, di))
}


text.candidates <- function (n, ng, wordsids) {
    idx <- switch ( n, {
                NULL     
            }, {
                ng$x1 == wordsids[3]
            }, {
                ng$x1 == wordsids[2] & ng$x2 == wordsids[3]                 
            }, { 
                ng$x1 == wordsids[1] & ng$x2 == wordsids[2] & ng$x3 == wordsids[3]                 
            })
    ies <- data.frame(w=ng$y[idx], c=ng$count[idx])
    return(ies)
}

text.predict <- function (wordsids, n1, n2, n3, n4, weights=NULL) {
    c2 <- text.candidates(2, n2, wordsids)
    c3 <- text.candidates(3, n3, wordsids)
    c4 <- text.candidates(4, n4, wordsids)
    m <- merge(c2, c3, by="w", all=T)
    m <- merge(m, c4, by="w", all=T)
    names(m) <- c('w','c2','c3','c4')
    m$c1 <- n1[n1$y %in% m$w,]$count
    w <- m$w
    m$w <- NULL
    # weight.
    if (is.null(weights))
        weights<-c(0.25, 0.25, 0.25, 0.25)
    m <- data.frame(mapply(`*`,m, weights))

    return( w[which.max(rowSums(m, na.rm=T))] )
}

