#!/bin/bash


#Run Root
if [[ $EUID -ne 0 ]]; then
   echo "Please execute as root." 
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
sudo mkdir KangaPi
cd /opt/KangaPi
script=Shutdown.py

if [ -e $script ];
	then
		echo "Script Shutdown.py already exists. Doing nothing."
	else
		wget "https://raw.githubusercontent.com/kangadesk/kanga-pi/master/shutdown.py"
fi
#

#Auto Run
cd /etc/
RC=rc.local

if grep -q "sudo python3 \/opt\/KangaPi\/Shutdown.py \&" "$RC";
	then
		echo "File /etc/rc.local already configured. Doing nothing."
	else
		sed -i -e "s/^exit 0/sudo python3 \/opt\/KangaPi\/shutdown.py \&\n&/g" "$RC"
		echo "File /etc/rc.local configured."
fi
#

#Reboot
echo "Kangadesk installation complete. Enjoy! System will now reboot in 9 seconds."
sleep 3
sudo reboot
#
