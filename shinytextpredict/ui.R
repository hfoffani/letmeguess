
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

shinyUI(fixedPage(

    theme = "bootstrap.min.css",
    
    titlePanel("Let me guess your next word"),
    
    h4("Insert some text here:"),
    inputTextarea("userText", "", 8, 50 ),
    checkboxInput("profanities", "Show profanity words", TRUE),
    h4("Your next word is:"),
    fixedRow(column(6,
        conditionalPanel(condition = "input.numPred == 1",
            actionButton("addword1", label = textOutput("addword1_label"),
                         class="btn btn-primary")),
        conditionalPanel(condition = "input.numPred == 3",
            actionButton("addword1b", label = textOutput("addword1b_label"),
                         class="btn btn-primary"),
            actionButton("addword2", label = textOutput("addword2_label"),
                         class="btn btn-info"),
            actionButton("addword3", label = textOutput("addword3_label"),
                         class="btn btn-info")))
    ),
    fixedRow(tags$ul(tags$li(), style="visibility:hidden;")),   # vert. spc.
    fixedRow(column(6,
        p("Get more info of this app at the",
        a(href="http://rpubs.com/herchu1/shinytextprediction",
          "web app presentation"),
        ".")
    )),
    fixedRow(tags$ul(
        tags$li(),
        tags$li(),
        style="visibility:hidden;")), # vert. spc.
    fixedRow(column(6,
        h4( "Extra features")
    )),
    fixedRow(column(6,
        p( "You can change the capstone requirement defaults."))),
    radioButtons("numPred", label = "Predicts",
                 choices = list("the requested one word" = 1,
                                "or two more words" = 3),
                 selected = 1),
    fixedRow(column(6,
        p( HTML("PAT (Phrase-Auto-Type&trade;) ;-)"))
    )),                     
    fixedRow(column(6,
        actionButton("blahblah",
                    label = "Hey Courserian, I can type a few words for you!",
                    class="btn btn-success"))
    ),
    fixedRow(column(6,
        p( "Words randomly chosen from the top three predictions.",
           class="small"))),
    fixedRow(tags$ul(
        tags$li(),
        tags$li(),
        style="visibility:hidden;")), # vert. spc.
    fixedRow(column(6,
        p( "Requires a modern browser with JavaScript enabled.",
           "Tested under OSX with Safari, Chrome and Firefox.",
           "Under Windows 2000 with IE 11.",
           "Also works with iOS Safari.",
           class="small")
    ))    
))
