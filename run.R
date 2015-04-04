di <- text.read.dict()
n1 <- text.read.ngram(1)
n2 <- text.read.ngram(2)
n3 <- text.read.ngram(3)
n4 <- text.read.ngram(4)

text.predict(c(1,6,20),n1,n2,n3,n4)
