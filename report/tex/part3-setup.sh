#!/usr/bin/env bash
# ____________________________________________________________________________
#
# DVG001 -- Introduktion till Linux och små nätverk
#                              Inlämningsuppgift #3
# Author:   Jonas Sjöberg
#           tel12jsg@student.hig.se
# Date:     2016-03-15 -- 2016-03-20 
# ____________________________________________________________________________

set -e                    # Avbryt om ett kommando returnerar fel (nollskiljt)

WORKDIR="/tmp/del3"

# Ta bort katalogstruktur om den redan existerar.
if [ -e "$WORKDIR" ]; then 
    rm -vrf "$WORKDIR" || sudo rm -rf "$WORKDIR"
fi

A1="${WORKDIR}/a1"
mkdir -vp "$A1"
chmod -v 700 "$A1"
sudo chown -v root:gibson "$A1"

A2="${WORKDIR}/a2"
touch "$A2"
chmod -v 744 "$A2"
sudo chown -v gibson:root "$A2"

A3="${WORKDIR}/a3"
mkdir -v "$A3"
chmod -v 744 "$A3"

A4="${WORKDIR}/a4"
sudo touch "$A4"
sudo chmod -v 770 "$A4"

# Visa resultatet.
for entry in ${WORKDIR}/{,*} ; do ls -lthrd "${entry}"; done | column -t -s' '

