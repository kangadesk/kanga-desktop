#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run setup as root." 
   exit 1
fi
#

cd /opt/kangadesk/
File=VERSION.md
if grep -q "V:0.0.1" "$File";
	then
		sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "System up to date running Version 0.0.1. Click OK To return to main menu." 10 60
    		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/mate_setup.sh" | sudo bash
	else
		sleep 5
fi
#

#Mate Desktop Not Detected
sleep 5
whiptail --title "Mate Setup Wizard" --msgbox "Mate Desktop Not Detected. Click OK to install." 10 60
wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/install.sh" | sudo bash
