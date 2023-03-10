# rott-darkwar-plus (rott-darkwar+)  
## ***WIP***  
![rott-darkwar-plus.png](https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/rott-darkwar-plus.png)  

[rott-darkwar+] Emulator Entry allows you to easily load M0Ds for Rise Of The Triad: Dark War in RetroPie.  

**HOW DOES IT WORK?**  
[rott-darkwar+] Emulator Entry will point to a Directory TMPFS.  
[R0TT-Plus.sh] Template will Extract R0TT-M0D.ZIPs to that Directory in TMPFS.  

## INSTALLATION  
***You MUST INSTALL Rise of the Triad Dark War from RetroPie Setup 1st! [rott-darkwar]***  
*eg. from [Exarkuniv/RetroPie-Extra/ports/rott-darkwar](https://github.com/Exarkuniv/RetroPie-Extra/blob/master/scriptmodules/ports/rott-darkwar.sh)  

Can be ran from retropiemenu:  

```bash
wget https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/rott-darkwar_plus.sh -P ~/RetroPie/retropiemenu
wget https://raw.githubusercontent.com/RapidEdwin08/rott-darkwar-plus/main/rott-darkwar-plus.png -P ~/RetroPie/retropiemenu/icons
```

0R Run Manually from any directory:  
```bash
cd ~
git clone --depth 1 https://github.com/RapidEdwin08/rott-darkwar-plus.git
sudo chmod 755 ~/rott-darkwar-plus/rott-darkwar_plus.sh
cd ~/rott-darkwar-plus && ./rott-darkwar_plus.sh
```

0ptionally you can Add an Entry and Icon to your retropiemenu [gamelist.xml]:  
*Example Entry:*  
```
	<game>
		<path>./rott-darkwar_plus.sh</path>
		<name>[rott-darkwar+] Rise of the Triad Dark War Plus</name>
		<desc>INSTALL/REMOVE [rott-darkwar+] for [RetroPie].</desc>
		<image>./icons/rott-darkwar-plus.png</image>
	</game>
```

## REFERENCES   


***SOURCES:***  
[Exarkuniv/RetroPie-Extra](https://github.com/Exarkuniv/RetroPie-Extra)  
