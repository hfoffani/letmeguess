
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

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
    # cat('predicting\n')
    return (bartreplies(simdict))
}

simdict <- simpsons()

filter <- function(text) {
    # falta el tab y el return.
    regx <- '[^ \\.\'A-Za-z]'
    txt <- gsub(regx, '', text)
    txt <- gsub(".*\\.", " ", txt)
    txt <- gsub(" +", " ", txt)
    return (tolower(txt))
}


shinyServer(function(input, output) {
  
  output$predictedWord <- renderText({
      # t <- 'hola'
      # t <- paste('@', ' ', input$userText)
      t <- paste('', input$userText)
      t <- filter(t)
      t <- simpsons.predict(t,'xxx')
      t
      })
})
