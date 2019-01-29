#!/bin/bash

#Run Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root." 
   exit 1
fi
#

#Update Repo
sudo apt-get update -y
#

#gpiozero Module Install
sudo apt-get install -y python3-gpiozero
#

#Download Python Script
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

#Auto Run
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

#Additional Steps
cd /home/
sudo mkdir kangadesk
cd /home/kangadesk
wget  "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/README.md"
wget  "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/720677.jpg"
pcmanfm --set-wallpaper /home/kangadesk/720677.jpg
sudo cp /home/kangadesk/720677.jpg /usr/share/plymouth/themes/pix/splash.png
#

#Reboot
echo "Kangadesk Mate Addons Installed Successfully. Enjoy! System will now reboot in 7 seconds."
sleep 7
sudo reboot
#
