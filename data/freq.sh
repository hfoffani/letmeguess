#!/bin/sh

for ng in 1 2 3 4
do
    now=`date "+%d/%m %H:%M"`
    echo freq ngram $ng - $now
    # echo stat ngram $ng - $now
    sort -m sn$ng.*.txt | uniq -c | sort -nr > freq.$ng.all.txt
done
now=`date "+%d/%m %H:%M"`
