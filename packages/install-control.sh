#!/bin/bash

cd /etc/
File="os-release"
if grep -q "ubuntu" "$File";
	then
		sleep 5
	else
		sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "System not supported. Click OK To exit." 10 60
    		exit
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
