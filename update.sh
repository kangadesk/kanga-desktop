#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root." 
   exit 1
fi
#

#Welcome Message
whiptail --title "Kangadesk Setup" --msgbox "Click OK to update the necessary addon packages for your Kangadesk Mate." 10 60
#

#Fetching Updates Progress
{
    for ((i = 0 ; i <= 100 ; i+=5)); do
        sleep 1
        echo $i
    done
#

#Fetch Updates
sudo apt-get -y update
#

}| whiptail --gauge "Fetching Updates" 6 60 0


#System Package Progress
{
    for ((i = 0 ; i <= 100 ; i+=1)); do
        sleep 1
        echo $i
    done
#

#Update Repository
sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
#

#gpiozero Module Install
sudo apt-get install -y python3-gpiozero
#

}| whiptail --gauge "Updating System Packages" 6 60 0

#Update Firmware Progress
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done
#

#Create Directory
cd /opt/
directory="/opt/kangadesk"

if [ -d "$directory" ]; 
	then
                echo "Directory already exists. Doing nothing."
	else
		sudo mkdir kangadesk
fi
#

#Install SafePowerOff Script
cd /opt/kangadesk
script=shutdown.py

if [ -e $script ];
	then
		echo "Shutdown Script already exists. Doing nothing."
	else
		wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/shutdown.py"
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

}| whiptail --gauge "Updating Firmware" 6 60 0

#Moving Files Progress
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done
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

#Wallpaper Setup Files
cd /usr/share/
directory="/usr/share/rpd-wallpaper"

if [ -d "$directory" ]; 
	then
                sudo rm -r rpd-wallpaper
	else
		echo "Directory doesn't exist. Please create it."
fi

sudo mkdir rpd-wallpaper
cd /usr/share/rpd-wallpaper
#wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/road.jpg"
wget -m https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper
#mv wallpaper.jpg road.jpg
sudo cp /usr/share/rpd-wallpaper/road.jpg /usr/share/plymouth/themes/pix/splash.png
#

#
}| whiptail --gauge "Moving Files" 6 60 0
#

#Finishing Up Progress
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done
#

sudo apt-get clean

#
}| whiptail --gauge "Finishing Up" 6 60 0
#

#Reboot Kangadesk Mate
whiptail --title "Setup Complete" --msgbox "Addons Installed Successfully. For More Info, Please Visit www.kangadesk.com. Click OK To Reboot" 10 60
#echo "Your System will now reboot in 4 seconds."
#sleep 4
sudo reboot
#
