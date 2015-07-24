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

ecrive.net:
Jul 23, 2015 5:54:43 PM GMT - timestamp.txt
QhrUxSTvu+AweLVxmcAOElonOfZk4xFAWNWWmAMa+/c=

www.proofofexistence.com
Jul 23th, 2015. 20:00 aprox - timestamp.txt
hash: shasum -a 256 timestamp.txt
0c6dadd9c3bfedc81f521a550014c0d7910fb1483a0a16f5d5c525c0d8d24211
{"status": "confirmed", "transaction": "ee380ca171e169f04c07ff4d57fec83007c0f3347188c5ab2d919b24d6c5be68", "txstamp": "2015-07-23 21:26:03", "success": true}
http://www.proofofexistence.com/detail/0c6dadd9c3bfedc81f521a550014c0d7910fb1483a0a16f5d5c525c0d8d24211
check with:
curl -k -d d=0c6dadd9c3bfedc81f521a550014c0d7910fb1483a0a16f5d5c525c0d8d24211 http://www.proofofexistence.com/api/v1/status


# author:

Hernán Martínez-Foffani  DNI 53937903M (Spain)

