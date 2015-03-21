#!/bin/sh

sed -e "s/[^[:alpha:]]*[[:<:]]\([[:alpha:]\']*\)[[:>:]][^[:alpha:]]*/\1|/g" $1 |
#awk '{ print tolower($0) }' |
tr '[:upper:]' '[:lower:]' |
tr '|' '\n' |
sed -e "/^$/d" |
cat

