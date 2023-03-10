#!/usr/bin/env bash
# https://github.com/RapidEdwin08/rott-darkwar-plus
version=2023.03

rottLOGO=$(
echo "            Rise Of The Triad: Dark War / The Hunt Begins
                                |||                
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
")

rottDWsh=$(
echo '#!/bin/bash
pushd "/dev/shm/rott-darkwar"
"/opt/retropie/ports/rott-darkwar/rott-darkwar" $*
popd

')

rottDWcfg=$(
echo 'rott-darkwar-XINIT = "XINIT:/opt/retropie/ports/rott-darkwar/rott-darkwar.sh"
rott-darkwar = "pushd /home/pi/RetroPie/roms/ports/rott-darkwar; /opt/retropie/ports/rott-darkwar/rott-darkwar; popd"
default = "rott-darkwar+"
rott-darkwar+XINIT = "XINIT:/opt/retropie/configs/ports/rott-darkwar/rott-darkwar-plus.sh"
rott-darkwar+ = "pushd /dev/shm/rott-darkwar; /opt/retropie/ports/rott-darkwar/rott-darkwar; popd"

')

rottHBsh=$(
echo '#!/bin/bash
pushd "/home/pi/RetroPie/roms/ports/rott-huntbgin"
"/opt/retropie/ports/rott-huntbgin/rott-huntbgin" $*
popd

')

rottHBcfg=$(
echo 'rott-huntbgin-XINIT = "XINIT:/opt/retropie/ports/rott-huntbgin/rott-huntbgin.sh"
rott-huntbgin = "pushd /home/pi/RetroPie/roms/ports/rott-huntbgin; /opt/retropie/ports/rott-huntbgin/rott-huntbgin; popd"
default = "rott-huntbgin"

')

rottREFS=$(
echo '
# Where to get Rise Of The Triad P0RTs:
https://github.com/Exarkuniv/RetroPie-Extra
    .../scriptmodules/ports/rott-darkwar.sh
    .../scriptmodules/ports/rott-huntbgin.sh

# How to use:
[rottZIPmain]: ZIP the ENTIRE GAME Rise Of The Triad Dark War
Script Creates rott-darkwar.ZIP @INSTALL for you if ALL FILEs are found
eg [rott-darkwar.zip]: DARKWAR.RTL DARKWAR.RTC DARKWAR.WAD REMOTE1.RTS

[rottZIPmod]: ZIP 0nly the M0D File(s)
eg. Extreme Rise Of The Triad [rott-extreme.zip]: DARKWAR.RTL

[R0TT-Plus-Template.sh]: Input Full Path to ZIP Files
rottZIPmain=/home/pi/RetroPie/roms/ports/rott-darkwar/rott-darkwar.zip
rottZIPmod=/home/pi/RetroPie/roms/ports/rott-darkwar/rott-extreme.zip

# Default Emulator Entries for RetroPie RiseOfTheTriad DarkWar
[rott-darkwar]: pushd ~/..ports/rott-darkwar/; rott-darkwar
[rott-darkwar-XINIT]: ./ports/rott-darkwar/rott-darkwar.sh

# rott-darkwar+ Emulator Entries for RetroPie RiseOfTheTriad DarkWar
[rott-darkwar+]: pushd TMPFS/; rott-darkwar
[rott-darkwar+XINIT]: ./configs/ports/rott-darkwar/rott-darkwar-plus.sh

======================================================================
CURRENT CONTENT [/opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:                   
======================================================================
')

rottREFShb=$(
echo '
======================================================================
CURRENT CONTENT [/opt/retropie/configs/ports/rott-huntbgin/emulators.cfg]:                   
======================================================================
')

rottdwLST=$(
echo 'DARKWAR.RTL
DARKWAR.RTC
DARKWAR.WAD
REMOTE1.RTS
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
	1 "><  INSTALL [rott-darkwar+] for RetroPie ><" \
	2 "><  REMOVE  [rott-darkwar+] for RetroPie ><" \
	3 "><  UPDATE  [rott-huntbgin] +/- XINIT Entries for RetroPie ><" \
	4 "><  GET [rott-darkwar] + [rott-huntbgin] P0RTs for RetroPie ><" \
	S "><  OPEN [RetroPie-Setup] ><" \
	R "><  REFERENCES  ><" 2>&1>/dev/tty)

# INSTALL [rott-darkwar+]
if [ "$confROTTplus" == '1' ]; then
	confINSTALLrottplus=$(dialog --no-collapse --title "               INSTALL [rott-darkwar+] for RetroPie             " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n                [rott-darkwar]  [rott-darkwar-XINIT] \n               [rott-darkwar+]   [rott-darkwar+XINIT]" 25 75 20 \
		1 "><  YES INSTALL [rott-darkwar+] for RetroPie  ><" \
		2 "><  BACK  ><" 2>&1>/dev/tty)
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
			mv /dev/shm/rott-darkwar-plus.sh /opt/retropie/configs/ports/rott-darkwar/rott-darkwar-plus.sh 2>/dev/null
			sudo chmod 755 /opt/retropie/configs/ports/rott-darkwar/rott-darkwar-plus.sh 2>/dev/null
			
			# Add [rott-darkwar+] to [emulators.cfg]
			echo "$rottDWcfg" > /dev/shm/emulators.cfg
			mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg 2>/dev/null
			
			# Add [rott-darkwar] SH for XINIT if not found
			if [ ! -f /opt/retropie/ports/rott-darkwar/rott-darkwar.sh ]; then
				echo "$rottDWsh" | grep -v "rott-darkwar+" > /dev/shm/rott-darkwar.sh
				sudo mv /dev/shm/rott-darkwar.sh /opt/retropie/ports/rott-darkwar/rott-darkwar.sh
				sudo chmod 755 /opt/retropie/ports/rott-darkwar/rott-darkwar.sh 2>/dev/null
			fi
			
			# Configure [rott-darkwar] as DEFAULT in [emulators.cfg]
			sed -i 's/default\ =.*/default\ =\ \"rott-darkwar+\"/g' /opt/retropie/configs/ports/rott-darkwar/emulators.cfg
		fi
		dialog --no-collapse --title " INSTALL [rott-darkwar+] for RetroPie FINISHED" --ok-label Back --msgbox "  CURRENT CONTENT [opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:  $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg)"  25 75
		mainMENU
	fi
	mainMENU
fi

# REMOVE [rott-darkwar+]
if [ "$confROTTplus" == '2' ]; then
	confREMOVErottplus=$(dialog --no-collapse --title "          REMOVE [rott-darkwar+] for RetroPie              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  YES REMOVE [rott-darkwar+] for RetroPie  ><" \
		2 "><  BACK  ><" 2>&1>/dev/tty)
	# Remove Confirmed - Otherwise Back to Main Menu
	if [ "$confREMOVErottplus" == '1' ]; then
		tput reset
		# Remove rott-darkwar+ Config
		if [ -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg ]; then
			# Backup emulators.cfg if NOT found
			if [ ! -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg.b4rottplus ]; then cp /opt/retropie/configs/ports/rott-darkwar/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg.b4rottplus 2>/dev/null; fi
			
			# Remove [rott-darkwar+] from config and [emulators.cfg]
			rm /opt/retropie/configs/ports/rott-darkwar/rott-darkwar-plus.sh 2>/dev/null
			echo "$rottDWcfg" | grep -v "rott-darkwar+" > /dev/shm/emulators.cfg
			mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/rott-darkwar/emulators.cfg 2>/dev/null
			
			if [ ! -f /opt/retropie/ports/rott-darkwar/rott-darkwar.sh ]; then
				echo "$rottDWsh" | grep -v "rott-darkwar+" > /dev/shm/rott-darkwar.sh
				sudo mv /dev/shm/rott-darkwar.sh /opt/retropie/ports/rott-darkwar/rott-darkwar.sh
				sudo chmod 755 /opt/retropie/ports/rott-darkwar/rott-darkwar.sh 2>/dev/null
			fi
			
			# Configure [rott-darkwar] as DEFAULT in [emulators.cfg]
			sed -i 's/default\ =.*/default\ =\ \"rott-darkwar\"/g' /opt/retropie/configs/ports/rott-darkwar/emulators.cfg
		fi
		dialog --no-collapse --title " REMOVE [rott-darkwar+] for RetroPie RiseOfTheTriad DarkWar FINISHED" --ok-label Back --msgbox "  CURRENT CONTENT [opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:  $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg)"  25 75
		mainMENU
	fi
	mainMENU
fi

# UPDATE [rott-huntbgin] [rott-huntbgin-XINIT]
if [ "$confROTTplus" == '3' ]; then
	# WARN IF [..ports/rott-huntbgin/emlators.cfg] N0T Found
	if [ ! -f /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg ]; then
		dialog --no-collapse --title "***N0TICE*** [..ports/rott-huntbgin/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "You MUST INSTALL RiseOfTheTriad HuntBegins from RetroPie Setup 1st! [rott-huntbgin]"  25 75
	fi
	
	confINSTALLrottplusHB=$(dialog --no-collapse --title "     UPDATE  [rott-huntbgin] for RetroPie +/- XINIT        " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n \n       Update [rott-huntbgin] to include BOTH +/- XINIT entries \n \n      [emulators.cfg] -> [rott-huntbgin]  [rott-huntbgin-XINIT]" 25 75 20 \
		1 "><  YES UPDATE  [rott-huntbgin] +/- XINIT Entries for RetroPie ><" \
		2 "><  BACK  ><" 2>&1>/dev/tty)
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$confINSTALLrottplusHB" == '1' ]; then
		tput reset
		# UPDATE rott-huntbgin Config
		if [ -f /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg ]; then
			# Backup emulators.cfg if NOT found
			if [ ! -f /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg.b4rottplus ]; then cp /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg.b4rottplus 2>/dev/null; fi
			
			# UPDATE [rott-huntbgin] [emulators.cfg] 
			echo "$rottHBcfg" | grep -v "rott-huntbgin+" > /dev/shm/emulators.cfg
			mv /dev/shm/emulators.cfg /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg 2>/dev/null
			
			# Add [rott-darkwar-XINIT] SH if not found
			if [ ! -f /opt/retropie/ports/rott-huntbgin/rott-huntbgin.sh ]; then
				echo "$rottHBsh" | grep -v "rott-huntbgin+" > /dev/shm/rott-huntbgin.sh
				sudo mv /dev/shm/rott-huntbgin.sh /opt/retropie/ports/rott-huntbgin/rott-huntbgin.sh
				sudo chmod 755 /opt/retropie/ports/rott-huntbgin/rott-huntbgin.sh 2>/dev/null
			fi
			
			# Configure [rott-huntbgin] as DEFAULT in [emulators.cfg]
			sed -i 's/default\ =.*/default\ =\ \"rott-huntbgin\"/g' /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg
		fi
		dialog --no-collapse --title " UPDATE  [rott-huntbgin] +/- XINIT Entries for RetroPie FINISHED" --ok-label Back --msgbox "  CURRENT CONTENT [opt/retropie/configs/ports/rott-huntbgin/emulators.cfg]:  $(cat /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg)"  25 75
		mainMENU
	fi
	mainMENU
fi

# GET [rott-darkwar] + [rott-huntbgin] from GIT
if [ "$confROTTplus" == '4' ]; then
	gitROTTports=$(dialog --no-collapse --title "           GET [rott-darkwar] + [rott-huntbgin] P0RTs for RetroPie             " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n \n This will GIT/UPDATE/OVERWRITE [rott] scriptmodules in RetroPie-Setup \n \n  /home/$USER/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/* \n \n             https://github.com/Exarkuniv/RetroPie-Extra/          " 25 75 20 \
		1 "><  YES GET [rott-darkwar] + [rott-huntbgin] P0RTs for RetroPie ><" \
		2 "><  BACK  ><" 2>&1>/dev/tty)
	# Install Confirmed - Otherwise Back to Main Menu
	if [ "$gitROTTports" == '1' ]; then
		tput reset
		# GIT ROTT P0RTs - Check If Internet Connection Available
		wget -q --spider http://google.com
		if [ $? -eq 0 ]; then
			mkdir ~/RetroPie-Setup/ext/RetroPie-Extra > /dev/null 2>&1
			mkdir ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules > /dev/null 2>&1
			mkdir ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports > /dev/null 2>&1
			wget https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/scriptmodules/ports/rott-darkwar.sh -P /dev/shm/; mv /dev/shm/rott-darkwar.sh ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/
			wget https://raw.githubusercontent.com/Exarkuniv/RetroPie-Extra/master/scriptmodules/ports/rott-huntbgin.sh -P /dev/shm/; mv /dev/shm/rott-huntbgin.sh ~/RetroPie-Setup/ext/RetroPie-Extra/scriptmodules/ports/
		else
			# No Internet - Back to Main Menu
			dialog --no-collapse --title "               [ERROR]               " --msgbox "   *INTERNET CONNECTION REQUIRED* TO GIT ROTT P0RTs"  25 75
			mainMENU
		fi
		dialog --no-collapse --title " GET [rott-darkwar] + [rott-huntbgin] P0RTs for RetroPie FINISHED" --ok-label Back --msgbox "  RetroPie Setup -> Manage Packages -> Manage experimental packages"  25 75
		mainMENU
	fi
	mainMENU
fi

# Open RPSetup
if [ "$confROTTplus" == 'S' ]; then
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

# REFERENCES
if [ "$confROTTplus" == 'R' ]; then	
	dialog --no-collapse --title " REFERENCES" --ok-label Back --msgbox "$rottREFS $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg) $rottREFShb $(cat /opt/retropie/configs/ports/rott-huntbgin/emulators.cfg)"  25 75
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
