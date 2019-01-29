#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root." 
   exit 1
fi
#

#Welcome Message
whiptail --title "Kangadesk Setup" --msgbox "Click OK to install the necessary addon package for your Kangadesk Mate." 10 60

{
    for ((i = 0 ; i <= 100 ; i+=10)); do
        sleep 1
        echo $i
    done
#

#Update Repository
sudo apt-get update -y
#

#gpiozero Module Install
sudo apt-get install -y python3-gpiozero
#

#Install SafePowerOff Script
cd /opt/
sudo mkdir kangadesk
cd /opt/kangadesk
script=shutdown.py

if [ -e $script ];
	then
		echo "Shutdown Script already exists. Doing nothing."
	else
		wget "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/shutdown.py"
fi
#

#Enable SafePowerOff AutoRun
cd /etc/
RC=rc.local

if grep -q "sudo python3 \/opt\/kangadesk\/shutdown.py \&" "$RC";
	then
		echo "File /etc/rc.local already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python3 \/opt\/kangadesk\/shutdown.py \&\n&/g" "$RC"
		echo "File /etc/rc.local configured."
fi
#

#Custom Screen Settings
cd /boot/
File=config.txt
if grep -q "disable_splash=1" "$File";
	then
		echo "Rainbow Screen Already Disabled. Doing nothing."
	else
		echo "disable_splash=1" >> $File
		echo "Rainbow Screen disabled."
fi
#

#
cd /home/
sudo mkdir kangadesk
cd /home/kangadesk
curl -O -O https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/README.md https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/720677.jpg
pcmanfm --set-wallpaper /home/kangadesk/720677.jpg----
sudo cp /home/kangadesk/720677.jpg /usr/share/plymouth/themes/pix/splash.png
#

} | whiptail --gauge "Please wait while installing" 6 60 0

#Reboot Kangadesk Mate
whiptail --title "Setup Complete" --msgbox "Addons Installed Successfully. For More Info, Please Visit www.kangadesk.com. Click OK To Reboot" 10 60
echo "Your System will now reboot in 4 seconds."
sleep 4
sudo reboot
#
