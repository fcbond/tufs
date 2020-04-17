#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Apr  5 10:52:56 2020

@author: abond
"""

from collections import defaultdict as dd
from munge import l2l3


tufsOmwMap = 'tufs-omw-map.tsv'
tufsVocab = 'tufs-vocab.tsv'


### The TUFS to OMW mapping only considers concepts with at least 15 translations!
##  This will be assumed in the code below.

def synToCid(filename):
    '''
    Maps the synonym set in the OMW to the conceptID found in TUFS.
    
    Args:
        filename (str): name of the tsv file
        
    Returns: 
        dict: synset --> list of conceptIDs

    Example:
        >>> syns = synToCid('tufs-omw-map.tsv')
        >>> syns['15210045-n']
        ['14674']
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
        
syns = synToCid(tufsOmwMap)
    

def cidInfo(filename):
    '''
    Stores information from tufs-vocab.tsv in a contextually meaningful way.

    Args:
        filename (str): name of the tsv file

    Returns:
        dict: conceptID --> (language, comment, lemma, example)
        set: unique set of languages

    Example:
        >>> info, langs = cidInfo('tufs-vocab.tsv')
        >>> info['9986'][1]
        ('en',
         'そこ,そちら, そっち',
         'there',
         "Yeah, but I don't want to go there. |うん、でもぼくはそっちには行きたくないなあ。")
        >>> 'ko' in langs
        True
    '''
    fh = open(filename)
    cid, lgs = dd(list), set()
    for l in fh:
        row = l.strip().split('\t')
        lgs.add(row[1])
        if len(row) < 6:
            cid[row[0]].append((row[1], row[4], row[3], None))
        else:
            cid[row[0]].append((row[1], row[4], row[3], row[5]))
    return cid, lgs
    
info, langs = cidInfo(tufsVocab)


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
        print('\t'.join(['# TUFS Basic {} Wordnet'.format(l2l3(l)[1]), # title
                         l2l3(l)[0], # iso633; three letter abbreviation
                         'http://www.coelang.tufs.ac.jp/mt/{}/'.format(l), # source
                         'CC BY 4.0']), # license
              file = fh[l])

initWordnet(langs)


def writeToWns(syns, info):
    '''
    Writes data into the wordnets.
    
    Args:
        dict: synset --> list of conceptIDs
        dict: conceptID --> (language, comment, lemma, example)
    
    Returns:
        Nothing! It prints the data into the appropriate columns that
        were created before
    '''
    for k in syns: # loops through synsets
        for c in syns[k]: # loops through conceptIDs
            for lng, com, lem, exe in info[c]: # loops through list of tuples
                l3 = l2l3(lng)[0]
                langlem = l3 + ':lemma'
                langexe = l3 + ':exe'
                fh = open('tufs-vocab-{}.tsv'.format(lng), 'a')
                if '; ' in lem:
                    for w in lem.split('; '):
                        print('\t'.join([k, langlem, lem]), file=fh)
                else:
                    print('\t'.join([k, langlem, lem]), file=fh)
                if exe != None:
                    exe = exe.split('|')[0] # removes Japanese gloss
                    print('\t'.join([k, langexe, exe]), file=fh)

writeToWns(syns, info) # currently not considering multiple example sentences

### C'est Fini!