
# This is the user-interface definition of a Shiny web application.

library(shiny)

inputTextarea <- function(inputId, value="", nrows, ncols) {
    tagList(
        singleton(tags$head(tags$script(src = "textarea.js"))),
        tags$textarea(id = inputId,
                      class = "inputtextarea",
                      rows = nrows,
                      cols = ncols,
                      as.character(value))
    )
}

shinyUI(fluidPage(
    
    theme = "bootstrap.css",
    
    titlePanel("Let me guess your next word"),
    
    sidebarLayout(
        position = "right",
        sidebarPanel(
            h5( "Requires a modern browser with JavaScript enabled.",
                "Tested under OSX with Safari, Chrome and Firefox.",
                "Under Windows 2000 with IE 11.",
                "Also works with iOS Safari."),
            radioButtons("numPred", label = "Predict",
                         choices = list("1 word" = 1, "3 words" = 3),
                         selected = 1)
        ),
        mainPanel(
            h4("Add some text here:"),
            inputTextarea("userText", "", 8, 50 ),
            checkboxInput("profanities", "Show profanity words", TRUE),
            h4("Your next word is:"),
            fluidRow(
                column(6,
                       conditionalPanel(condition = "input.numPred == 1",
                                        actionButton("addword1", label = textOutput("addword1_label"))),
                       conditionalPanel(condition = "input.numPred == 3",
                                        actionButton("addword1b", label = textOutput("addword1b_label")),
                                        actionButton("addword2", label = textOutput("addword2_label")),
                                        actionButton("addword3", label = textOutput("addword3_label"))))
            ),
            h4(""),
            fluidRow(
                column(6,
                       actionButton("blahblah", label = "Hey Courserian, I can type a few words for you!"))
            )
        )
    )
))
