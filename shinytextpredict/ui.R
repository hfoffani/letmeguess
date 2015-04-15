
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

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Guess next word"),
  
  # something
  sidebarPanel(
    # sliderInput("bins", "Number of bins:", min = 1, max = 50, value = 30)
  ),
  
  # Show a textbox and a text.
  mainPanel(
      inputTextarea('userText', '', 5, 70 ),
      # textInput('userText', label='write'),
      textOutput("predictedWord")
  )
))
