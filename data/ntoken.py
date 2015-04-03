DICTSIZE=100
CUT=10000

def process():
    print "building diccionary"
    fd="freq.1.all.txt"
    d = {}
    with open(fd) as if1:
        i=1
        for line in if1:
            parts = line.split()
            w = parts[1]
            d[w] = i
            i+=1
            if i > DICTSIZE:
                break
    with open("di.csv","w") as odi:
        for it in d.items():
            ol=",".join(map(str,it)) + "\n"
            odi.write(ol)

    for ng in [ 1,2 ]:
        print "building ngram", ng

        f2="freq.%d.all.txt" % ng
        fng = "n%d.csv" % ng
        if2 = open(f2)
        with open(fng,"w") as ofng:

            for line in if2:
                parts = line.split()
                r = int(parts[0])
                if r <= CUT:
                    continue
                h = True
                l = []
                for i in range(1,ng+1):
                    w = parts[i]
                    if w not in d:
                        h = False
                        break
                    l.append(d[w])
                else:
                    l.append(r)
                if l and h:
                    ol= ",".join(map(str,l)) + "\n"
                    ofng.write(ol)
        


if __name__ == "__main__":
    import sys
    process()

