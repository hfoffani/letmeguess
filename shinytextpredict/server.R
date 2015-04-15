
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

# source("simpsons.R")
# fpredict <- simpsons.predict
source("helper.R")
fpredict <- text.predict


shinyServer(function(input, output) {
  
  output$predictedWord <- renderText({
      # t <- 'hola'
      # t <- paste('@', ' ', input$userText)
      t <- paste('', input$userText)
      t <- fpredict(t)
      t
      })
})
