library(data.table)

di <- readRDS('data/di.rds')
n1 <- readRDS('data/n1.rds')
n2 <- readRDS('data/n2.rds')
n3 <- readRDS('data/n3.rds')
n4 <- readRDS('data/n4.rds')
profan <- readRDS('data/prof.rds')

TOTAL <- sum(n1$count)

text.read.dict <- function () {
    w <- read.csv('data/di.csv', header=F, stringsAsFactors=F)
    names(w) <- c('word','id')
    w <- data.table(w)
    setkey(w, word)
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
    return( di[J(w),]$id )
}
text.idword <- function( id, di) {
    return( di[id==wid,]$word )
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
    lastw <- wordsids[length(wordsids)]
    c2 <- text.candidates.n2(n2, wordsids)
    c3 <- text.candidates.n3(n3, wordsids)
    c4 <- text.candidates.n4(n4, wordsids)
    m <- merge(c2, c3, by="y", all=T, suffixes=c(".c2",".c3"))
    m <- merge(m, c4, by="y", all=T)
    m <- merge(m, n1, by="y", suffixes=c(".c4",".c1"))
    setnames(m, 1:5, c('w','c2','c3','c4','c1'))
    m$c1 <- m$c1 / TOTAL
    # doesn't improve if avoid repeating last word.
    # m$c1[lastw] <- 0
    w <- m$w
    m <- m[,c("c1","c2","c3","c4"),with=F]
    if (is.null(weights)) {
        # standard
        # weights <- c(0.25, 0.25, 0.25, 0.25)
        # best so far
        weights <- c(0.001, 0.05, 0.14, 0.809);
    }
    m <- data.frame(mapply(`*`,m, weights))
    # print(head(m))
    # print(head(w))
    top3 <- w[order(rowSums(m, na.rm=T), decreasing=T)][1:3]
    # top1 <- w[which.max(rowSums(m, na.rm=T))] 
    return( top3 )
}

text.cleanprof <- function(p) {
    clean <- ifelse(p %in% profan$word, sub('^(.).*', '\\1***', p), p)
    return( clean )
}


text.predict <- function (phrase, weights=NULL, profanities=T) {
    phrase <- text.filter(phrase)
    bag <- text.w(phrase)
    bag <- bag[!is.na(bag)]
    wid <- text.guessword(bag, n1, n2, n3, n4, weights)
    # wid <- NA . test predicting.
    if (length(wid) != 3 || is.na(wid))
        return(c("whatever","you","like"))
    # print(wid)
    df1 <- data.frame(di[id %in% wid,])
    df2 <- data.frame(v=wid, o=1:3)
    mg <- merge(df1, df2, by.x="id", by.y="v")
    # print(mg)
    w <- mg[order(mg$o)]$word
    if (!profanities)
        w <- text.cleanprof(w)
    return(w)
}

text.filter <- function(text) {
    # falta el tab y el return.
    regx <- '[^ \\.\'A-Za-z]'
    txt <- gsub(regx, ' ', text)
    txt <- gsub(".*\\.", " ", txt)
    txt <- paste("@ ", txt)
    txt <- gsub(" +", " ", txt)
    txt <- tolower(txt)
    return (txt)
}

text.w <- function (phrase) {
    l <- strsplit(phrase, " ", fixed=F)
    # bagwords <- unlist(l)
    bagwords <- .Internal(unlist(l,F,F))
    bag <- text.wordid(bagwords, di)
    bag <- bag[!is.na(bag)]
    return(bag)
}
