###
### Make a new release of the TUFS wordnets
###

### setup python
if [ -d ".venv" ]
then
    source .venv/bin/activate
    pip install -r requirements.txt
else
    python3.9 -m venv .venv
    source .venv/bin/activate
    python3 -m pip install --upgrade pip
    pip install -r requirements.txt
fi



WNBASE="tufs"
VERSION='2.0'
LANGFILE="tufsdata/languages.txt"         ## loc. of language list 
CILIDIR="${TMPDIR}/cili"             ## location of cili
PREDIR="omw_format"                  ## location of tsv
BLDDIR="build/${WNBASE}-${VERSION}"  ## location of build
export WNBASE VERSION PREDIR BLDDIR LANGFILE

#bash scripts/download.sh

#python scripts/ara2tab.py ${PREDIR}/json ${PREDIR}/tab ${WNBASE} "$LANG_CODES"

### make the wordnets!


bash scripts/build-lmf.sh

etc/omw-data/validate.sh 


BASEURL="https://github.com/omwn/${WNBASE}/releases/download/${TAG}"
export BASEURL

bash etc/omw-data/package.sh $VERSION v$VERSION


python etc/omw-data/scripts/summarize-release.py \
       --core-ili etc/omw-data/etc/wn-core-ili.tab \
       release/${WNBASE}-${VERSION}.tar.xz > docs/${WNBASE}-${VERSION}-summary.md
