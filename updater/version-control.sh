#!/bin/bash

{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done
}| whiptail --gauge "Checking For Updates" 6 60 0    


cd /opt/mate/
File=VERSION.md
if grep -q "V:0.0.1" "$File";
	then
		sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "System up to date running Version 0.0.1. Click OK To return to main menu." 10 60
    		wget -O - "https://raw.githubusercontent.com/pilelu/mate-desktop/master/mate_setup.sh" | sudo bash
	else
		sleep 5
		whiptail --title "Mate Setup Wizard" --msgbox "Mate Desktop Not Detected. Please install it from the main menu." 10 60
		wget -O - "https://raw.githubusercontent.com/pilelu/mate-desktop/master/mate_setup.sh" | sudo bash
fi
