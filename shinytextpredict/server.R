
# This is the server logic for a Shiny web application.

library(shiny)

# source("simpsons.R")
# fpredict <- simpsons.predict
source("helper.R")
fpredict <- text.predict

shinyServer(function(input, output, session) {
  
    # use of reactive values
    values <- reactiveValues()
    values$predictions <- fpredict("")
    
    # observe the userText.
    observe({
        text <- input$userText
        predictions <- fpredict(text)
        isolate(values$predictions <- predictions)
    })
    
    # use hidden labels to pass data to a control in ui.R
    output$addword1_label <- renderText({
        values$predictions[1]
    })
    # use hidden labels to pass data to a control in ui.R
    output$addword2_label <- renderText({
        values$predictions[2]
    })
    # use hidden labels to pass data to a control in ui.R
    output$addword3_label <- renderText({
        values$predictions[3]
    })
    
    # observe the button add 1
    observe({
        if (input$addword1 == 0) return()
        isolate({
            updateTextInput(session, "userText",
                            value = paste(input$userText, values$predictions[1]))
        })
    })
    # observe the button add 2
    observe({
        if (input$addword2 == 0) return()
        isolate({
            updateTextInput(session, "userText",
                            value = paste(input$userText, values$predictions[2]))
        })
    })
    # observe the button add 3
    observe({
        if (input$addword3 == 0) return()
        isolate({
            updateTextInput(session, "userText",
                            value = paste(input$userText, values$predictions[3]))
        })
    })
    # observe the button blahblah
    observe({
        if (input$blahblah == 0) return()
        isolate({
            v <- input$userText
            for (i in 1:30) {
                preds <- fpredict(v)
                n <- sample.int(3)[1]
                v <- paste(v, preds[n])
            }
            updateTextInput(session, "userText", value = v)
        })
    })
})  

