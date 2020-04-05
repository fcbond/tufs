##
## read and give stats for the checked file
##
from collections import defaultdict as dd

#links = dd(set)
links = dict()
hlinks = dd(set)
mlinks = dd(set)
label = dict()
final = dd(lambda: dd(set))

for l in open("merged.tsv"):
    r = l.strip().split('\t')
    if len(r) == 8:
        label[r[0].strip()] = r[6].strip()[:-7]
        if r[0].strip() not in links:
            links[r[0].strip()] = set()
        if r[5].strip() == 'T' :
            links[r[0].strip()].add(r[1].strip())
        elif r[5].strip() == 'H' :
            hlinks[r[0].strip()].add(r[1].strip())
        elif r[5].strip() == 'M' :
            mlinks[r[0].strip()].add(r[1].strip())
        elif r[5].strip() != 'F' :
            print('What?', l)
        if r[5].strip() in 'TMH':
            final[r[0].strip()][r[5].strip()].add(r[1].strip())
            
    # else:
    #     print('Shortie?', l)
        
stats = dd(set)
for t,l in links.items():
    stats[len(l)].add(t)
    pos = set(x[-1] for x in l)
    if len(pos) > 1:
        print ("POS: ", t, label[t], l)
    elif t in hlinks:
        print ("HYPO: ", t, label[t], l)
    elif(len(l) == 0):
        print ("ZERO:", label[t], t)
    
    #print (t,l)

for n,f in stats.items():
    sample = [(label[t], t) for t in list(f)[:3]]
    print(n,len(f),sample,links[sample[0][1]])

sr = {'T':'synonym', 'H':'hyponym', 'M':'multi' }

out = open('tufs-omw-map.tsv', 'w')
print('Final')
for t in final:
    for link in final[t]:
        for synset in final[t][link]:
            print(t, sr[link],
                  synset, sep='\t', file=out)
out.close()
        
    
