#
# Take an OMW 1.0 wordnet TSV and convert to WN-LMF 1.1
#

from typing import Optional, Tuple, Dict, TextIO
import sys
from pathlib import Path
from collections import Counter
from pprint import pprint

import wn

from wn.lmf import (
    dump,
    Lexicon,
    Metadata,
    LexicalEntry,
    Lemma,
    Pronunciation,
    Form,
    Sense,
    Count,
    Example,
    Synset,
    Definition,
    LexicalResource
)

if __name__ == '__main__':
    from util import escape_lemma, load_ili_map
else:
    from .mymodule import escape_lemma, load_ili_map


LMF_VERSION = '1.1'


# CONSTANTS ############################################################

bcp47 = {
    "als": "sq",        # Albanian
    "arb": "arb",       # Arabic
    "bul": "bg",        # Bulgarian
    "cmn": "cmn-Hans",  # Mandarin Chinese (Simplified)
    "qcn": "cmn-Hant",  # Mandarin Chinese (Traditional)
    "dan": "da",        # Danish
    "ell": "el",        # Greek
    "eng": "en",        # English
    "fas": "fa",        # Farsi
    "fin": "fi",        # Finnish
    "fra": "fr",        # French
    "heb": "he",        # Hebrew
    "hrv": "hr",        # Croation
    "isl": "is",        # Icelandic
    "ita": "it",        # Italian
    "jpn": "ja",        # Japanese
    "cat": "ca",        # Catalan
    "eus": "eu",        # Basque
    "glg": "gl",        # Galician
    "spa": "es",        # Spanish
    "ind": "id",        # Indonesian
    "zsm": "zsm",       # Standard Malay
    "nld": "nl",        # Dutch
    "nno": "nn",        # Norwegian (Norsk)
    "nob": "nb",        # Norwegian (Bokmal)
    "pol": "pl",        # Polish
    "por": "pt",        # Portuguese
    "ron": "ro",        # Romanian
    "lit": "lt",        # Lithuanian
    "slk": "sk",        # Slovak
    "slv": "sl",        # Slovene
    "swe": "sv",        # Swedish
    "tha": "th",        # Thai
}

open_license = {
    'CC BY 3.0': 'https://creativecommons.org/licenses/by/3.0/',
    'CC-BY 3.0': 'https://creativecommons.org/licenses/by/3.0/',
    'CC BY 4.0': 'https://creativecommons.org/licenses/by/4.0/',
    'CC BY SA 3.0': 'https://creativecommons.org/licenses/by-sa/3.0/',
    'CC BY-SA': 'https://creativecommons.org/licenses/by-sa/',
    'CC BY SA': 'https://creativecommons.org/licenses/by-sa/',
    'CC BY SA 4.0': 'https://creativecommons.org/licenses/by-sa/4.0/',
    'Apache 2.0': 'https://opensource.org/licenses/Apache-2.0',
    'CeCILL-C': 'http://www.cecill.info/licenses/Licence_CeCILL-C_V1-en.html',
    'MIT': 'https://opensource.org/licenses/MIT/',
    'wordnet': 'wordnet',
    'unicode': 'https://www.unicode.org/license.html',
    'ODC-BY 1.0': 'http://opendefinition.org/licenses/odc-by/'
}


# MAIN FUNCTION ########################################################

def convert(
    source: str,
    outfile: str,
    lexid: str,
    label: str,
    language: str,
    email: str,
    license: str,
    version: str,
    url: Optional[str] = None,
    citation: Optional[str] = None,
    logo: Optional[str] = None,
    requires: Optional[dict] = None,
    meta: Optional[dict] = None,
    ilimap: Optional[Dict[str, str]] = None,
    logfile: Optional[TextIO] = None,
):
    if logfile is None:
        logfile = sys.stderr

    lex = Lexicon(
    id=lexid,
    label=label,
    language= bcp47.get(language, language),
    email=email,
    license=license,
    version=version,
    url=url,
    citation=citation,
    logo=logo,
    meta=meta,
    )
   
    if requires:
        if 'requires' in lex:
            lex['requires'].append(requires)
        else:
            lex['requires'] = []
            
    if ilimap is None:
        ilimap = {}

    entries, senses, synsets = load(source, lex, ilimap, logfile)
    #print('\nENTRIES\n')
    #pprint(entries)
    # print('\nSENSES\n')
    # pprint(senses)
    # print('\nSYNSETS\n')
    # pprint(synsets)

    build(lex, entries, senses, synsets, logfile)

    lre = LexicalResource(lmf_version = LMF_VERSION,
                          lexicons = [lex])
    
    dump(lre, outfile)


# DATA LOADING AND VALIDATION ##########################################

def load(source: str, lex: Lexicon, ilimap: Dict[str, str], logfile: TextIO):
    entries = {}
    senses = {}
    synsets = {}

    with open(source, 'rt') as tabfile:
        label, lang, url, license = _check_header(tabfile, lex, logfile)
        prefix = f'{lang}:'
        for line in tabfile:
            if not line.strip() or line.startswith('#'):
                continue
            offset_pos, type_, *content = line.strip().split('\t')
            offset_pos = offset_pos.strip()

            ili = ilimap.get(offset_pos)
            if ili is None:
                ili = ''

            ssid = synset_id(lex['id'], offset_pos)
            pos = ssid[-1]
            if ssid not in synsets:
                synsets[ssid] = {'pos': pos, 'ili': ili,
                                 'members': [], 'def': [], 'exe': []}
            ss = synsets[ssid]

            type_ = type_.removeprefix(prefix)  # only match for current language
            if type_ == 'lemma':
                lemma = _clean_lemma(content[0], logfile)
                eid = entry_id(lex['id'], lemma, pos)
                if eid not in entries:
                    entries[eid] = {'lemma': lemma, 'pos': pos, 'senses': []}
                sid = sense_id(lex['id'], lemma, offset_pos[:-2], pos)
                entries[eid]['senses'].append(sid)
                senses[sid] =  {'id': ssid}
                ss['members'].append(sid)
            elif type_ == 'count':
                ### it always comes after the sense
                lemma, count = content
                lemma = _clean_lemma(content[0], logfile)
                sid = sense_id(lex['id'], lemma, offset_pos[:-2], pos)
                senses[sid]['count'] = int(count.strip())
            elif type_ == 'pron':
                if len(content) < 2:
                    print(f'No Pronunciation: {line.strip()}', file=logfile)
                    continue
                lemma = _clean_lemma(content[0], logfile)
                eid = entry_id(lex['id'], lemma, pos)
                ### we could have multiple pronunciations
                entries.setdefault(eid, {}).setdefault('pron', set()).add(tuple(content[1:]))

                        
            elif type_ in ('def', 'exe'):
                order, text = content
                ss[type_].append((int(order), text.strip()))

            else:
                print(f'IGNORING: {line.strip()}', file=logfile)

    return entries, senses, synsets


def _check_header(
    tabfile: TextIO,
    lex: Lexicon,
    logfile: TextIO
) -> Tuple[str, str, str, str]:
    if not tabfile.buffer.peek(1).startswith(b'#'):
        print('NO META DATA', file=logfile)
        label = lang = url = license = 'n/a'
    else:
        header = next(tabfile).lstrip('#').strip()
        label, lang, url, license = header.split('\t')
        if lang not in bcp47:
            print(f'UNKNOWN LANGUAGE: {lang}', file=logfile)
        elif bcp47[lang] != lex['language']:
            print('INDEX INCONSISTENT WITH SOURCE: '
                  f"{bcp47[lang]} != {lex['language']}",
                  file=logfile)
        if license not in open_license:
            print(f'UNKNOWN LICENSE: {license}', file=logfile)
        elif open_license[license] != lex['license']:
            print('INDEX INCONSISTENT WITH SOURCE: '
                  f"{open_license[license]} != {lex['license']}",
                  file=logfile)
    return label, lang, url, license


def _clean_lemma(lemma: str, logfile: TextIO) -> str:
    lemma = lemma.strip()
    if lemma.startswith('"') and lemma.endswith('"'):
        lemma = lemma[1:-1]
        print('CLEANED: {} (removed start and end double quote)'.format(lemma),
              file=logfile)
    if '"' in lemma:
        print('WARNING: {} (contains a double quote)'.format(lemma),
              file=logfile)
    lemma = lemma.replace('_', ' ')
    return lemma


# LEXICON BUILDING AND VALIDATION ######################################

def build(
    lex: Lexicon,
    entries: dict,
    senses: dict,
    synsets: dict,
    logfile: TextIO
) -> None:
    lex['entries'] = []
    lex['synsets'] = []
    for eid, entry in entries.items():
        sids = set(entry['senses'])
        # validate senses
        sense_counts = Counter(entry['senses'])
        for sid, count in (sense_counts - Counter(sids)).items():
            print(f'REDUNDANT SENSE: {sid} ({count + 1} occurrences)',
                  file=logfile)
        sns = []
        for sid in sids:
            if 'count' in senses[sid]:
                sns.append(Sense(id = sid,
                                 counts = [ Count(value = senses[sid]['count']) ],
                                 synset = senses[sid]['id']))
            else:
                sns.append(Sense(id = sid,
                                 synset = senses[sid]['id']))


        if 'pron' in entry:
            prons = []
            for p in entry['pron']:
                prons.append(Pronunciation(
                    text = p[0],
                    variety = p[1] if len(p) > 1 else '',
                    audio = p[2] if len(p) > 2 else '',
                    notation = p[3] if len(p) > 3 else '',
                    ))
            lex['entries'].append(
                LexicalEntry(
                    id = eid,
                    lemma = Lemma(writtenForm = entry['lemma'],
                                  partOfSpeech = entry['pos'],
                                  pronunciations = prons),
                    senses = sns
                )
            )
        
        else:
            lex['entries'].append(
                LexicalEntry(                
                    id = eid,
                    lemma = Lemma(writtenForm = entry['lemma'],
                                  partOfSpeech = entry['pos']),
                    senses = sns
                )
            )

        
    for ssid, synset in synsets.items():
        if len(synset['members']) == 0:
            print(f'EMPTY SYNSET: {ssid}', file=logfile)
            continue

        lex['synsets'].append(
            Synset(
                id = ssid,
                ili = synset['ili'],
                
                partOfSpeech = synset['pos'],
                definitions=[Definition(text)
                             for _, text in sorted(synset['def'])],
                examples=[Example(text=txt)
                          for _, txt in sorted(synset['exe'])],
                members=synset['members'],
            )
        )


# ID FORMATTERS ########################################################

def synset_id(lexid: str, ssid: str) -> str:
    if ssid.endswith('-s'):
        ssid = ssid[:-2] + '-a'
    return f'{lexid}-{ssid}'


def entry_id(lexid: str, lemma: str, pos: str) -> str:
    return f'{lexid}-{escape_lemma(lemma)}-{pos}'


def sense_id(lexid: str, lemma: str, ssid: str, pos: str) -> str:
    return f'{lexid}-{escape_lemma(lemma)}-{ssid}-{pos}'


# COMMAND-LINE INTERFACE ###############################################

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser()
    parser.add_argument('SOURCE', help='source TSV file')
    parser.add_argument('DESTINATION', help='output XML file path')
    parser.add_argument('--id', required=True, help='lexicon ID')
    parser.add_argument('--label', required=True, help='name or description')
    parser.add_argument('--language', required=True, help='language (BCP-47)')
    parser.add_argument('--email', required=True, help='project email address')
    parser.add_argument('--license', required=True, help='license name or URL')
    parser.add_argument('--version', required=True, help='lexicon version')
    parser.add_argument('--url', help='project url')
    parser.add_argument('--citation', help='readable citation')
    parser.add_argument('--logo', help='url of project logo')
    parser.add_argument('--requires', metavar='ID:VERSION',
                        help='lexicon dependency')
    parser.add_argument('--meta', action='append', metavar='KEY=VALUE',
                        help='lexicon metadata; may be repeated')
    parser.add_argument('--ili-map', metavar='PATH',
                        help='synset to ILI mapping file')
    parser.add_argument('--log', type=argparse.FileType('w'),
                        default=sys.stderr, metavar='PATH',
                        help='file for logging output (default: stderr)')
    print(sys.argv)
    args = parser.parse_args()
    print(args)
    source = Path(args.SOURCE)
    if not source.is_file():
        raise ValueError('source file not found')
    destination = Path(args.DESTINATION)

    if args.requires:
        id, _, ver = args.requires.partition(':')
        requires = {'id': id, 'version': ver}
    else:
        requires = None

    if args.meta:
        meta = Metadata(**dict(kv.split('=', 1) for kv in args.meta))
    else:
        meta = None

    if args.ili_map:
        ilimap = load_ili_map(args.ili_map)
    else:
        ilimap = None

    convert(source,
            destination,
            args.id,
            args.label,
            args.language,
            args.email,
            args.license,
            args.version,
            url=args.url,
            citation=args.citation,
            logo=args.logo,
            requires=requires,
            meta=meta,
            ilimap=ilimap,
            logfile=args.log)
