awk 'BEGIN {
        FS = "[ \t\n]+"
    } {
        for (i = 1; i <= NF; i++) {
            r = "";
            for ( j = 1; j < i; j++ ) {
                r = r " " $j;
            }
            printf "%s|%s\n", r, tolower($i);
        }
    }
' $*
