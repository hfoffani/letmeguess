#!/bin/sh

sort $1 |
uniq -c |
sort -nr

