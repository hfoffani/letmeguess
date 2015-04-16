
# This is the server logic for a Shiny web application.

library(shiny)

# source("simpsons.R")
# fpredict <- simpsons.predict
source("helper.R")
fpredict <- text.predict

shinyServer(function(input, output, session) {
  
    # use of reactive values
    values <- reactiveValues()
    values$prediction <- fpredict("")
    
    # observe the userText.
    observe({
        text <- input$userText
        prediction <- fpredict(text)
        isolate(values$prediction <- prediction)
    })
    
    # use a hidden label to pass data to a control in ui.R
    output$addword_label <- renderText({
        values$prediction
    })
    
    # observe the button
    observe({
        if(input$addword == 0) return()
        isolate({
            updateTextInput(session, "userText",
                            value = paste(input$userText, values$prediction))
        })
    })

})  

