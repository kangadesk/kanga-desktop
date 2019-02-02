#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run updater as root." 
   exit 1
fi
#

show_menu () {
    # We show the host name right in the menu title so we know which Pi we are connected to
    OPTION=$(whiptail --title "Menu (Host:$(hostname))" --menu "Choose your option:" 12 36 5 \
    "1" "Current time" \
    "2" "Calendar" \
    "3" "Uptime" \
    "4" "Reboot Pi" \
    "5" "Shut down Pi"  3>&1 1>&2 2>&3)
 
    BUTTON=$?
    # Exit if user pressed cancel or escape
    if [[ ($BUTTON -eq 1) || ($BUTTON -eq 255) ]]; then
        exit 1
    fi
    if [ $BUTTON -eq 0 ]; then
        case $OPTION in
        1)
            MSG="$(date)"
            whiptail --title "Current time" --msgbox "$MSG" 8 36
            show_menu
            ;;
        2)
            # We use "ncal -h" to turn off highlighting of today's date since
            # highlighting produces non-printable chars that don't look good.
            whiptail --title "Calendar" --textbox /dev/stdin 13 26 <<<"$(ncal -bh)"
            show_menu
            ;;
        3)
            MSG="$(uptime)"
            whiptail --title "Uptime info" --msgbox "$MSG" 8 36
            show_menu
            ;;
        4)
            # For sensitive commands, we make sure they must press extra keys
            confirmAnswer "Are you sure you want to reboot the Pi?"
            if [ $? = 0 ]; then
                echo Rebooting...
                sudo reboot
            else
                show_menu
            fi
            ;;
        5)
            confirmAnswer "Are you sure you want to shut down the Pi?"
            if [ $? = 0 ]; then
                echo Shutting down...
                sudo poweroff
            else
                show_menu
            fi
            ;;
        esac
    fi  
}
