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
"
)

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
eg [rott-darkwar.zip]: DARKWAR.RTL+DARKWAR.RTC+DARKWAR.WAD+REMOTE1.RTS

[rottZIPmod]: ZIP 0nly the M0D File(s)
eg. Extreme Rise Of The Triad [rott-extreme.zip]: DARKWAR.RTL

[R0TT-Plus-Template.sh]: Input Full Path to ZIP Files
rottZIPmain=/home/pi/RetroPie/roms/ports/rott-darkwar/rott-darkwar.zip
rottZIPmod=/home/pi/RetroPie/roms/ports/rott-darkwar/rott-extreme.zip

# Default Emulator Entries for RetroPie RiseOfTheTriad DarkWar
[rott-darkwar]: pushd ~/..ports/rott-darkwar/; rott-darkwar
[rott-darkwar-XINIT]: XINIT:pushd ~/..ports/rott-darkwar/; rott-darkwar

# rott-darkwar+ Emulator Entries for RetroPie RiseOfTheTriad DarkWar
[rott-darkwar+]: pushd TMPFS/; rott-darkwar
[rott-darkwar+XINIT]: XINIT:pushd TMPFS/; rott-darkwar

======================================================================
CURRENT CONTENT [/opt/retropie/configs/ports/rott-darkwar/emulators.cfg]:                   
======================================================================
'
)

mainMENU()
{

# WARN IF [..ports/rott-darkwar/emlators.cfg] N0T Found 
if [ ! -f /opt/retropie/configs/ports/rott-darkwar/emulators.cfg ]; then
	dialog --no-collapse --title "***N0TICE*** [..ports/rott-darkwar/emlators.cfg] NOT FOUND!" --ok-label MENU --msgbox "You MUST INSTALL RiseOfTheTriad DarkWar from RetroPie Setup 1st! [rott-darkwar]"  25 75
fi
# Confirm Configurations
confROTTplus=$(dialog --stdout --no-collapse --title " [rott-darkwar-plus] for RetroPie by: RapidEdwin08 [v$version]" \
	--ok-label OK --cancel-label EXIT \
	--menu "$rottLOGO" 25 75 20 \
	1 "><  INSTALL [rott-darkwar+] for RetroPie ><" \
	2 "><  REMOVE  [rott-darkwar+] for RetroPie ><" \
	3 "><  UPDATE  [rott-huntbgin] +/- XINIT Entries for RetroPie ><" \
	R "><  REFERENCES  ><")

# INSTALL [rott-darkwar+]
if [ "$confROTTplus" == '1' ]; then
	confINSTALLrottplus=$(dialog --stdout --no-collapse --title "               INSTALL [rott-darkwar+] for RetroPie             " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n               [rott-darkwar+]  [rott-darkwar+XINIT]" 25 75 20 \
		1 "><  YES INSTALL [rott-darkwar+] for RetroPie  ><" \
		2 "><  BACK  ><")
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
	confREMOVErottplus=$(dialog --stdout --no-collapse --title "          REMOVE [rott-darkwar+] for RetroPie              " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             " 25 75 20 \
		1 "><  YES REMOVE [rott-darkwar+] for RetroPie  ><" \
		2 "><  BACK  ><")
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
	
	confINSTALLrottplusHB=$(dialog --stdout --no-collapse --title "     UPDATE  [rott-huntbgin] for RetroPie +/- XINIT        " \
		--ok-label OK --cancel-label BACK \
		--menu "                          ? ARE YOU SURE ?             \n               [rott-huntbgin]  [rott-huntbgin-XINIT]" 25 75 20 \
		1 "><  YES UPDATE  [rott-huntbgin] +/- XINIT Entries for RetroPie ><" \
		2 "><  BACK  ><")
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

# REFERENCES
if [ "$confROTTplus" == 'R' ]; then	
	dialog --no-collapse --title " REFERENCES" --ok-label Back --msgbox "$rottREFS $(cat /opt/retropie/configs/ports/rott-darkwar/emulators.cfg)"  25 75
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
