###
### Export data from TUFS
###

### Luis wants list of 12 tsv for wn linking
### DICNAME pos sense lang|lemma,lang|lemma (8 empty)
###


from collections import defaultdict as dd
import nltk
from nltk.corpus import wordnet as wn
from iso639 import languages
import re

datadir = 'tufsdata'  # where the tufs data is downloaded to 
log = open('munge.log', 'w')

### Three data types

## Lemmas

# word --- has wid (word ID) and form
# word[lang][wid] = form
word = dd(lambda: dd(str))

# wid also links to pronounciation
# url = 'http://www.coelang.tufs.ac.jp/mt/{}/vmod/sound/word/word_{}.mp3'.format(lang,wid)

## Instances

# instances (for examples)
# inst[lang][iid] = (form, trans)
inst = dd(lambda: dd(tuple))

# iid (instance ID) also links to pronounciation
# url = 'http://www.coelang.tufs.ac.jp/mt/{}/vmod/sound/inst/inst_{}.mp3'.format(lang,iid)

### TUFS Senses

# explanation 
# tid (tufs ID)
# sense[tid][lang] = [(wid, explanation, iid), (wid, explanation, iid) ]
sense = dd(lambda: dd(tuple))


def read_bunrui_names(filename):
    """
    read the names of the bunrui concepts 
    we have them in four languages: en, ms, my, ja

    bunrui_name['4.50']['en'] = 'Animal calls'
    """
    bunrui_name = dd(lambda: dd(str))
    fh = open(filename)
    for l in fh:
        #print(l)
        (code, en, ms, my, ja) = l.strip().split("\t")
        if code == 'Code':
            continue
        bunrui_name[code]['en'] = en
        bunrui_name[code]['ms'] = ms
        bunrui_name[code]['my'] = my
        bunrui_name[code]['ja'] = ja
    return bunrui_name
        
def read_lang(lang):
    """Put all the data for  language in a table
    the key is the table name, 
    the first row contains the column names
    the following rows have the values
    e.g.
    data['t_bunrui'] = [
    ['bunrui_no', 'chukoumoku'],
    ['1.10',	'事柄'], ...  ]

    Note that the data is always a string.
    """
    data = dd(list)
    keys = dd(list)
    fh = datadir + "/vmod_{}.sql".format(lang)
    state = None
    for l in open(fh):
        if 'COPY' in  l:
            row = l[5:-14].split(' (')
            #print(row)
            state = row[0]
            data[state].append(row[1].split(', '))
        elif l.startswith(r'\.'):
            state = None
        elif state:
            data[state].append(l.strip().split('\t'))
            
    return data

                                
#data = read_lang('en')
###
### The key is the classified_id
###
bunrui = dict()
bunrui_t = dict() # bunrui_t[50788] = '1.431' 
bunrui_w = dd(lambda: dd(list))  # (word, wordid, explanation)
bunrui_we = dd(lambda: dd(list)) # explanation
bunrui_e = dd(lambda: dd(list))  # examples
super_w = dd(lambda: dd(list)) # super_w['1.40'][lang] = [w1, w2]





# Take out "ja_th", "ja_zt",  "ms_my", "my_en", "my_ms",
# hope for Czech and Polish
for lang in ["ar", "as", "de", "en", "es", "fr", "id",
             "ja", 
             "km", "ko", "lo", "mn",
             "ms",
             "my",
             "pb", "pt", "ru", "th",
             "tl", "tr", "ur", "vi", "zh"]:
#for lang in ["en"]:    
    data = read_lang(lang)
    ### link words to their ids
    for  (id, basic, selected, index_char, sort_order) in data['t_word'][1:]:
        ### t_word['en'][946] = 'post office'
        # index by tw_id    
        #
        # only keep selected words
        #print ("words", lang, id, basic, selected)
        if selected !=  "0":
            word[lang][id] = basic.strip()

    usage = {}
    usage_byword = {}
    for  (usage_id, word_id, explanation, disp_priority, selected) in data['t_usage'][1:]:
        # links the usage id (the universal ID) to the word id (links to the translation)
        # usage[215]= (946, '郵便局')
        # usage_byword[946] = (215, '郵便局')
        if selected !=  0:
            ## check for duplicates (this never happened)
            if usage_id in usage:
                print('Used twice', usage_id, explanation, usage[usage_id][1], file=log)
            usage[usage_id] = (word_id, explanation)
            usage_byword[word_id] =  (usage_id, explanation)
    ## u2t[uid] = tid ## map the language internal usage id to the tufs ID
    u2t = dd(int)
    for (usage_id, classified_id, bunrui_no, chukoumoku_no, rui,
         bumon, chukoumoku, bunruikoumoku, midasi, hontai,
         yomirow) in data['t_usage_classified_rel'][1:]:
        # usage_id, classified_id, bunrui_no, chukoumoku_no, rui, bumon, chukoumoku, bunruikoumoku, midasi, hontai, yomi
        # usage_id is the language internal thing
        # classified_id is the shared id (we call TUFS ID)
        #
        # links the usage_id to the supertype (and gives information about that)
        # bunrui[23439] = '郵便局'  name of category
        # bunrui_t[23439] = 1.272  number of category (rounded poorly in the db)
        # bunrui_w[23439] = [('post office', 946, '郵便局'), ..
        # super_w[23439] = []  list of words used by this supertype
        u2t[usage_id] = classified_id  ## map the language internal usage id to the tufs ID
        bunrui[classified_id] = midasi
        bunrui_t[classified_id] = str(round(float(bunrui_no), 4)).ljust(6,'0')
        bunrui_w[classified_id][lang].append((word[lang][usage[usage_id][0]],
                                       usage[usage_id][0],
                                       usage[usage_id][1]))
        super_w[bunrui_t[classified_id][:4]][lang].append(word[lang][usage[usage_id][0]])
        ### pos
    # get examples
    #
    # inst['en'][859]= ('I went to the post office to buy some stamps.',
    #                   '私は郵便局に切手を買いに行った。')
    #
    for (iid, targetlanguage, trans, function, pronun, explanation,
         module_id, xml_file_name, xpath, web_url, usage_id_rel,
         selected) in data['t_instance'][1:]:
        if selected == '1': #selected
            #print('inst', lang, row[0], row[1], row[2])
            inst[lang][iid] =  (targetlanguage, trans)
            
    #link examples:
    #sense[215]['en'] = (946, 859)
    usage_inst = dd(lambda: None)
    for row in  data['t_usage_inst_rel']:
        #id, usage_id, inst_id, disp_priority, token, token_index, ptoken, ptoken_index
        # usage_inst[215] = 859
        usage_inst[row[1]] = row[2]
    # make sense
    ## sense[tid][lang] = [(wid, explanation, iid), (wid, explanation, iid) ]
    for u in usage:
        if u2t[u] == 0:
            print ('WARNING unknown usage', lang, u, usage[u][0],
                   usage[u][1], usage_inst[u], file=log)
        else:
            sense[u2t[u]][lang] = (usage[u][0], usage[u][1], usage_inst[u])

### debug
if __name__ == "__main__":
    print ('word in English is:', word['en']['1208'], '1208') #475
    print ('language in English is:', word['en']['1206'], '1206') #477
    #inst = dd(lambda: dd(tuple))
    print('TUFS ID', '30264', sense['30264']['en'])
    print('example for', '215', inst['en']['215'])
    print('usage:', '475', usage['475'])
    print('u2t[]:', '475', u2t['475'])
    print('TUFS ID', '30521', sense['30521']['en'])
    print('example for', '738', inst['en']['7385'])
    print('usage:', '477', usage['477'])
    print('u2t[]:', '477', u2t['477'])

# 
bunrui2pos = dd(lambda: '?')
bunrui2pos['1'] = 'n'
bunrui2pos['2'] = 'v'
bunrui2pos['3'] = 'a'
bunrui2pos['4'] = 'r'

def l2l3(l):
    """convert the language name"""
    try:
        if l == 'pb':
            language= 'Por. in Brazil'
            l3 ='por'
        elif l == 'ms':
            language= 'Malay'
            l3='zsm'
        elif l == 'as':
            language= 'Arabic in Syria'
            l3='arb'
        elif l == 'ar':
            language= 'Arabic'
            l3='arb'
        elif l == 'zh':
            language= 'Mandarin Chinese'
            l3='cmn' 
        else:
            language= languages.get(alpha2=l).name
            l3 = languages.get(alpha2=l).part3
    except:
        language=l
        l3='unk'
    return l3, language

def clean(word, lang):
    """return a list of (word, thing:value)
       ('hot', 'en') =>   (hot, '')
       ('辣　là', zh) =>  (辣, 'pinyin:là')
       ('طيّب (ـين)‏', as) => ('طيّب', '???:ـين') #reversed
    """
    ### delete trailing newline and left-to-right mark
    if word.endswith('\\n'):
        word = word[:-3]
    word=word.replace('\u200f','')
    cleaned = []
    ### split on '/' or ',', not perfect but ok
    for w in re.split(r'[/,]\s*',word):
        
        m = re.match(r'(.+) \((.+?)\)', w)
        if m: # remember bracketed stuff
            cleaned.append((m.group(1), 'brk:'+m.group(2)))   
        elif lang == 'zh': # split pinyin
            #print(w)
            #print('zh', w)
            zhs = w.split() # single or multi
            cleaned.append((zhs[0], 'py:'+ zhs[1]))
            if len(zhs) > 2:
                print('ERROR in pinyin', file=log)
        else:
            cleaned.append((w, ''))
        #word = re.sub(r'(.+) \((.+?)\)', r'brk:\1 ', word)
#    cleaned = [word]

    return cleaned
    


### nice tsv format
# "cid", "lang", "wid", "lemma", "meaning", "example"
with open('tufs-vocab.tsv','w') as t:
    for cid in sorted(sense.keys(),key=int):
        for l in sense[cid]:
            (wid, exp, iid) = sense[cid][l]
            w = word[l][wid]
            if w == '':
                continue
            cleaned = []
            for (lem,typ) in clean(w,l):
                if not typ:
                    cleaned.append(lem)
                else:
                    cleaned.append(lem + ' (' + typ  + ')')
            print(cid, l, wid, "; ".join(cleaned),
                  exp,
                  "|".join(inst[l][iid]),
                  sep='\t',file=t)


def main():
    st =read_bunrui_names(datadir + "/bunrui_names.tsv")
    luis =open ('luis-vocab.tsv','w')
    html=open ('tufs-vocab.html','w')
    print("""<HTML>
      <head>
      </head>
      <body>""",
              file=html)
    
    stats=dd(int)
    for b in sorted(bunrui, key=lambda x: bunrui_t[x]):
        ### messy html
        tid = b
        print("""<h3><a name='{3}'>{0} ({1}: {2}) id={3}, pos={4}</a></h3>
        """.format(bunrui[b], bunrui_t[b],
                   st[bunrui_t[b][:4]]['en'], b,
                   bunrui2pos[bunrui_t[b][0]]),
              file=html)
        print ("{} ({}: {}) id={}".format(bunrui[b], bunrui_t[b],
                                       st[bunrui_t[b][:4]]['en'], b))
        ws = [] # for dic matching
        print("""    <table border>\n""", file=html)
     
        print ("""    <tr>
          <th>Language</th>
          <th>Lemma</th>
          <th>Cleaned</th>
          <th>Meaning</th>
          <th>Example</th>
        </tr>""", file=html)
        #print (sense[tid].keys()
        for l in sorted(sense[tid].keys()):
            stats[l] += len(sense[tid][l])
            (wid, explanation, iid) = sense[tid][l]
            w = word[l][wid]
            if w == '':
                continue
            cleaned = []
            for (lem,typ) in clean(w,l):
                if not typ:
                    cleaned.append(lem)
                else:
                    cleaned.append(lem + ' (' + typ  + ')')
                ws.append(l2l3(l)[0] +'|' + lem)
            ### print language
            print("""  <tr>\n""", file=html)
            print('<td>{}</td>'.format(l2l3(l)[1],l),file=html)
    #         s= <img class='basicSound' src='./img/speaker_box_out.gif' id='sndmk_946'/>
    # <a href='./sound/word/word_946.mp3'><img id='sndmk_0' class='wordSoundLink' src='./img/soundmark_out.gif'></a>
    #	🔊
            url='http://www.coelang.tufs.ac.jp/mt/{0}/vmod'.format(l)
            print("""<td><a href='{0}/v_search_detail.php?id={1}'>{2}</a>
            (<a href='{0}/sound/word/word_{1}.mp3'/>🔊</a>)</td>""".format(url,
                                                                       wid,
                                                                       w),file=html)
            print("<td>{}</td>".format('; '.join(cleaned)),file=html)
            print('<td>{}</td>'.format(explanation),file=html)
            if inst[l][iid]:
                print("<td>{2} (<a href='{0}/sound/inst/inst_{1}.mp3'>🔊</a>)<br>{3}</td>".format(url,
                                                                                                 iid,
                                                                                                 inst[l][iid][0],
                                                                                                 inst[l][iid][1]),file=html)
            else:
                print('<td><br></td>', file=html)
            print("""  </tr>\n""", file=html)
        print("""    <table>\n""", file=html)
        ### output for LUIS
        if ws:
            sens=bunrui[b] + ':' + bunrui_t[b]
            comment='tufs_id='+b
            print('TUFS', bunrui2pos[bunrui_t[b][0]], sens,
                  ', '.join(ws),
                  comment, '', '', '', '', '', '', '', 
                  sep='\t',file=luis)
    print("""<hr>
    <p>Based on data from <a href='https://malindo.aa-ken.jp/TUFSOpenLgResources.html'>TUFS Open Language Resources</a>
    <p>This view created by Francis Bond
    </body>
    </html>""",
              file=html)
    html.close()
    luis.close()
    
            
    fh =open('tufgoi.tex', 'w')
    print("\\begin{tabular}{llrrrl} ", file=fh)
    print("Language& & Concepts\t& Words & \% in WN & Comment \\\\\n\\hline ", file=fh)
    total = dd(int)
    for l in sorted(stats.keys()):
        l3, language=l2l3(l)
        shared=set()
        bad =0
        for i in word[l]:
            #w = clean(i, l)[0][0]
            w = word[l][i]
            if (not w) or w=="":
                bad+=1
                continue
            w = clean(w,l)[0][0]    
            w_ = w.replace(' ','_')
            try:
                if wn.synsets(w, lang=l3) or wn.synsets(w_, lang=l3): 
                    shared.add(w)
                else:
                    print('"{}" not found in wn ({})'.format(w,l))
            except:
                True
        print("{} & {}\t&{:6,d}\t&{:6,d} & {:d}\\\\".format(language, l,
                                                          stats[l], len(word[l]),
                                                          round(100* len(shared)/(len(word[l])-bad))
        ), file=fh)
        total['words'] += len(word[l])
        total['concepts'] += stats[l]
    print("{}\t&{:6,d}\t&{:6,d} \\\\".format('Total',
                                       total['concepts'], total['words']), file=fh)
    print("\\end{tabular}", file=fh)
    fh.close()
    
    for sp in  sorted(super_w.keys()):
        lxn = dd(float)
        for w in super_w[sp]['en']:
            for l in wn.lemmas(w):
                lxn[l.synset().lexname()] += l.count() + .5
        print (sp, st[sp]['en'], ",".join(super_w[sp]['en']), sep='\t')
        stp = (0, 'Unknown')
        if len(lxn.items()) > 0:
            stp=sorted([(f,w) for (w, f) in lxn.items()])[-1]
        
        print ('', '', stp, sep='\t')
        #print ('', '', lxn, sep='\t')
        
if __name__ == "__main__":
    main()
