simpsons <- function() {
    dictionary <- "http://pastebin.com/raw.php?i=anKcMdvk"
    words <- read.table(dictionary, stringsAsFactors=F, skip=4, quote="", header=T)
    words$Frequency <- as.numeric( gsub("\\(|\\)", "", words$Frequency) )
    words$Probs <- words$Frequency / sum(words$Frequency)
    return(words)
}

simpsons.bartreplies <- function(dictionary) {
    s <- sample(nrow(dictionary), 1, prob=dictionary$Probs)
    return( dictionary$Word[s] )
}

simpsons.predict <- function(dummy1) {
    t <- simpsons.filter(dummy1)
    return (simpsons.bartreplies(simdict))
}

simdict <- simpsons()

simpsons.filter <- function(text) {
    # falta el tab y el return.
    regx <- '[^ \\.\'A-Za-z]'
    txt <- gsub(regx, '', text)
    txt <- gsub(".*\\.", " ", txt)
    txt <- gsub(" +", " ", txt)
    return (tolower(txt))
}
