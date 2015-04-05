library(data.table)

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
    # tot <- sum(ngr$count)
    # ngr$count <- ngr$count / tot
    dfngr <- data.table(ngr)
    switch (n, {
        setkey(dfngr, y)
    }, {
        setkey(dfngr, x1) 
    }, {
        setkey(dfngr, x1, x2)
    }, {
        setkey(dfngr, x1, x2, x3)
    })
    return(dfngr)
}

text.wordid <- function( w, di ) {
    return( di[match(w, di$word),]$id )
}

text.candidates <- function (n, ng, wordsids) {
    l <- length(wordsids)
    idx <- switch ( n, {
                NULL     
            }, {
                if (l >= 1) {
                    ng[J(wordsids[l]),
                        c('y','count'),with=F]
                } else
                    data.table(y=integer(0), count=numeric(0))
            }, {
                if (l >= 2) {
                    ng[J(wordsids[l-1],wordsids[l]),
                        c('y','count'),with=F]
                } else
                    data.table(y=integer(0), count=numeric(0))
            }, {
                if (l >= 3) {
                    ng[J(wordsids[l-2],wordsids[l-1],wordsids[l]),c('y','count'),with=F]
                } else
                    data.table(y=integer(0), count=numeric(0))
            })
    # ies <- data.frame(w=idx$y, c=idx$count)
    return(idx)
}

text.candidates.n2 <- function (n2, wordsids) {
    l <- length(wordsids)
    if (l >= 1) {
        w <- wordsids[l]
        res <- n2[J(w), c('y','count'), with=F]
        res$count <- res$count / sum(res$count)
        return(res)
    }
    return( data.table(y=integer(0), count=numeric(0)) )
}

text.candidates.n3 <- function (n3, wordsids) {
    l <- length(wordsids)
    if (l >= 2) {
        w2 <- wordsids[l]
        w1 <- wordsids[l-1]
        res <- n3[J(w1,w2), c('y','count'), with=F]
        res$count <- res$count / sum(res$count)
        return(res)
    }
    return( data.table(y=integer(0), count=numeric(0)) )
}

text.candidates.n4 <- function (n4, wordsids) {
    l <- length(wordsids)
    if (l >= 3) {
        w3 <- wordsids[l]
        w2 <- wordsids[l-1]
        w1 <- wordsids[l-2]
        res <- n4[J(w1,w2,w3), c('y','count'), with=F]
        res$count <- res$count / sum(res$count)
        return(res)
    }
    return( data.table(y=integer(0), count=numeric(0)) )
}

text.guessword <- function (wordsids, n1, n2, n3, n4, weights=NULL) {
    c2 <- text.candidates.n2(n2, wordsids)
    c3 <- text.candidates.n3(n3, wordsids)
    c4 <- text.candidates.n4(n4, wordsids)
    m <- merge(c2, c3, by="y", all=T, suffixes=c(".c2",".c3"))
    m <- merge(m, c4, by="y", all=T)
    m <- merge(m, n1, by="y", suffixes=c(".c4",".c1"))
    setnames(m, 1:5, c('w','c2','c3','c4','c1'))
    m$c1 <- m$c1 / TOTAL
    w <- m$w
    # m$w <- NULL
    m <- m[,c("c1","c2","c3","c4"),with=F]     
    # weight.
    if (is.null(weights))
        weights<-c(0.25, 0.25, 0.25, 0.25)
    m <- data.frame(mapply(`*`,m, weights))
    # print(m)
    return( w[which.max(rowSums(m, na.rm=T))] )
}

text.predict <- function (phrase, weights=NULL) {
    bag <- text.w(phrase)
    bag <- bag[!is.na(bag)]
    wid <- text.guessword(bag, n1, n2, n3, n4, weights)
    if (!length(wid) || is.na(wid))
        return("Whatever!")
    w <- di[di$id==wid,]$w
    return(w)
}

text.w <- function (phrase) {
    bagwords <- unlist(strsplit(phrase, ' '))
    bag <- text.wordid(bagwords, di)
    return(bag)
}
