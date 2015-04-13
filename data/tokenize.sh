#!/bin/sh

# blogs news twitter
for x in $*
do
    now=`date "+%d/%m %H:%M"`
    echo BEGIN $x - $now
    f=en_US.$x.txt
    s=sample.$x.txt
    now=`date "+%d/%m %H:%M"`
    echo sampling - $now
    ./sample.sh $f > $s
    now=`date "+%d/%m %H:%M"`
    echo words - $now
    ./towords.sh $s > n1.$x.txt
    now=`date "+%d/%m %H:%M"`
    echo ngram 2 - $now
    ./ngram.sh 2 n1.$x.txt > n2.$x.txt
    now=`date "+%d/%m %H:%M"`
    echo ngram 3 - $now
    ./ngram.sh 3 n1.$x.txt > n3.$x.txt
    now=`date "+%d/%m %H:%M"`
    echo ngram 4 - $now
    ./ngram.sh 4 n1.$x.txt > n4.$x.txt

    for ng in 1 2 3 4
    do
        now=`date "+%d/%m %H:%M"`
        echo sort ngram $ng - $now
        sort n$ng.$x.txt > sn$ng.$x.txt
    done
    now=`date "+%d/%m %H:%M"`
    echo END $x - $now
done
