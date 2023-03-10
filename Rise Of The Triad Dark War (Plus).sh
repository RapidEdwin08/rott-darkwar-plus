#!/bin/bash
# https://github.com/RapidEdwin08/rott-darkwar-plus

# [rottZIPmain] contents: DARKWAR.RTL + DARKWAR.RTC + DARKWAR.WAD + REMOTE1.RTS
rottZIPmain=~/RetroPie/roms/ports/rott-darkwar/rott-darkwar.zip
rottZIPmod=

# Extract [rottZIPmain] + [rottZIPmod] into [rottPLUSdir]: rott-darkwar-plus TMPFS
rottPLUSdir=/dev/shm/rott-darkwar
mkdir "$rottPLUSdir" > /dev/null 2>&1; unzip -qq -o $rottZIPmain -d $rottPLUSdir > /dev/null 2>&1
if [ ! "$rottZIPmod" == "" ]; then unzip -qq -o $rottZIPmod -d $rottPLUSdir > /dev/null 2>&1; fi

# RUN ROTT P0RT
"/opt/retropie/supplementary/runcommand/runcommand.sh" 0 _PORT_ "rott-darkwar" ""

# DELETE the [rottPLUSdir]
rm "$rottPLUSdir" -R -f > /dev/null 2>&1
