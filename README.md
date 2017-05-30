## Let Me Guess

Predict next word.

A working app in https://herchu.shinyapps.io/shinytextpredict


Web app hosted in [shinyapps.io](http://shinyapps.io) (developed in R)



### Internals

4-gram Model with Linear Interpolation Smoothing

*30,000* words dictionary, unigram to tetagram tables.
2-3-4-grams have *1 million* entries each
(*MLE; frequencies >= 3*.)

n-grams tuples include begin-of-sentence tokens.

Achieves *16% accuracy* for the first word and *26%*
within the best three. *Independently scored by
[benchmark.R](https://github.com/jan-san/dsci-benchmark)*

Words in the ngram tables are integer coded: less char strings
results in a *50MB* total memory footprint.

One line in R (*fast!*) gets the most probable next word:

    head(order(rowSums(sweep(ngrams,2,weights,`*`)),decreasing=T),n=1)


### Training Data Set ###

The dataset comes from [HC Corpora](www.corpora.heliohost.org).
Details [here](http://www.corpora.heliohost.org/aboutcorpus.html).
It be downloaded [here] (https://d396qusza40orc.cloudfront.net/dsscapstone/dataset/Coursera-SwiftKey.zip).


### Pre-process

Add UTF-8 BOM and change to unix line endings.

With the help of some scripts extract the n-grams lists.
Tool: tokenize.sh
Uses: towords.sh, sample.sh, ngram.sh

Obtain the frequencies of all the ngrams files.
Tool: freq.sh

Compress the sets by reducing to the X most popular words
and to Y[n] most popular n-grams and coding the words in binary.
Tool: ncompress.py



### Running the app locally.

Within RStudio:

* open the project under shinytextpredict
* open either server.R or ui.R
* then click on run app


### Other tests

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


### Authentications

** BTProof **

    18TdkvQ8ojaDfe5i4v7i1HbdjJgNQDthjw
    previous commit date: July 23th, 2015. 19:20 in bitcoin chain since: Ago 20th, 2015. 18:24:22 GMT+0200 (CEST)
    commit hash: d43aa820dd1ed7ebe0bfa673d18c706a9e0def6d

** ecrive.net  **

    Jul 23, 2015 5:54:43 PM GMT - timestamp.txt
    QhrUxSTvu+AweLVxmcAOElonOfZk4xFAWNWWmAMa+/c=

** proofofexistence.com  **

    Jul 23th, 2015. 20:00 aprox - timestamp.txt
hash:

    shasum -a 256 timestamp.txt
    c6dadd9c3bfedc81f521a550014c0d7910fb1483a0a16f5d5c525c0d8d24211
    "status": "confirmed", "transaction": "ee380ca171e169f04c07ff4d57fec83007c0f3347188c5ab2d919b24d6c5be68", "txstamp": "2015-07-23 21:26:03", "success": true}

check with http://www.proofofexistence.com/detail/0c6dadd9c3bfedc81f521a550014c0d7910fb1483a0a16f5d5c525c0d8d24211 or:

    curl -k -d d=0c6dadd9c3bfedc81f521a550014c0d7910fb1483a0a16f5d5c525c0d8d24211 http://www.proofofexistence.com/api/v1/status



### Who do I talk to? ###

For questions or requests post an issue here or tweet me at
[@herchu](http://twitter.com/herchu)


