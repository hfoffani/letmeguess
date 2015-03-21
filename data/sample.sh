#!/bin/sh

# 50% to train
awk '{ if (NR % 10 < 5) print $0}' $1
