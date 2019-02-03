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

OPTIONS=(1 "Install Mate Packages"
         2 "Check For Available Updates"
         3 "Configure Raspi Settings"
         4 "Reboot")

CHOICE=$(whiptail --clear \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/install-control.sh" | sudo bash
            ;;
        2)
            wget -O - "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/packages/version-control.sh" | sudo bash
            ;;
            ;;
        3)
            sudo raspi-config
            ;;
        4)
            whiptail --title "Mate Setup Wizard" --msgbox "Please save your work before rebooting. Click OK to reboot." 10 60
            echo "Rebooting in 8 seconds..."
            sleep 8
            sudo reboot
            ;;
esac
