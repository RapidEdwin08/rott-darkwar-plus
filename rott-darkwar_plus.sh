#!/usr/bin/env bash
# https://github.com/RapidEdwin08/rott-darkwar-plus
# https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/LICENSE
version=2025.07

rottLOGO=$(
echo "                                |||                
                               || ||               
                              ||| |||              
                             |||   |||             
                           .||||   ||||.           
                          .|||||   |||||.          
                         |||||||   |||||||         
                        ||||||||| |||||||||          
                       ||||| ||||||||| |||||       
                      ||||   |||||||||   ||||     
                    .|||    ||||||||||    ||||.    
                   .|||    ||||||||||||    ||||.   
                  ||||    ||||||||||||||    |||||  
                 ||||||||||||||||||||||||||||||||| 
                    Rise Of The Triad: Dark War
")

rott_BIN=/opt/retropie/ports/rott-darkwar/rott # rottexpr
if [[ -f /opt/retropie/ports/rott-darkwar/rott-darkwar ]]; then rott_BIN=/opt/retropie/ports/rott-darkwar/rott-darkwar; fi #rott

rottDWcfg=$(
echo "rott-darkwar+ = \"pushd /dev/shm/rott-darkwar; /opt/retropie/ports/rott-darkwar/$rott_BIN; popd\"
rott-darkwar+XINIT = \"XINIT:/opt/retropie/rott-darkwar/rott-darkwar-plus.sh\"
")

rottDWsh=$(
echo '#!/bin/bash
rottROMdir="$HOME/RetroPie/roms/ports/rott" #rottexpr
if [[ -d "$HOME/RetroPie/roms/ports/rott-darkwar" ]]; then rottROMdir="$HOME/RetroPie/roms/ports/rott-darkwar"; fi #rott/rottexpr
if [[ -d "/dev/shm/rott-darkwar" ]]; then rottROMdir="/dev/shm/rott-darkwar"; fi #rott-darkwar-plus

rottBIN=/opt/retropie/ports/rott-darkwar/rott # rottexpr
if [[ -f /opt/retropie/ports/rott-darkwar/rott-darkwar ]]; then rottBIN=/opt/retropie/ports/rott-darkwar/rott-darkwar; fi #rott

pushd "$rottROMdir"
"$rottBIN" $*
popd

')

rottREFS=$(
echo '
# Where to get Rise Of The Triad P0RTs:
https://github.com/RapidEdwin08/RetroPie-Setup
    ...ext/RetroPie-Extra/scriptmodules/ports/rott-darkwar.sh
    ...ext/RetroPie-Extra/scriptmodules/ports/rott-huntbgin.sh

# How to use:
[rottZIPmain]: ZIP the ENTIRE GAME Rise Of The Triad Dark War
Script Creates rott-darkwar.ZIP @INSTALL for you if ALL FILEs are found
eg [rott-darkwar.zip]: DARKWAR.RTL DARKWAR.RTC DARKWAR.WAD REMOTE1.RTS

[rottZIPmod]: ZIP 0nly the M0D File(s)
eg. Extreme Rise Of The Triad [rott-extreme.zip]: DARKWAR.RTL

[R0TT-Plus-Template.sh]: Input Full Path to ZIP Files
rottZIPmain=/home/pi/RetroPie/roms/ports/rott-darkwar/rott-darkwar.zip
rottZIPmod=/home/pi/RetroPie/roms/ports/rott-darkwar/rott-extreme.zip

# EXAMPLE rott-darkwar+ Emulator Entries for RiseOfTheTriad DarkWar:
[rott-darkwar+]: pushd TMPFS/rott-darkwar; rott-darkwar
[rott-darkwar+XINIT]: ../ports/rott-darkwar/rott-darkwar-plus.sh

# CURRENT [/opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:

')

rottdwLST=$(
echo 'DARKWAR.RTL
DARKWAR.RTC
DARKWAR.WAD
REMOTE1.RTS
')

wadmergeLICENSE=$(
echo '======================================================================
WADMERGE: Joins/merges WAD files for Doom and Doom engine based games.
(C) Dennis Katsonis (2014).		Version 1.0.2

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.
You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
')

wadmergeINFO=$(
echo '======================================================================
WADMERGE: Joins/merges WAD files for Doom engine based games.
(C) Dennis Katsonis (2014).		Version 1.0.2

By default, [wadmerge] will not include duplicate wad lumps.
The first entry encountered will be the one used in the output file.
Put the WAD with the data you prefer to keep first (eg. Mod.wad).

Output WAD will be PWAD unless 1 or more of the input WADs is an IWAD.
Specify -I or -P to override this behaiviour.

Usage :
 wadmerge [options] -i input1.wad -i input2.wad -i input3 -o output.wad

Options :
 -d Allow duplicate lumps.		-o Output filename.
 -I Output file is an IWAD.		-P Output file is a PWAD.
 -i Input Wad filename.
 -c Compact (Deduplicate) Store Lumps with same data only once per wad
 -V Show license.
')

mainMENU()
{

# WARN IF [..ports/rott-darkwar/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/rott-darkwar/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "You MUST INSTALL RiseOfTheTriad DarkWar from RetroPie Setup 1st! [rott-darkwar]"  25 75
fi
# Confirm Configurations
confROTTplus=$(dialog --no-collapse --title " [rott-darkwar-plus] for RetroPie by: RapidEdwin08 [v$version]" \
	--ok-label OK --cancel-label EXIT \
	--menu "$rottLOGO" 25 75 20 \
	1 "INSTALL [rott-darkwar+]" \
	2 "INSTALL [wadmerge-1.0.2]" \
	3 "GET [rott-darkwar] + [rott-huntbgin] Install Scripts" \
	4 "OPEN [RetroPie-Setup]" \
	5 "REMOVE  [rott-darkwar+]" \
	R "REFERENCES " 2>&1>/dev/tty)

# INSTALL [rott-darkwar+]
if [ "$confROTTplus" == '1' ]; then
	confINSTALLrottplus=$(dialog --no-collapse --title "               INSTALL [rott-darkwar+]             " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n               [rott-darkwar+]   [rott-darkwar+XINIT]" 25 75 20 \
		1 "YES INSTALL [rott-darkwar+] " \
		2 "BACK " 2>&1>/dev/tty)
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$confINSTALLrottplus" == '1' ]; then
		tput reset
		# WARN IF [..ports/rott-darkwar/emlators.cfg] N0T Found
		if [ ! -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg ]; then
			dialog --no-collapse --title "***N0TICE*** [..ports/rott-darkwar/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "You MUST INSTALL RiseOfTheTriad DarkWar from RetroPie Setup 1st! [rott-darkwar]"  25 75
			mainMENU
		fi
		
		# Install [ZIP/UNZIP] - Check If Internet Connection Available
		if [[ "$(dpkg -l | grep -F '  zip ')" == '' ]] || [[ "$(dpkg -l | grep -F '  unzip ')" == '' ]]; then
			wget -q --spider http://google.com
			if [ $? -eq 0 ]; then
				sudo apt-get install zip -y
				sudo apt-get install unzip -y
				#sudo apt-get install p7zip-full -y
			else
				# No Internet - Back to Main Menu
				dialog --no-collapse --title "               [ERROR]               " --msgbox "   *INTERNET CONNECTION REQUIRED* TO INSTALL [ZIP/UNZIP]"  25 75
				mainMENU
			fi
		fi
		
		# Create rott-darkwar.zip IF all x4 ROTT DW FILEs exist 
		if [ -f ~/RetroPie/roms/ports/rott-darkwar/DARKWAR.RTL ] && [ -f ~/RetroPie/roms/ports/rott-darkwar/DARKWAR.RTC ] && [ -f ~/RetroPie/roms/ports/rott-darkwar/DARKWAR.WAD ] && [ -f ~/RetroPie/roms/ports/rott-darkwar/REMOTE1.RTS ] && [ ! -f ~/RetroPie/roms/ports/rott-darkwar/rott-darkwar.zip ]; then
			echo "R0TT DARKWAR FILEs FOUND. Creating [rott-darkwar.zip]..."
			cd ~/RetroPie/roms/ports/rott-darkwar
			echo "$rottdwLST" > ~/RetroPie/roms/ports/rott-darkwar/rott-darkwar.lst
			zip -9 rott-darkwar.zip -@ < rott-darkwar.lst
			rm ~/RetroPie/roms/ports/rott-darkwar/rott-darkwar.lst
			cd ~
		fi
		
		# Add rott-darkwar+ Config
		if [ -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg ]; then
			# Backup emulators.cfg if NOT found
			if [ ! -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg.b4rottplus ]; then cp /opt/retropie/configs/ports/rott-darkwar/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg.b4rottplus 2>/dev/null; fi
			
			# Add [rott-darkwar+] SH for XINIT
			echo "$rottDWsh" > /dev/shm/rott-darkwar-plus.sh
			sudo mv /dev/shm/rott-darkwar-plus.sh /opt/retropie/ports/rott-darkwar/rott-darkwar-plus.sh 2>/dev/null
			sudo chmod 755 /opt/retropie/ports/rott-darkwar/rott-darkwar-plus.sh 2>/dev/null
			
			# Add [rott-darkwar+] to [emulators.cfg]
			echo "$rottDWcfg" > /dev/shm/emulators.cfg
			cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg | grep -v rott-darkwar-plus.sh | grep -v /dev/shm/rott-darkwar >> /dev/shm/emulators.cfg
			mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg 2>/dev/null
			
			# Configure [rott-darkwar] as DEFAULT in [emulators.cfg]
			sed -i 's/default\ =.*/default\ =\ \"rott-darkwar+\"/g' /opt/retropie/configs/ports/rott-darkwar/emulators.cfg
			if [ $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg | grep -q rott-darkwar+qjoypad ; echo $?) == '0' ]; then
				sed -i 's/default\ =.*/default\ =\ \"rott-darkwar+qjoypad\"/g' /opt/retropie/configs/ports/rott-darkwar/emulators.cfg
			fi
		fi
		dialog --no-collapse --title " INSTALL [rott-darkwar+] FINISHED" --ok-label Back --msgbox "  CURRENT CONTENT [opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:  $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg)"  25 75
		mainMENU
	fi
	mainMENU
fi

# Install [wadmerge]
if [ "$confROTTplus" == '2' ]; then
	confINSTALLwadmerge=$(dialog --no-collapse --title "     INSTALL [wadmerge-1.0.2]        " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n \n       [wadmerge-1.0.2] can be used to combine ROTT MOD WADs:\n  wadmerge -i ./wolf3d.wad -i ./DARKWAR.WAD -o /dev/shm/DARKWAR.WAD" 25 75 20 \
		1 "YES INSTALL [wadmerge-1.0.2]" \
		2 "BACK " 2>&1>/dev/tty)
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$confINSTALLwadmerge" == '1' ]; then
		tput reset
		cd /dev/shm
		wget https://sourceforge.net/projects/wadmerge/files/1.0.2/wadmerge-1.0.2.tar.gz
		tar xvzf wadmerge-1.0.2.tar.gz -C ./
		cd wadmerge-1.0.2
		mkdir build
		cd build
		cmake ..
		#cd ..
		cmake --build .
		chmod 755 /dev/shm/wadmerge-1.0.2/build/wadmerge
		sudo mv /dev/shm/wadmerge-1.0.2/build/wadmerge /usr/bin/wadmerge
		rm -Rf /dev/shm/wadmerge-1.0.2
		dialog --no-collapse --title " INSTALL [wadmerge-1.0.2] FINISHED" --ok-label Back --msgbox "  $(wadmerge) $wadmergeLICENSE"  25 75
		mainMENU
	fi
	mainMENU
fi

# GET [rott-darkwar] + [rott-huntbgin] from GIT
if [ "$confROTTplus" == '3' ]; then
	gitROTTports=$(dialog --no-collapse --title "           GET [rott-darkwar] + [rott-huntbgin] Install Scripts             " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n \n This will GIT/UPDATE/OVERWRITE [rott] scriptmodules in RetroPie-Setup \n \n  /home/$USER/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/* \n \n             https://github.com/RapidEdwin08/RetroPie-Setup/\n              .../ext/RetroPie-Extra/scriptmodules/ports          " 25 75 20 \
		1 "YES GET [rott-darkwar] + [rott-huntbgin] Install Scripts" \
		2 "BACK " 2>&1>/dev/tty)
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$gitROTTports" == '1' ]; then
		tput reset
		# GIT ROTT P0RTs - Check If Internet Connection Available
		wget -q --spider http://google.com
		if [ $? -eq 0 ]; then
			mkdir ~/RetroPie-Setup/ext/RetroPie-Extra > /dev/null 2>&1
			mkdir ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules > /dev/null 2>&1
			mkdir ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports > /dev/null 2>&1
			wget https://raw.githubusercontent.com/RapidEdwin08/RetroPie-Setup/master/ext/RetroPie-Extra/scriptmodules/ports/rott-darkwar.sh -P /dev/shm/; mv /dev/shm/rott-darkwar.sh ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/
			wget https://raw.githubusercontent.com/RapidEdwin08/RetroPie-Setup/master/ext/RetroPie-Extra/scriptmodules/ports/rott-huntbgin.sh -P /dev/shm/; mv /dev/shm/rott-huntbgin.sh ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/
		else
			# No Internet - Back to Main Menu
			dialog --no-collapse --title "               [ERROR]               " --msgbox "   *INTERNET CONNECTION REQUIRED* TO GIT ROTT P0RTs"  25 75
			mainMENU
		fi
		dialog --no-collapse --title " GET [rott-darkwar] + [rott-huntbgin] Install Scripts FINISHED" --ok-label Back --msgbox "  RetroPie Setup -> Manage Packages -> Manage experimental packages"  25 75
		mainMENU
	fi
	mainMENU
fi

# Open RPSetup
if [ "$confROTTplus" == '4' ]; then
	confiRPsetup=$(dialog --no-collapse --title " RetroPie Setup -> Manage Packages -> Experimental Packages" \
		--ok-label OK --cancel-label Back \
		--menu "                          ? ARE YOU SURE ?              \n $(ls ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/ | grep 'rott-' )" 25 75 20 \
		Y "YES OPEN [RetroPie-Setup]" \
		B "BACK" 2>&1>/dev/tty)
	if [ "$confiRPsetup" == 'Y' ]; then
		cd ~/RetroPie-Setup/ && sudo bash ~/RetroPie-Setup/retropie_setup.sh
		#sudo bash ~/RetroPie-Setup/retropie_packages.sh retropiemenu launch "/home/$USER/RetroPie-Setup/retropie_setup.sh" </dev/tty > /dev/tty
		exit 0
	fi
	mainMENU
fi

# REMOVE [rott-darkwar+]
if [ "$confROTTplus" == '5' ]; then
	confREMOVErottplus=$(dialog --no-collapse --title "          REMOVE [rott-darkwar+]              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "YES REMOVE [rott-darkwar+]" \
		2 "BACK " 2>&1>/dev/tty)
	# Remove Confirmed - Otherwise Back to Main Menu
	if [ "$confREMOVErottplus" == '1' ]; then
		tput reset
		# Remove rott-darkwar+ Config
		if [ -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg ]; then
			# Backup emulators.cfg if NOT found
			if [ ! -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg.b4rottplus ]; then cp /opt/retropie/configs/ports/rott-darkwar/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg.b4rottplus 2>/dev/null; fi
			
			# Remove [rott-darkwar+] from config and [emulators.cfg]
			sudo rm /opt/retropie/ports/rott-darkwar/rott-darkwar-plus.sh 2>/dev/null
			cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg | grep -v rott-darkwar-plus.sh | grep -v /dev/shm/rott-darkwar >> /dev/shm/emulators.cfg
			mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg 2>/dev/null
			
			# Configure [rott-darkwar] as DEFAULT in [emulators.cfg]
			sed -i 's/default\ =.*/default\ =\ \"rott-darkwar\"/g' /opt/retropie/configs/ports/rott-darkwar/emulators.cfg
			if [ $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg | grep -q rott-darkwar+qjoypad ; echo $?) == '0' ]; then
				sed -i 's/default\ =.*/default\ =\ \"rott-darkwar+qjoypad\"/g' /opt/retropie/configs/ports/rott-darkwar/emulators.cfg
			fi
		fi
		dialog --no-collapse --title " REMOVE [rott-darkwar+] RiseOfTheTriad DarkWar FINISHED" --ok-label Back --msgbox "  CURRENT CONTENT [opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:  $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg)"  25 75
		mainMENU
	fi
	mainMENU
fi

# REFERENCES
if [ "$confROTTplus" == 'R' ]; then	
	dialog --no-collapse --title " REFERENCES" --ok-label Back --msgbox "$rottREFS $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg) $wadmergeINFO $wadmergeLICENSE"  25 75
	mainMENU
fi

# QUIT if N0T Confirmed
if [ "$confROTTplus" == '' ]; then
	tput reset
	exit 0
fi

tput reset
exit 0
}

mainMENU

tput reset
exit 0
