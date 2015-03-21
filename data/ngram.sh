#!/bin/sh

awk -v n=$1 'BEGIN {
    for (i=0; i < n; i++) {
        c[i] = "";
    }
} {
    for (i=1; i < n; i++) {
        c[i-1] = c[i];
    }
    c[n-1]=$0;
    buf = "";
    for (i=0; i < n; i++) {
        if (c[i] == "")
            next;
        buf = buf c[i] " ";
    }
    print buf;

}' $2 |
sed -e 's/ $//'

