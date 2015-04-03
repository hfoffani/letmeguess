
N=2
F="-f3"

N=3
F="-f2 -f3"

N=4
F="-f1 -f2 -f3"

echo QUIZ 3
echo ngram $N
echo

f() {
echo $1
s=`echo $1 |cut $F -d" "`
shift
for w in $*
do
    g="$s $w"
    grep "$g" freq.$N.*.txt
done
echo
echo
}

#f "a case of"  cheese soda pretzels beer
#f "Very early observations on the Bills game: Offense still struggling but the"
#f "struggling but the" crowd referees players defense

#f "would mean the"
#f "make me the"
#f "date at the"
#f "be on my"
#f "in quite some"

f "live and i'd" give sleep eat die
#f "me about his" horticultural spiritual marital financial
#f "artic monkeys this" decade month weekend morning
#f "helps reduce your" happiness hunger stress sleepniness
#f "to take a" look walk picture minute

#f "to settle the" account case matter incident
#f "groceries in each" arm hand finger toe

#f "bottom to the" middle top center side

#f "bruises from playing" outside weekly inside daily

#f "of adam sandler's" pictures movies stories novels



