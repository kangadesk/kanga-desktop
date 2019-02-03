#!/bin/bash

cd /opt/kangadesk/
File="VERSION.md"

if [ -d "$File" ]; 
	then
                sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "Mate Add-Ons Already Installed" 10 60
    		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/mate_setup.sh" | sudo bash
	else
		sleep 5
		whiptail --title "Mate Setup Wizard" --msgbox "Click OK to install Mate Add-Ons" 10 60
		wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/install.sh" | sudo bash
fi
