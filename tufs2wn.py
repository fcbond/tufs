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

### Making a synset to cid mapping

def synToCid(filename):
    '''Maps the synonym set in the OMW to the concept id found in TUFS'''
    sc = dd(list) # synset can have multiple cids
    fh = open(filename)
    for l in fh:
        row = l.strip().split('\t')
        if row[1] == 'synonym':
            sc[row[2]].append(row[0])
    return sc
        
syns = synToCid(tufsOmwMap)

### Storing cid info in a dictionary
    
def cidInfo(filename):
    '''Stores the information from tufs-vocab.tsv to process it into a format
       suitable for the OMW
       cid: a dictionary to store essential info
       lgs: set of languages'''
    fh = open(filename)
    cid, lgs = dd(list), set() # cid info, language set
    for l in fh:
        row = l.strip().split('\t')
        lgs.add(row[1])
        if len(row) < 6:
            cid[row[0]].append((row[1], row[4], row[3], None)) # language, comment, lemma
        else:
            cid[row[0]].append((row[1], row[4], row[3], row[5])) # language, comment, lemma, example
    return cid, lgs # dictionary of lists of tuples, set
    
info, langs = cidInfo(tufsVocab)

#print(langs)

### Initialising wordnet tsv files in the required format

def initWordnet(lgs):
    '''Initialises wordnets for each language'''
    fh = dict()
    for l in lgs:
        fh[l] = open('tufs-vocab-{}.tsv'.format(l), 'w')
        print('\t'.join(['# TUFS Basic {} Wordnet'.format(l2l3(l)[1]), l2l3(l)[0], 
                         'http://www.coelang.tufs.ac.jp/mt/{}/'.format(l),
                         'CC BY 4.0']), file = fh[l])

initWordnet(langs) # initialise wn tsv files

def writeToWns(syns, info):
    '''A function that writes the required columns to the 
       initialised wn tsv files.
       syns: a dictionary that maps synset to cids
       info: a dictionary of lists of tuples with info'''
    for k in syns: # loops through synsets
        for c in syns[k]: # loops through cids
            if c not in info:
                continue
            for lng, com, lem, exe in info[c]: # loops through list of tuples
                l3 = l2l3(lng)[0]
                col2lem = l3 + ':lemma'
                col2exe = l3 + ':exe'
                fh = open('tufs-vocab-{}.tsv'.format(lng), 'a') # opens the file for appending
                if '; ' in lem:
                    for w in lem.split('; '):
                        print('\t'.join([k, col2lem, lem]), file=fh)
                else:
                    print('\t'.join([k, col2lem, lem]), file=fh)
                if exe != None:
                    exe = exe.split('|')[0] # removes Japanese gloss
                    print('\t'.join([k, col2exe, exe]), file=fh)

#print(info['19186'][11][2].split('; '))

writeToWns(syns, info)
