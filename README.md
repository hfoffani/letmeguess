## textpredict

Predict next word.

### pre-process

Add UTF-8 BOM and change to unix line endings.

With the help of some scripts extract the n-grams lists.
Tool: tokenize.sh
Uses: towords.sh, sample.sh, ngram.sh

Obtain the frequencies of all the ngrams files.
Tool: freq.sh



### transforms to csv

Compress the sets by reducing to the X most popular words
and to Y[n] most popular n-grams and coding the words in binary.
Tool: ncompress.py



### this project

source testalgo.R
then run:

    test.accuracy( tq, text.predict )
    
for benchmarking, source benchmark.R
then run:

    benchmark(predict.baseline, 
          sent.list = list('quizzes' = quizzes, 
                           'tweets' = tweets, 
                           'blogs' = blogs), 
          ext.output = T)

for profiling, source testalgo.R
the run:

    tmp <- lineprof( lineprof_textpredict() )
    shine(tmp)


# running the app.

open the project under shinytextpredict
open either server.R or ui.R
then click on run app


# Authentications

1st. BTproof: 1AZSUBcy8D9r67KGYHjgDuSZtnWuYWxDdm
irrecoverable

2nd. BTProof: 18TdkvQ8ojaDfe5i4v7i1HbdjJgNQDthjw
previous commit date: July 23th, 2015. 19:20
hash d43aa820dd1ed7ebe0bfa673d18c706a9e0def6d


# author:

Hernán Martínez-Foffani  DNI 53937903M (Spain)

