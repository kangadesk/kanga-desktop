#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run updater as root." 
   exit 1
fi
#

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
TITLE="Title here"
MENU="Choose one of the following options:"

OPTIONS=(1 "Install Mate Addon Packages"
         2 "Upgrade Exsisitng Packages"
         3 "Configure Your Mate")

CHOICE=$(dialog --clear \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "You chose Option 1"
            ;;
        2)
            echo "You chose Option 2"
            ;;
        3)
            echo "You chose Option 3"
            ;;
esac
