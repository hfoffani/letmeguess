
# This is the server logic for a Shiny web application.

library(shiny)

# source("simpsons.R")
# fpredict <- simpsons.predict
source("helper.R")
fpredict <- text.predict

lastpred <- ''
shinyServer(function(input, output) {
  
#     addlastpred <- eventReactive(input$addword, {
#         paste(input$userText, ' ', output$predictedWord)
#     })

  output$predictedWord <- renderText({
      t <- paste('', input$userText)
      t <- fpredict(t)
      lastpred <- t
      t
      })

#   output$test<- renderText({
#       addlastpred()
#   })
})

# shinyServer(function(input, output, clientData, session) {
#     
#     observe({
#         currentUserText <- input$userText
#         output$predictedWord <- renderText({
#             t <- paste('', input$userText)
#             t <- fpredict(t)
#             lastpred <- t
#             t
#         })
# 
#         updateTextarea(session, "userText",
#             value = paste(currentUserText, ' ', lastpred)
#         )
#     })
# })

