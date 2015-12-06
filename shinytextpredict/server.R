
library(shiny)

source("helper.R")
fpredict <- text.predict

shinyServer(function(input, output, session) {
  
    # use of reactive values
    values <- reactiveValues()
    values$predictions <- c('','','') # fpredict("")
    
    # observe the userText.
    observe({
        # if (input$userText == "") return()
        text <- input$userText
        profi <- input$profanities
        isolate({
            predictions <- fpredict(text, profanities=profi)
            values$predictions <- predictions
        })
    })
    
    # use hidden labels to pass data to a control in ui.R
    output$addword1_label <- renderText({
        values$predictions[1]
    })
    output$addword1b_label <- renderText({
        values$predictions[1]
    })
    output$addword2_label <- renderText({
        values$predictions[2]
    })
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
    observe({
        if (input$addword1b == 0) return()
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
            n <- sample.int(3, 12, replace=T)
            sapply(n, function(i) {
                preds <- fpredict(v)
                v <<- paste(v, preds[i])
                i
            })
            updateTextInput(session, "userText", value = v)
        })
    })
})  

