awk '
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function alfa(s) { gsub(/[^[a-zA-Z'\'']/, "", s ); return tolower( s ) }
BEGIN {
    FS = "[ \t\n]+"
} {
    if (NR % 10 == 7) { # && NR % 10000 == 7) {
        for (i = 1; i <= NF; i++) {
            r = "";
            for ( j = 1; j < i; j++ ) {
                r = r " " $j;
            }
            printf "%s|%s\n", ltrim(r), alfa($i);
        }
    }
} ' $*
