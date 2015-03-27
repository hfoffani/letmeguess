
N=2
F="-f3"

#N=3
#F="-f2 -f3"

#N=4
#F="-f1 -f2 -f3"

echo QUIZ 2
echo ngram $N
echo

f() {
echo $1
s=`echo $1 |cut $F -d" "`
shift
for w in $*
do
    g="$s $w"
    echo grep $g freq.$N.*.txt
done
echo
echo
}

f "a case of"  cheese soda pretzels beer
#f "would mean the"
#f "make me the"
#f "date at the"
#f "be on my"
#f "in quite some"

