#!/bin/sh

# usage: sh sample-val.sh temp/en_US*.txt

# 50% to train
# awk '{ if (NR % 10 < 5) print $0}' $1

# unseen for validation
( awk '{ if (NR % 10 == 6) print $0}' $1
  awk '{ if (NR % 10 == 6) print $0}' $2
  awk '{ if (NR % 10 == 6) print $0}' $3
) |
awk '{ if (NR % 1000 == 1) print $0}' |
./towords.sh |
./ngram.sh 4 |
sed 's/ \([^ ]*\)$/,\1/'

