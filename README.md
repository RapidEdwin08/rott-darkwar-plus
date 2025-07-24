# rott-darkwar-plus (rott-darkwar+)  
![rott-darkwar_plus.png](https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/rott-darkwar_plus.png)  
[rott-darkwar+] Emulator Entry allows you to easily load M0Ds for Rise Of The Triad: Dark War in RetroPie.  

**HOW DOES IT WORK?**  
[rott-darkwar+] Emulator Entry points to [/dev/shm/rott-darkwar] in TMPFS.  
[R0TT-Plus.sh] Template Extracts [R0TT-MAIN.ZIP] + [R0TT-M0D.ZIP] to [/dev/shm/rott-darkwar] in TMPFS.  
*Utility also Updates rott-darkwar/rott-huntbgin emulators.cfg files to include BOTH +/- XINIT entries.*  

## INSTALLATION  
***You MUST INSTALL Rise of the Triad Dark War from RetroPie Setup 1st! [rott-darkwar]***  
*eg. from [Exarkuniv/RetroPie-Extra/ports/rott-darkwar](https://github.com/Exarkuniv/RetroPie-Extra/blob/master/scriptmodules/ports/rott-darkwar.sh)  

Can be ran from retropiemenu:  

```bash
wget https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/rott-darkwar_plus.sh -P ~/RetroPie/retropiemenu
wget https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/rott-darkwar_plus.png -P ~/RetroPie/retropiemenu/icons
```

0R Run Manually from any directory:  
```bash
cd ~
git clone --depth 1 https://github.com/RapidEdwin08/rott-darkwar-plus.git
chmod 755 ~/rott-darkwar-plus/rott-darkwar_plus.sh
cd ~/rott-darkwar-plus && ./rott-darkwar_plus.sh
```

0ptionally you can Add an Entry and Icon to your retropiemenu [gamelist.xml]:  
*Example Entry:*  
```
	<game>
		<path>./rott-darkwar_plus.sh</path>
		<name>[rott-darkwar+] Rise of the Triad Dark War Plus</name>
		<desc>Configure [rott-darkwar+] for [RetroPie].</desc>
		<image>./icons/rott-darkwar_plus.png</image>
	</game>
```

If you need the R0TT-M0D-Template.sh: 
```bash
wget https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/Rise\ Of\ The\ Triad\ Dark\ War\ \(Plus\).sh -P ~/RetroPie/roms/ports
```

## REFERENCES   
**[rottZIPmain]:** ZIP the ENTIRE GAME Rise Of The Triad Dark War  
Script Creates rott-darkwar.ZIP @INSTALL for you if ALL FILEs are found  
*eg. [rott-darkwar.zip]:* DARKWAR.RTL + DARKWAR.RTC + DARKWAR.WAD + REMOTE1.RTS  

**[rottZIPmod]:** ZIP 0nly the M0D File(s)  
*eg. Extreme Rise Of The Triad [rott-extreme.zip]:* DARKWAR.RTL  

**[R0TT-Plus-Template.sh]:** Input Full Path to ZIP Files  
**rottZIPmain=**/home/pi/RetroPie/roms/ports/rott-darkwar/rott-darkwar.zip  
**rottZIPmod=**/home/pi/RetroPie/roms/ports/rott-darkwar/rott-extreme.zip  

***SOURCES:***  
[RoTT](https://github.com/zerojay/RoTT)  
[RoTT-EXPR](https://github.com/LTCHIPS/rottexpr)  

