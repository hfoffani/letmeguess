# 1. read files.
# 2. split words.
#   2.1 lower.
# 3. count words.
# 4. histograms.

wrd <- function (f) {
fname <- paste("en_US.", f, ".txt", sep="")
corpus <- load.corpus(fname, corpus.dir = "data")
words <- txt.to.words.ext(corpus, language = "English.contr")
# ng2 <- make.ngrams(words, ngram.size=2)
# ng3 <- make.ngrams(words, ngram.size=3)
# fwords <- as.data.frame(table(words), stringsAsFactors=F)
return (words)
}

