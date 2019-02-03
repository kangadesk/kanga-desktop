#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run setup as root." 
   exit 1
fi
#

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
TITLE="Mate Setup Wizard"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Mate Add-on Packages"
         2 "Check For Available Updates"
         3 "Configure Mate Settings"
         4 "Configure Raspi Settings")

CHOICE=$(whiptail --clear \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/version-control.sh" | sudo bash
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
        4)
            sudo raspi-config
            ;;
esac
