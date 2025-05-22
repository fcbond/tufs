#!/bin/bash

### Script to convert the TUFS WordNet to WN-LMF

set -e  # Exit immediately on any error

# Ensure required variables are set
: "${LANGFILE:?Error: LANGFILE is not set}"
: "${PREDIR:?Error: PREDIR is not set}"
: "${BLDDIR:?Error: BLDDIR is not set}"
: "${VERSION:?Error: VERSION is not set}"
: "${WNBASE:?Error: WNBASE is not set}"


TMPDIR="etc/"
mkdir -p "${TMPDIR}"

CILIDIR="${TMPDIR}/cili"
OMWDATADIR="${TMPDIR}/omw-data"

# Ensure required repositories are available
if [ ! -d "${CILIDIR}" ]; then
    git clone https://github.com/globalwordnet/cili.git "${CILIDIR}"
fi

if [ ! -d "${OMWDATADIR}" ]; then
    git clone https://github.com/omwn/omw-data.git "${OMWDATADIR}"
fi

# Build Directories
mkdir -p "${BLDDIR}"
mkdir -p "build/log"

URL="https://github.com/omwn/${WNBASE}/"x

# Read languages from file safely
while IFS='|' read -r local_code bp47 en_name native_name; do
    # Skip empty lines
    if [[ -z "$local_code" ]]; then
        continue
    fi
    echo "Processing language: ${en_name} ($local_code ${native_name})"
    
    INPUT_FILE="${PREDIR}/${WNBASE}-vocab-${local_code}.tsv"
    
    # Check if file exists and has at least 10 lines
    if [ ! -f "$INPUT_FILE" ] || [ $(wc -l < "$INPUT_FILE") -lt 10 ]; then
        echo "Skipping ${en_name} ($local_code): File '$INPUT_FILE' has fewer than 10 lines."
        continue
    fi

    mkdir -p "${BLDDIR}/${WNBASE}-${local_code}"
    
    python "${OMWDATADIR}/scripts/tsv2lmf.py" \
        --id "${WNBASE}-${local_code}" \
        --version "${VERSION}" \
        --label "TUFS Basic Vocabulary for ${en_name} (${native_name})" \
        --language "${bp47}" \
        --email bond@ieee.org \
        --license 'https://creativecommons.org/licenses/by/4.0/' \
        --meta confidenceScore=0.95 \
        --url "${URL}" \
        --ili-map "${CILIDIR}/ili-map-pwn30.tab" \
        --log "build/log/${WNBASE}-${local_code}.log" \
        "${INPUT_FILE}" \
        "${BLDDIR}/${WNBASE}-${local_code}/${WNBASE}-${local_code}.xml"

done < "$LANGFILE"
