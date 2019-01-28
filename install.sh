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
sudo mkdir kangadesk/pi
cd /opt/kangadesk/pi
script=shutdown.py

if [ -e $script ];
	then
		echo "Shutdown Script already exists. Doing nothing."
	else
		wget "https://raw.githubusercontent.com/kangadesk/kanga-pi/master/shutdown.py"
fi
#

#Auto Run
cd /etc/
RC=rc.local

if grep -q "sudo python3 \/opt\/kangadesk\/pi\/shutdown.py \&" "$RC";
	then
		echo "File /etc/rc.local already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python3 \/opt\/kangadesk\/pi\/shutdown.py \&\n&/g" "$RC"
		echo "File /etc/rc.local configured."
fi
#

#Reboot
echo "Kangadesk Pi Addons Install Complete. Enjoy! System will now reboot in 10 seconds."
sleep 10
sudo reboot
#
