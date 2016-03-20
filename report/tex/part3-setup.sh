#!/usr/bin/env bash
# ____________________________________________________________________________
#
# DVG001 -- Introduktion till Linux och små nätverk
#                              Inlämningsuppgift #2
# Author:   Jonas Sjöberg
#           tel12jsg@student.hig.se
# Date:     2016-03-15 -- 2016-03-20 
# ____________________________________________________________________________

set -e                    # Avbryt om ett kommando returnerar fel (nollskiljt)

WORKDIR="/tmp/del3"

if [ -e "$WORKDIR" ]; then 
    rm -rf "$WORKDIR" || sudo rm -rf "$WORKDIR"
fi

mkdir -vp "${WORKDIR}/a1"
chmod -v 700 "${WORKDIR}/a1"
sudo chown -v root:gibson "${WORKDIR}/a1"

touch "${WORKDIR}/a2"
chmod -v 744 "${WORKDIR}/a2"
sudo chown -v gibson:root "${WORKDIR}/a2"

mkdir -v "${WORKDIR}/a3"
chmod -v 744 "${WORKDIR}/a3"

sudo touch "${WORKDIR}/a4"
sudo chmod -v 770 "${WORKDIR}/a4"


for entry in ${WORKDIR}/{,*} ; do ls -lthrd "${entry}"; done | column -t -s' '

