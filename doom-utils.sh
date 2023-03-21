#!/bin/bash
# https://github.com/RapidEdwin08/doom-utils

doomguyLOGO=$(
echo '
                                _###_         
                               ##%#%#*        
                              *#%.%.%#*       
                            :*###%%%###%:..:**
                           :#*%@%@%%%%%%%###* 
                           :#*#%@%%@@@%%***   
                              :@@%@@@@#       
                              :%%@@%%%%            (\\   
                              .:%@%@@#:             \||  
            _______             :%%@@#            __(_"; 
           |SHELLS |=|          :%%@@#           /    \  
           |_______|_|           %%@#           {}___)\)_

')

mainMENU()
{
# Confirm Utility
pickUTIL=$(dialog --no-collapse --title "  [D00M Utilities]" \
	--ok-label OK --cancel-label EXIT \
	--menu "                 #  https://github.com/RapidEdwin08  # $doomguyLOGO" 25 75 20 \
	1 " SIJL [LZDoom + JoyPad Mappings] " \
	2 " DAZI [D00M M0D Loader Utility] " \
	3 " IMP [Integrated Music Player] " \
	4 " metapixel-doomed [ES Theme] " 2>&1>/dev/tty)
	
# Utilities
if [ ! "$pickUTIL" == '' ]; then
	if [ "$pickUTIL" == '1' ]; then
		curl -sSL https://raw.githubusercontent.com/RapidEdwin08/sijl/main/lzdoom-sijl.sh  | bash
	fi
	
	if [ "$pickUTIL" == '2' ]; then
		curl -sSL https://raw.githubusercontent.com/RapidEdwin08/dazi/main/lzdoom-dazi.sh  | bash
	fi
	
	if [ "$pickUTIL" == '3' ]; then
		# Confirm
		confIMP=$(dialog --no-collapse --title "               Integrated Music Player [IMP]               " \
			--ok-label OK --cancel-label Back \
			--menu "                 DOWNLOAD and RUN Latest IMP Installer           \nNOTE: This will REPLACE Current [$HOME/imp] + [imp-setup.tar.gz]" 25 75 20 \
			1 "><  INSTALL Integrated Music Player [IMP]  ><" \
			2 "Back" 2>&1>/dev/tty)
		# Confirmed - Otherwise Back to Main Menu
		if [ "$confIMP" == '1' ]; then
			tput reset
			cd ~ #Change to Home Directory
			rm ~/imp-setup.tar.gz
			rm ~/imp -R -f #ALWAYS PROCEED WITH CAUTION USING rm .. -R -f
			
			wget https://github.com/RapidEdwin08/imp/releases/download/v2023.03/imp-setup.tar.gz -P ~/
			tar xvzf imp-setup.tar.gz -C ~/
			sudo chmod 755 ~/imp/imp_setup.sh
			cd ~/imp && ./imp_setup.sh
		fi
		mainMENU
	fi
	
	if [ "$pickUTIL" == '4' ]; then
		# Confirm
		confTHEME=$(dialog --no-collapse --title "      A Fork of mattrixk's metapixel theme with just a hint of D00M               " \
			--ok-label OK --cancel-label Back \
			--menu "     # SOURCE: https://github.com/mattrixk/es-theme-metapixel #" 25 75 20 \
			1 "><  INSTALL metapixel-doomed [Theme]  ><" \
			2 "><  REMOVE metapixel-doomed [Theme]  ><" \
			3 "Back" 2>&1>/dev/tty)
		# Confirmed - Otherwise Back to Main Menu
		if [ "$confTHEME" == '1' ]; then
			if [[ ! -d /opt/retropie/configs/all/emulationstation/themes/metapixel-doomed ]]; then
				tput reset
				mkdir /opt/retropie/configs/all/emulationstation/themes > /dev/null 2>&1
				cd /opt/retropie/configs/all/emulationstation/themes
				git clone --depth 1 https://github.com/RapidEdwin08/metapixel-doomed.git
				cd ~
			fi
			dialog --no-collapse --title "   metapixel-doomed [Theme] INSTALLED  " --ok-label Back --msgbox " [/opt/retropie/configs/all/emulationstation/themes]: \n $(ls /opt/retropie/configs/all/emulationstation/themes)"  25 75
		fi
		if [ "$confTHEME" == '2' ]; then
			cd ~
			rm /opt/retropie/configs/all/emulationstation/themes/metapixel-doomed -R -f
			dialog --no-collapse --title "   metapixel-doomed [Theme] REMOVED  " --ok-label Back --msgbox " [/opt/retropie/configs/all/emulationstation/themes]: \n $(ls /opt/retropie/configs/all/emulationstation/themes)"  25 75
		fi
		mainMENU
	fi
	mainMENU
fi

if [ "$pickUTIL" == '' ]; then tput reset; exit 0; fi

mainMENU
}


mainMENU

tput reset
exit 0
