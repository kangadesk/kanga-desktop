#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run setup as root." 
   exit 1
fi
#

#Install Check
cd /opt/kangadesk/
File=VERSION.md
VN="$(command | grep -oP '(?<=VERSION:).*' "$File";) "

if [ -d "$File" ]; 
	then
                sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "Mate is already installed. V $VN Click OK To return to main menu." 10 60
		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/mate_setup.sh" | sudo bash
	else
		sleep 5
		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/install.sh" | sudo bash
fi




cd /opt/kangadesk/
File=VERSION.md
if grep -q "V:0.0.1" "$File";
	then
		sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "System up to date. Click OK To return to main menu." 10 60
    		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/mate_setup.sh" | sudo bash
	else
		sleep 5
		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/install.sh" | sudo bash
fi
#
