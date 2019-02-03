#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run setup as root." 
   exit 1
fi
#

cd /etc/
File="os-release"
if grep -q "bian" "$File";
	then
		sleep 5
	else
		sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "System not supported. Click OK To return to main menu." 10 60
    		wget -O - "https://raw.githubusercontent.com/pilelu/mate-desktop/master/mate_setup.sh" | sudo bash
fi

cd /opt/mate/
File="VERSION.md"
if [ -d "$File" ]; 
	then
              sleep 5
              whiptail --title "Mate Setup Wizard" --msgbox "Mate Desktop already installed. Click OK To return to main menu." 10 60
	      wget -O - "https://raw.githubusercontent.com/pilelu/mate-desktop/master/mate_setup.sh" | sudo bash
	else
	      sleep 5
              wget -O - "https://raw.githubusercontent.com/pilelu/mate-desktop/master/packages/install.sh" | sudo bash
fi
