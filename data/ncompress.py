#!/usr/bin/python

import sys

DICTSIZE=10000
CUT=[DICTSIZE,1000000,1000000,1000000]

def process():
    print "building diccionary"
    fd="freq.1.all.txt"
    d = { '@': 1 }
    with open(fd) as if1:
        i=2
        for line in if1:
            parts = line.split()
            w = parts[1]
            if "@" in w: continue
            d[w] = i
            i+=1
            if i > DICTSIZE:
                break
    with open("di.csv","w") as odi:
        for k in sorted(d.iterkeys()):
            ol = str(d[k]) + "," + k + "\n"
            odi.write(ol)
    # sys.exit(0)

    for ng in [ 1,2,3,4 ]:
        print "building ngram", ng

        f2="freq.%d.all.txt" % ng
        fng = "n%d.csv" % ng
        with open(f2) as if2:
            with open(fng,"w") as ofng:
                j=0
                for line in if2:
                    parts = line.split()
                    # print len(parts),"--",parts
                    r = int(parts[0])
                    h = True
                    l = []
                    if len(parts) > ng:
                        for k in range(1,ng+1):
                            w = parts[k]
                            if w not in d:
                                h = False
                                break
                            l.append(d[w])
                        else:
                            l.append(r)
                    if l and h:
                        ol= ",".join(map(str,l)) + "\n"
                        ofng.write(ol)
                        j += 1    
                        if j >= CUT[ng-1]:
                            break
        


if __name__ == "__main__":
    import sys
    process()

