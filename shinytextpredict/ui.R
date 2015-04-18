
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
    
    titlePanel("Guess next word"),
    
    sidebarLayout(position = "right",
                  sidebarPanel(
                      "sidebar panel"
                      ),
                  mainPanel(
                      inputTextarea("userText", "", 5, 70 ),
                      textOutput("_a_place_holder_"),
                      radioButtons("numpred", label = "Predict",
                                   choices = list("1 word" = 1, "3 words" = 2),
                                   selected = 1),
                      fluidRow(
                        actionButton("addword1", label = textOutput("addword1_label")),
                        actionButton("addword2", label = textOutput("addword2_label")),
                        actionButton("addword3", label = textOutput("addword3_label"))
                      )
                  )
    )
))
