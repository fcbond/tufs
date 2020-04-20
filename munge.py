###  -*- coding: utf-8 -*-
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
import sys

datadir = 'tufsdata'  # where the tufs data is downloaded to 
log = open('munge.log', 'w')



def read_bunrui_names(filename):
    """
    read the names of the bunrui concepts 
    we have them in four languages: en, ms, my, ja

    bunrui_name['4.50']['en'] = 'Animal calls'
    
    >>> bn = read_bunrui_names('tufsdata/bunrui_names.tsv')
    >>> dict(bn['4.50'])
    {'en': 'Animal calls', 'ms': 'Bunyi haiwan', 'my': 'တိရစ္တာန်များ၏အော်မြည်သံ', 'ja': '動物の鳴き声'}
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

def scrub(cell):
    """
    return a cleaned cell
    """
    cell = None if cell == '\\N' else cell
    return cell

def read_tables(datadir, lang):
    """Put all the data for  language in a table
    the key is the table name, 
    the first row contains the column names
    the following rows have the values
   
    If the data is '\\N', replace with None.
    Otherwise each element is a string.

    >>> data = read_tables('tufsdata', 'en') 
    >>> data['t_bunrui'][:3]
    [['bunrui_no', 'chukoumoku'], ['1.10', '事柄'], ['1.11', '類']]
    >>> data['t_word'][:2]
    [['id', 'basic', 'selected', 'index_char', 'sort_order'], 
     ['1208', 'word', '1', 'W', None]]

    """
    data = dd(list)
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
            data[state].append([scrub(c) for c in l.strip().split('\t')])
            
    return data

def fetch_data(datadir,langs):
    """
    Get the data for all the languages
    data = fetch_data('tufsdata', ['en', 'ja'])

    >>> data = fetch_data('tufsdata', ['en', 'ja'])
    >>> data['ja']['t_word'][:2]
    [['id', 'basic', 'selected', 'index_char', 'sort_order'], 
     ['1781', '東', '1', 'ひ', None]]
    >>> data['en']['t_word'][:2]
    [['id', 'basic', 'selected', 'index_char', 'sort_order'], 
     ['1208', 'word', '1', 'W', None]]

    """
    alldata = dict()
    for l in langs:
        alldata[l] = read_tables('tufsdata', l) 
    return alldata

def get_words(data):
    """
    get information about words, senses and more from the tables.

    word[lang][wid] = form  
    wid is language specific
    wid can be used to access the pronunciation
    url = 'http://www.coelang.tufs.ac.jp/mt/{}/vmod/sound/word/word_{}.mp3'.format(lang,wid)

    >>> data = fetch_data('tufsdata', ['en', 'ja'])
    >>> word = get_words(data)
    >>> word['en']['946']  
    'post office'
    >>> word['ja']['946']
    '写真'

    """
    word = dd(lambda: dd(str))
    for lang in data.keys():
       ### link words to their ids
       for  (id, basic, selected, index_char, sort_order) in data[lang]['t_word'][1:]:
           # only keep selected words
           if selected !=  "0":
               word[lang][id] = basic.strip()
    return word

def get_usage(data):
    """
    usage is like a gloss of the meaning

    usage[lang][uid] = (wid, usage)

    >>> data = fetch_data('tufsdata', ['en', 'ja'])
    >>> usage = get_usage(data)
    >>> usage['en']['215']          # usage ID
    ('946', '郵便局')              
    >>> usage['ja']['297']
    ('946', '【よみ】; しゃしん;【意味】; photograph')

    Note: escaped backslashes '\\' to '\\\\'

    """
    usage = dict()
    for lang in data.keys():
        usage[lang] = dict()
        for  (usage_id, word_id, explanation,
              disp_priority, selected) in data[lang]['t_usage'][1:]:
            if selected !=  0:
                ## check for duplicates (this never happened)
                if usage_id in usage[lang]:
                    print('WARNING usage_id used twice', usage_id, explanation, usage[lang][usage_id][1],
                          file=sys.stderr)
                explanation = re.sub(r'(\\n)+', ';', str(explanation)).strip(';').strip()
                usage[lang][usage_id] = (word_id, explanation)
    return usage


def get_concepts(data):
    """
    this links concepts to usage and more

    ## map the language internal usage id to the shared ID
    u2t[uid] = tid 

    >>> data = fetch_data('tufsdata', ['en', 'ja'])
    >>> u2t, bunrui_n, bunrui_c, bunrui_u = get_concepts(data)
    >>> u2t['ja']['297']
    '35159'
    >>> u2t['en']['297']
    '11443'

    ## bunrui word for this concept

    >>> bunrui_n['35159']
    '写真'
    >>> bunrui_n['23439']
    '郵便局'

    ## bunrui code for this concept

    >>> bunrui_c['35159']
    '1.3220'
    >>> bunrui_c['23439']
    '1.2720'

    ## bunrui usages for this concept

    >>> bunrui_u['35159']['en']
    ['454']
    >>> bunrui_u['23439']['ja']
    ['660']

    """
    u2t = dd(dict)

    ###
    ### The key is the classified_id
    ###
    bunrui = dict()
    bunrui_n = dict()  #
    bunrui_c = dict()  #t[50788] = '1.431' 
    bunrui_u = dd(lambda: dd(list))  # usage_id
    # from which we can get (word, wordid, explanation)
    #bunrui_we = dd(lambda: dd(list)) # explanation
    #bunrui_e = dd(lambda: dd(list))  # examples
    #super_w = dd(lambda: dd(list)) # super_w['1.40'][lang] = [w1, w2]

    for lang in data.keys():
        for (usage_id, classified_id, bunrui_no, chukoumoku_no, rui,
             bumon, chukoumoku, bunruikoumoku, midasi, hontai,
             yomirow) in data[lang]['t_usage_classified_rel'][1:]:
            # usage_id is the language internal thing
            # classified_id is the shared id (we call it the TUFS ID)
            #
            # links the usage_id to the supertype (and gives information about that)
            # bunrui[23439] = '郵便局'  name of category
            # bunrui_t[23439] = 1.272  number of category (rounded poorly in the db)
            # bunrui_w[23439] = [('post office', 946, '郵便局'), ..
            # super_w[23439] = []  list of words used by this supertype
            u2t[lang][usage_id] = classified_id  ## map the language internal usage id to the tufs ID
            bunrui_n[classified_id] = midasi  ## name of category, not language dependant
            bunrui_c[classified_id] = str(round(float(bunrui_no), 4)).ljust(6,'0')
            bunrui_u[classified_id][lang].append(usage_id)
            #bunrui_w[classified_id][lang].append((word[lang][usage[usage_id][0]],
            #                                      usage[usage_id][0],
            #                                      usage[usage_id][1]))
            #super_w[bunrui_t[classified_id][:4]][lang].append(word[lang][usage[usage_id][0]]) 
    return u2t, bunrui_n, bunrui_c, bunrui_u


def get_instances(data):
    """
    this gets the example sentences
    many also have translations into Japanese
    # instances (for examples)
    # inst[lang][iid] = (form, trans)

    >>> data = fetch_data('tufsdata', ['en', 'ja'])
    >>> inst, usage_inst = get_instances(data)
    >>> usage_inst['en']['215']
    ['859']

    # iid (instance ID) also links to pronounciation
    # url = 'http://www.coelang.tufs.ac.jp/mt/{}/vmod/sound/inst/inst_{}.mp3'.format(lang,iid)
    #  usage_inst[usage_id] = inst_id

    >>> inst['en']['859']
    ('I went to the post office to buy some stamps.',
                           '私は郵便局に切手を買いに行った。')

    """
    inst = dd(lambda: dd(tuple))
    usage_inst = dd(lambda: dd(list))
    for lang in data.keys():
        ## get the examples for each instance
        for (iid, targetlanguage, trans, function, pronun, explanation,
             module_id, xml_file_name, xpath, web_url, usage_id_rel,
             selected) in data[lang]['t_instance'][1:]:
            if selected == '1': #selected
                if targetlanguage.strip('\\n'): #only save if there is an example
                    inst[lang][iid] =  (targetlanguage.strip('\\n'),
                                        str(trans).strip('\\n'))
        ## get the examples for each usage
        for (uiid, usage_id, inst_id, disp_priority,
             token, token_index, ptoken, ptoken_indexrow) in data[lang]['t_usage_inst_rel']:
            #print(lang, uiid, usage_id, inst_id, token, token_index, ptoken, ptoken_indexrow, sep='\t')
            if inst_id in inst[lang]: # only add if there is an example
                usage_inst[lang][usage_id].append(inst_id)
       
    return inst, usage_inst

def clean(word, lang):
    """return a list of (word, thing:value)

       >>> clean('hot', 'en') 
       [('hot', '')]
       >>> clean('辣　là', 'zh')
       [('辣', 'orth:pīnyīn là')]
       >>> clean('طيّب (ـين)‏', 'as')  # note wierd ltr
       [('طيّب', 'morph:pl ـين')]
    """
    
    ### delete trailing newline and left-to-right mark
    if word.endswith('\\n'):
        word = word[:-3]
    word=word.replace('\u200f','')
    cleaned = []

    ### too hard to process
    if word in ["(…이/가) 되다",
                "sala (de aula)",
                "-arak/-erek (yürü-yerek)",
                "poderia (fazer) …"]:
        return [(word, '')]

    ### split and handle stuff in brackets
    
    for w in re.split(r'[/,]\s*',word):
        ### split on '/' or ',', not perfect but ok
        m = re.match(r'(.+) \((.+?)\)', w)
        if m: # remember bracketed stuff
            if lang in ['ar', 'as']: # Arabic gives plural
                cleaned.append((m.group(1), 'morph:pl '+m.group(2)))
            elif lang in ['ja']:  # it is a footnotemark
                cleaned.append((m.group(1), ''))
            elif lang in ['ms']:  # Malay gives us roots
                if m.group(1)[0] == 'm':
                    cleaned.append((m.group(2), 'morph:meN- '+m.group(1)))
                elif m.group(1)[0] == 'b':
                    cleaned.append((m.group(2), 'morph:ber- '+m.group(1)))
        elif lang == 'zh': # split pinyin
            #print(w)
            #print('zh', w)
            zhs = w.split() # single or multi
            cleaned.append((zhs[0], 'orth:pīnyīn ' + zhs[1]))
            if len(zhs) > 2:
                print('ERROR in pinyin', file=log)
        else:
            cleaned.append((w, ''))
        # if cleaned != [(word, '')]:
        #     print ("CLEANED:", lang, word, cleaned)
    return cleaned
    



def print_tsv(filename, data):
    """
    print out the data as tsv
    # "cid", "lang", "wid", "lemma", "meaning", "example"
    """
    word  = get_words(data)
    usage = get_usage(data)
    u2t, bunrui_n, bunrui_c, bunrui_u   = get_concepts(data)
    inst, usage_inst = get_instances(data)        
  
    with open(filename,'w') as t:
        ## sense[tid][lang] = [(wid, explanation, iid), (wid, explanation, iid) ]
        for l in usage:
            for u in usage[l]:
                tufs_id = u2t[l][u] if u in u2t[l] else None
                # if u not in u2t[l]:
                #     print ('WARNING unknown usage', l, u, usage[l][u][0],
                #            usage[l][u][1], usage_inst[l][u], file=sys.stderr)
                w = word[l][usage[l][u][0]]
                if w == '':
                    continue
                cleaned = []
                for (lem,typ) in clean(w,l):
                    if not typ:
                        cleaned.append(lem)
                    else:
                        cleaned.append(lem + ' (' + typ  + ')')
                examples = []
                for iid in usage_inst[l][u]: 
                    examples.append('|'.join(inst[l][iid]))
                print(tufs_id,             # tufs id
                      l,                   # language
                      usage[l][u][0],      # wid
                      "; ".join(cleaned),  #lemmas   
                      usage[l][u][1],      # usage explanation
                      ";".join(usage_inst[l][u]),    # iids  
                      ";;;".join(examples) if examples else '',          # examples  
                      sep='\t', file=t)

def l2l3(l):
    """convert the language name
    >>> l2l3('en')
    ('eng', 'English')
    >>> l2l3('as')
    ('apc', 'Arabic, Syrian')
    >>> l2l3('ar')
    ('arb', 'Arabic')
    """
    try:
        if l == 'pb':
            language= 'Por., Brazil'
            l3 ='por'
        elif l == 'ms':
            language= 'Malay'
            l3='zsm'
        elif l == 'as':
            language= 'Arabic, Syrian'
            l3='apc'
        elif l == 'ar':
            language= 'Arabic'
            l3='arb'
        elif l == 'zh':
            language= 'Chinese, Mandarin'
            l3='cmn' 
        else:
            language= languages.get(alpha2=l).name
            l3 = languages.get(alpha2=l).part3
    except:
        language=l
        l3='unk'
    return l3, language

                
# def print_html(filename, data):
#     """
#     print html
#     """
#     with open(filename,'w') as t:
        
#         print("""
# <HTML>
# <head>
# </head>
# <body>""", file=t)
#         print("""
# <hr>
# <p>Based on data from <a href='https://malindo.aa-ken.jp/TUFSOpenLgResources.html'>TUFS Open Language Resources</a>
# <p>This view created by Francis Bond
# </body>
# </html>""", file=t)

               #     stats=dd(int)
#     for b in sorted(bunrui, key=lambda x: bunrui_t[x]):
#         ### messy html
#         tid = b
#         print("""<h3><a name='{3}'>{0} ({1}: {2}) id={3}, pos={4}</a></h3>
#         """.format(bunrui[b], bunrui_t[b],
#                    st[bunrui_t[b][:4]]['en'], b,
#                    bunrui2pos[bunrui_t[b][0]]),
#               file=html)
#         print ("{} ({}: {}) id={}".format(bunrui[b], bunrui_t[b],
#                                        st[bunrui_t[b][:4]]['en'], b))
#         ws = [] # for dic matching
#         print("""    <table border>\n""", file=html)
     
#         print ("""    <tr>
#           <th>Language</th>
#           <th>Lemma</th>
#           <th>Cleaned</th>
#           <th>Meaning</th>
#           <th>Example</th>
#         </tr>""", file=html)
#         #print (sense[tid].keys()
#         for l in sorted(sense[tid].keys()):
#             stats[l] += len(sense[tid][l])
#             (wid, explanation, iid) = sense[tid][l]
#             w = word[l][wid]
#             if w == '':
#                 continue
#             cleaned = []
#             for (lem,typ) in clean(w,l):
#                 if not typ:
#                     cleaned.append(lem)
#                 else:
#                     cleaned.append(lem + ' (' + typ  + ')')
#                 ws.append(l2l3(l)[0] +'|' + lem)
#             ### print language
#             print("""  <tr>\n""", file=html)
#             print('<td>{}</td>'.format(l2l3(l)[1],l),file=html)
#     #         s= <img class='basicSound' src='./img/speaker_box_out.gif' id='sndmk_946'/>
#     # <a href='./sound/word/word_946.mp3'><img id='sndmk_0' class='wordSoundLink' src='./img/soundmark_out.gif'></a>
#     #	🔊
#             url='http://www.coelang.tufs.ac.jp/mt/{0}/vmod'.format(l)
#             print("""<td><a href='{0}/v_search_detail.php?id={1}'>{2}</a>
#             (<a href='{0}/sound/word/word_{1}.mp3'/>🔊</a>)</td>""".format(url,
#                                                                        wid,
#                                                                        w),file=html)
#             print("<td>{}</td>".format('; '.join(cleaned)),file=html)
#             print('<td>{}</td>'.format(explanation),file=html)
#             if inst[l][iid]:
#                 print("<td>{2} (<a href='{0}/sound/inst/inst_{1}.mp3'>🔊</a>)<br>{3}</td>".format(url,
#                                                                                                  iid,
#                                                                                                  inst[l][iid][0],
#                                                                                                  inst[l][iid][1]),file=html)
#             else:
#                 print('<td><br></td>', file=html)
#             print("""  </tr>\n""", file=html)
#         print("""    <table>\n""", file=html)
#         ### output for LUIS
#         if ws:
#             sens=bunrui[b] + ':' + bunrui_t[b]
#             comment='tufs_id='+b
#             print('TUFS', bunrui2pos[bunrui_t[b][0]], sens,
#                   ', '.join(ws),
#                   comment, '', '', '', '', '', '', '', 
#                   sep='\t',file=luis)
#     print("""<hr>
#     <p>Based on data from <a href='https://malindo.aa-ken.jp/TUFSOpenLgResources.html'>TUFS Open Language Resources</a>
#     <p>This view created by Francis Bond
#     </body>
#     </html>""",
#               file=html)
#     html.close()
                

                
def main():
    langs = ["ar", "as", "de", "en", "es", "fr", "id",
         "ja", 
         "km", "ko", "lo", "mn",
         "ms",
         "my",
         "pb", "pt", "ru", "th",
         "tl", "tr", "ur", "vi", "zh"]
    data  = fetch_data(datadir, langs)
    print_tsv('tufs-vocab.tsv', data)
    #print_html('onew.html',data)
    return None

if __name__ == "__main__":
    main()

 






# # 
# bunrui2pos = dd(lambda: '?')
# bunrui2pos['1'] = 'n'
# bunrui2pos['2'] = 'v'
# bunrui2pos['3'] = 'a'
# bunrui2pos['4'] = 'r'




# def main():
#     st =read_bunrui_names(datadir + "/bunrui_names.tsv")
#     luis =open ('luis-vocab.tsv','w')
#     html=open ('tufs-vocab.html','w')
#     print("""<HTML>
#       <head>
#       </head>
#       <body>""",
#               file=html)
    
#     stats=dd(int)
#     for b in sorted(bunrui, key=lambda x: bunrui_t[x]):
#         ### messy html
#         tid = b
#         print("""<h3><a name='{3}'>{0} ({1}: {2}) id={3}, pos={4}</a></h3>
#         """.format(bunrui[b], bunrui_t[b],
#                    st[bunrui_t[b][:4]]['en'], b,
#                    bunrui2pos[bunrui_t[b][0]]),
#               file=html)
#         print ("{} ({}: {}) id={}".format(bunrui[b], bunrui_t[b],
#                                        st[bunrui_t[b][:4]]['en'], b))
#         ws = [] # for dic matching
#         print("""    <table border>\n""", file=html)
     
#         print ("""    <tr>
#           <th>Language</th>
#           <th>Lemma</th>
#           <th>Cleaned</th>
#           <th>Meaning</th>
#           <th>Example</th>
#         </tr>""", file=html)
#         #print (sense[tid].keys()
#         for l in sorted(sense[tid].keys()):
#             stats[l] += len(sense[tid][l])
#             (wid, explanation, iid) = sense[tid][l]
#             w = word[l][wid]
#             if w == '':
#                 continue
#             cleaned = []
#             for (lem,typ) in clean(w,l):
#                 if not typ:
#                     cleaned.append(lem)
#                 else:
#                     cleaned.append(lem + ' (' + typ  + ')')
#                 ws.append(l2l3(l)[0] +'|' + lem)
#             ### print language
#             print("""  <tr>\n""", file=html)
#             print('<td>{}</td>'.format(l2l3(l)[1],l),file=html)
#     #         s= <img class='basicSound' src='./img/speaker_box_out.gif' id='sndmk_946'/>
#     # <a href='./sound/word/word_946.mp3'><img id='sndmk_0' class='wordSoundLink' src='./img/soundmark_out.gif'></a>
#     #	🔊
#             url='http://www.coelang.tufs.ac.jp/mt/{0}/vmod'.format(l)
#             print("""<td><a href='{0}/v_search_detail.php?id={1}'>{2}</a>
#             (<a href='{0}/sound/word/word_{1}.mp3'/>🔊</a>)</td>""".format(url,
#                                                                        wid,
#                                                                        w),file=html)
#             print("<td>{}</td>".format('; '.join(cleaned)),file=html)
#             print('<td>{}</td>'.format(explanation),file=html)
#             if inst[l][iid]:
#                 print("<td>{2} (<a href='{0}/sound/inst/inst_{1}.mp3'>🔊</a>)<br>{3}</td>".format(url,
#                                                                                                  iid,
#                                                                                                  inst[l][iid][0],
#                                                                                                  inst[l][iid][1]),file=html)
#             else:
#                 print('<td><br></td>', file=html)
#             print("""  </tr>\n""", file=html)
#         print("""    <table>\n""", file=html)
#         ### output for LUIS
#         if ws:
#             sens=bunrui[b] + ':' + bunrui_t[b]
#             comment='tufs_id='+b
#             print('TUFS', bunrui2pos[bunrui_t[b][0]], sens,
#                   ', '.join(ws),
#                   comment, '', '', '', '', '', '', '', 
#                   sep='\t',file=luis)
#     print("""<hr>
#     <p>Based on data from <a href='https://malindo.aa-ken.jp/TUFSOpenLgResources.html'>TUFS Open Language Resources</a>
#     <p>This view created by Francis Bond
#     </body>
#     </html>""",
#               file=html)
#     html.close()
#     luis.close()
    
            
#     fh =open('tufgoi.tex', 'w')
#     print("\\begin{tabular}{llrrrl} ", file=fh)
#     print("Language& & Concepts\t& Words & \% in WN & Comment \\\\\n\\hline ", file=fh)
#     total = dd(int)
#     for l in sorted(stats.keys()):
#         l3, language=l2l3(l)
#         shared=set()
#         bad =0
#         for i in word[l]:
#             #w = clean(i, l)[0][0]
#             w = word[l][i]
#             if (not w) or w=="":
#                 bad+=1
#                 continue
#             w = clean(w,l)[0][0]    
#             w_ = w.replace(' ','_')
#             try:
#                 if wn.synsets(w, lang=l3) or wn.synsets(w_, lang=l3): 
#                     shared.add(w)
#                 else:
#                     print('"{}" not found in wn ({})'.format(w,l))
#             except:
#                 True
#         print("{} & {}\t&{:6,d}\t&{:6,d} & {:d}\\\\".format(language, l,
#                                                           stats[l], len(word[l]),
#                                                           round(100* len(shared)/(len(word[l])-bad))
#         ), file=fh)
#         total['words'] += len(word[l])
#         total['concepts'] += stats[l]
#     print("{}\t&{:6,d}\t&{:6,d} \\\\".format('Total',
#                                        total['concepts'], total['words']), file=fh)
#     print("\\end{tabular}", file=fh)
#     fh.close()
    
#     for sp in  sorted(super_w.keys()):
#         lxn = dd(float)
#         for w in super_w[sp]['en']:
#             for l in wn.lemmas(w):
#                 lxn[l.synset().lexname()] += l.count() + .5
#         print (sp, st[sp]['en'], ",".join(super_w[sp]['en']), sep='\t')
#         stp = (0, 'Unknown')
#         if len(lxn.items()) > 0:
#             stp=sorted([(f,w) for (w, f) in lxn.items()])[-1]
        
#         print ('', '', stp, sep='\t')
#         #print ('', '', lxn, sep='\t')
        
# if __name__ == "__main__":
#     main()
