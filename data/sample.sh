#!/bin/sh

# 70% to train
awk '{ if (NR % 10 < 7) print $0}' $1
