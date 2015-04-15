
# This is the server logic for a Shiny web application.

library(shiny)

# source("simpsons.R")
# fpredict <- simpsons.predict
source("helper.R")
fpredict <- text.predict


shinyServer(function(input, output) {
  
  output$predictedWord <- renderText({
      t <- paste('', input$userText)
      t <- fpredict(t)
      t
      })
})
