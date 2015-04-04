loadfiles <- function() {
    di <- text.read.dict()
    n1 <- text.read.ngram(1)
    n2 <- text.read.ngram(2)
    n3 <- text.read.ngram(3)
    n4 <- text.read.ngram(4)
    assign("di", di, envir=.GlobalEnv)
    assign("n1", n1, envir=.GlobalEnv)
    assign("n2", n2, envir=.GlobalEnv)
    assign("n3", n3, envir=.GlobalEnv)
    assign("n4", n4, envir=.GlobalEnv)
}

# text.guessoword(c(1,6,20),n1,n2,n3,n4)
# text.guessword(c(1,6),n1,n2,n3,n4)

# text.predict('how are you')
# text.predict('how is she')
