#!/usr/bin/env bash
# ____________________________________________________________________________
#
# DVG001 -- Introduktion till Linux och små nätverk
#                              Inlämningsuppgift #3
# Author:   Jonas Sjöberg
#           tel12jsg@student.hig.se
# Date:     2016-03-15 -- 2016-03-20 
# ____________________________________________________________________________

WORKDIR="/tmp/del3"

[ -d "$WORKDIR" ] || { printf "Saknar \"%s\" .." "$WORKDIR" 1>&2; exit 1; }

find "$WORKDIR" | while IFS= read -r entry
do
  FORMAT="%-20.20s"
  if [ -d "$entry" ]; then
      printf "[kat] ${FORMAT}\n" "$entry"
  elif [ -f "$entry" ]; then
      printf "[fil] ${FORMAT} (innehåll: \"%s\")\n" "$entry" "$(cat "$entry")"
  fi
done

