#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr  5 10:52:56 2020

@author: abond
"""

from collections import defaultdict as dd
from munge import l2l3
import re


tufsOmwMap = 'tufs-omw-map.tsv'
tufsVocab = 'tufs-vocab.tsv'
#oNew = 'onew.tsv'


### The TUFS to OMW mapping only considers concepts with at least 15 translations!
##  This will be assumed in the code below.


def synToCid(filename):
    '''
    Maps the synonym set in the OMW to the conceptID found in TUFS.
    
    Args:
        filename (str): name of the tsv file
        
    Returns: 
        dict: synset --> list of conceptIDs

    Examples:
        >>> syns = synToCid('tufs-omw-map.tsv')
        >>> syns['10332385-n']
        ['16496', '16507']
        >>> syns['00109151-r']
        ['9986']
    '''
    sc = dd(list) # synset can have multiple conceptIDs
    fh = open(filename)
    for l in fh:
        row = l.strip().split('\t')
        if row[1] == 'synonym':
            sc[row[2]].append(row[0])
    return sc
    


def cidInfo(filename):
    '''
    Stores information from tufs-vocab.tsv in a contextually meaningful way.

    Args:
        filename (str): name of the tsv file

    Returns:
        dict: conceptID --> (language, comment, lemma, example)
        set: unique set of languages

    Examples:
        >>> info, langs = cidInfo('tufs-vocab.tsv')
        >>> info['9986'][1]
        ('en',
         'そこ,そちら, そっち',
         'there',
         "Yeah, but I don't want to go there. |うん、でもぼくはそっちには行きたくないなあ。")
        >>> info['20281'][4]
        ('fr', '留学生。外国人の学生。;＊女性形はétudiante étrangère。', 
         'étudiant étranger; étudiante étrangère (morph:f)', 
         'Voici la résidence pour les étudiants étrangers.|これが留学生のための宿舎です。')
        >>> info['163'][0]
        ('fr',
         'どれ。;＊単数女性形laquel、複数男性形lesquels、複数女性形lesquelles。',
         'lequel; laquel (morph:f:sg); lesquels (morph:m:sg); lesquelles (morph:f:pl)',
         'Avec la télévision par câble, il y a beaucoup de chaînes. 
          Je ne sais lesquelles choisir.|ケーブルテレビはたくさんチャンネルがあって、どれを選んでいいのかわかりません')
        >>> 'ko' in langs
        True
    '''
    fh = open(filename)
    info, langs = dd(list), set()
    morph = {                              ### gender:grammatical number
            '複数形': 'pl',                        # plural
            '<女>': 'f',                          # female
            '単数女性形': 'f:sg',                 # female:singular
            '複数男性形': 'm:pl',                # masculine:plural
            '男性複数形': 'm:pl',                # masculine:plural
            '複数女性形': 'f:pl',               # female:plural
            '女性複数形': 'f:pl',               # female:plural
            '女性形': 'f',                    # female
            '可数名詞単数形': 'count:sg',     # count:singular
            '双数形': 'du'                  # dual
    }
    for ln in fh:
#        print(ln)
        cid, lng, wid, lem, com, uid, exe = ln.strip('\n').split('\t')
        langs.add(lng)
#        matches = re.findall(r'''(<女>|\w+[性数]形)(?:は|\s*:\s*|\s*：\s*)?([\w ]+)''', com.replace('\u200f', ''))
        matches = re.findall(r'''(<女>|[可数名詞双男女性単複]+[性数]形)(?:[は\u200f]|\s*:\s*|\s*：\s*)?([\w ،-٩]+)''', # need to
                             com.replace('\u200f', ''))                          # consider Arabic diacritics
        if matches:
#            print('MATCHES:', cid, matches, lem, com, sep='\t')
            known = [l + ' (morph:' + morph[m] + ')'          # adding more lemmas!!!
                     for m, l in matches 
                     if m in morph and l[0] not in 'のを名で'] # there's still a couple bugs!
#            print(known)
            if known:
                lem += '; ' + '; '.join(known)
            else:
                unknown = [(l, m) for m, l in matches if m not in morph or l[0] in 'のを名で']
#                print('WARNING: unknown morphology', unknown)
        if exe:
            info[cid].append((lng,                                        # language        
                              com.replace('\u3000', ' '),                 # comment
                              lem,                                        # lemma
                              exe.replace('\u3000', ' ')))
        else:
            info[cid].append((lng,                                        # language
                              com.replace('\u3000', ' '),                 # comment
                              lem,                                        # lemma
                              None))                # example
    return info, langs

# adds roughly 100 more lemmas by going through comment

def initWordnet(lgs):
    '''
    Initialises wordnets for each language in a tsv format.
    
    Args:
        languages (set): a set of language names which are strings
    
    Returns:
        Nothing! It prints the first line of metadata for each wordnet
    '''
    fh = dict()
    for l in lgs:
        fh[l] = open('tufs-vocab-{}.tsv'.format(l), 'w')
        print('\t'.join(['# TUFS Basic {} Wordnet'.format(l2l3(l)[1]),      # title
                         l2l3(l)[0],                                        # iso633; three letter abbreviation
                         'http://www.coelang.tufs.ac.jp/mt/{}/'.format(l),  # source
                         'CC BY 4.0']),                                     # license
              file = fh[l])



def writeToWNs(syns, info):
    '''
    Writes data into the wordnets.
    
    Args:
        dict: synset --> list of conceptIDs
        dict: conceptID --> (language, comment, lemma, example)
    
    Returns:
        Nothing! It simply prints the data into the appropriate columns,
        which were created previously in initWordnet()
    '''
    for k in syns:                                                    # loops through synsets
        for c in syns[k]:                                              # loops through conceptIDs
            for lng, com, lem, exe in info[c]:                          # loops through list of tuples
                l3 = l2l3(lng)[0]
                langlem = l3 + ':lemma'
                langexe = l3 + ':exe'
                fh = open('tufs-vocab-{}.tsv'.format(lng), 'a')
                if '; ' in lem:
                    for w in lem.split('; '):
                        print('\t'.join([k, langlem, w.replace('\u200f', '')]), file=fh)
                else:
                    print('\t'.join([k, langlem, lem.replace('\u200f', '')]), file=fh)
                if exe: # checking if list of examples is empty
                    exes = exe.strip().split(';;;')
                    for e in exes: # loops through examples
                        e = e.split('|')[0].replace('\u200f', '')       # removes Japanese gloss
                        print('\t'.join([k, langexe, e]), file=fh)



def readAllWNs():
    '''
    Reads all the wordnets to i)  check that everything is working.
                              ii) stores wordnet data for later use.
    
    Args:
        None
    
    Returns:
        dict: languages --> list with metadata (column headers) as elements
        dict: synset --> "lemmas" or "examples" --> list of lemmas or list of exes
        
    Examples:
        >>> titles, data = readAllWNs()
        >>> list(titles.keys())                                                         # lang check
        ['ar', 'as', 'de', 'en', 'es', 'fr', 'id', 'ja', 'km', 'ko', 
        'lo', 'mn', 'ms', 'my', 'pb', 'pt', 'ru', 'th', 'tl', 'tr', 'ur', 'vi', 'zh']
        >>> titles['es']
        ['TUFS Basic Spanish Wordnet', 'spa', 'http://www.coelang.tufs.ac.jp/mt/es/', 'CC BY 4.0']
        >>> dict(data['03147509-n']['th'])                                              # cup
        {'lemmas': ['ถ้วย'], 'examples': ['นี่เป็นถ้วยที่เพื่อนซื้อให้เป็นของขวัญวันเกิด']}
        >>> dict(data['04971928-n']['ja'])                                              # brown
        {'lemmas': ['茶色'], 'examples': ['木村さんの\u3000髪の\u3000色は\u3000茶色です。']}
        >>> dict(data['03623556-n']['fr'])                                              # knife / blade
        {'lemmas': ['couteau', 'couteaux (morph:pl)'], 
         'examples': ["Je n'ai pas de couteau pour couper ma viande."]}
        >>> dict(data['10112591-n']['de'])                                              # friend
        {'lemmas': ['Freund', 'Freundin (morph:f)'], 
         'examples': ['Ein Freund hat ihn über den Unfall unterrichtet.', 
                      'Da kommt eine japanische Freundin zu mir.']}
        >>> dict(data['01725051-v']['ms'])                                              # play
        {'lemmas': ['bermain (morph:root main)'], 
         'examples': ['Saya akan bermain piano pada konsert bulan depan.']}
    '''
    langs = ['ar', 'as', 'de', 'en', 'es', 'fr', 'id', 'ja', 'km', 'ko', 'lo', 
             'mn', 'ms', 'my', 'pb', 'pt', 'ru', 'th', 'tl', 'tr', 'ur', 'vi', 'zh']
    titles = dict()
    data = dd(lambda: dd(lambda: dd(list)))
    for lg in langs:
        fh = open('tufs-vocab-{}.tsv'.format(lg))
        titles[lg] = fh.readline().strip()[2:].split('\t')
        for ln in fh:           
            row = ln.strip().split('\t')
#            print(row)
            if row[1][4:] == "lemma":
                data[row[0]][lg]["lemmas"].append(row[2])
            elif row[1][4:] == "exe": 
                data[row[0]][lg]["examples"].append(row[2]) 
            else:    # additional info like definitions could be added / defensive
                print('WARNING:', 'unknown type', row)
    return titles, data



def main():
    syns = synToCid(tufsOmwMap)
    info, langs = cidInfo(tufsVocab)
    initWordnet(langs)
    writeToWNs(syns, info) # currently not considering multiple example sentences
    readAllWNs()
    return None

if __name__ == "__main__":
    main()

### C'est Fini!
