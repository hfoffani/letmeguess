simpsons <- function() {
    dictionary <- "http://pastebin.com/raw.php?i=anKcMdvk"
    words <- read.table(dictionary, stringsAsFactors=F, skip=4, quote="", header=T)
    words$Frequency <- as.numeric( gsub("\\(|\\)", "", words$Frequency) )
    words$Probs <- words$Frequency / sum(words$Frequency)
    return(words)
}

bartreplies <- function(dictionary) {
    s <- sample(nrow(dictionary), 1, prob=dictionary$Probs)
    return( dictionary$Word[s] )
}

simpsons.predict <- function(dummy1, dummy2) {
    return (bartreplies(simdict))
}
