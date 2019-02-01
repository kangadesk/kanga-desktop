#!/bin/bash

#Run As Root
if [[ $EUID -ne 0 ]]; then
   echo "Please run updater as root." 
   exit 1
fi
#

echo "Please wait for the updater to finish installing updates..."
sleep 8

#Fetch Updates
sudo apt-get -y update
#

#Update Repository
sudo apt-get -y upgrade
sudo apt-get -y dist-upgrade
#

#gpiozero Module Install
sudo apt-get install -y python3-gpiozero
#

#fbi Install
sudo apt-get install -y fbi
#

echo "Please wait for the updater to finish installing updates..."
sleep 8

whiptail --title "Kangadesk Setup" --msgbox "Click OK to update the necessary addon packages for your Kangadesk Mate." 10 60

#Update Firmware
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done
#

#Enable UART
cd /boot/
File=config.txt
if grep -q "enable_uart=1" "$File";
	then
		echo "UART already enabled. Doing nothing."
	else
		echo "enable_uart=1" >> $File
		echo "UART enabled."
fi
#

#Create Kangadesk Directory
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
		wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/opt/kangadesk/shutdown.py"
fi
#

#Install FrameBuffer Script
cd /opt/kangadesk
script=framebuffer.py

if [ -e $script ];
	then
		echo "Framebuffer Script already exists. Doing nothing."
	else
		wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/opt/kangadesk/framebuffer.py"
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

#Moving Files
{
    for ((i = 0 ; i <= 100 ; i+=8)); do
        sleep 1
        echo $i
    done

cd /boot/
File=config.txt
if grep -q "disable_splash=1" "$File";
	then
		echo "Rainbow Screen Already Disabled. Doing nothing."
	else
		echo "disable_splash=1" >> $File
		echo "Rainbow Screen disabled."
fi

File=cmdline.txt
if grep -q "logo.nologo" "$File";
	then
		echo "Raspberry Pi logo Already Disabled. Doing nothing."
	else
		echo "logo.nologo" >> $File
		echo "Raspberry Pi logo Disabled."
fi

File=cmdline.txt
if grep -q "consoleblank=0 loglevel=1 quiet" "$File";
	then
		echo "Kernal Outputs Already Disabled. Doing nothing."
	else
		echo "consoleblank=0 loglevel=1 quiet" >> $File
		echo "Kernal Outputs Disabled."
fi

#Enable Custom Boot Splash
cd /etc/systemd/system/
File="splashscreen.service"

if [ -d "$File" ]; 
	then
                echo "File already exists. Doing nothing."
	else
		wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/etc/systemd/system/splashscreen.service"
		echo "splashscreen.service created."
fi
#

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
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/aurora.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/balloon.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/bridge.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/canyon.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/cliff.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/clouds.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/fisherman.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/fjord.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/road.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/sand.jpg"
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/rpd-wallpaper/waterfall.jpg"

wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/splash.png" -O /usr/share/plymouth/themes/pix/splash.png
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/README.md" -O /opt/kangadesk/README.md
wget -q "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/opt/kangadesk/splash.png" -O /opt/kangadesk/splash.png

}| whiptail --gauge "Moving Files" 6 60 0
#

#Finishing Up
{
    for ((i = 0 ; i <= 100 ; i+=20)); do
        sleep 1
        echo $i
    done

}| whiptail --gauge "Finishing Up" 6 60 0
#

#Reboot Kangadesk Mate
whiptail --title "Setup Complete" --msgbox "Addons Installed Successfully. For More Info, Please Visit www.kangadesk.com. Click OK To Reboot" 10 60
sudo systemctl enable boot-splashscreen.service
sudo systemctl start boot-splashscreen.service
sudo apt-get clean
echo "Your system will now reboot in 4 seconds."
sleep 4
sudo reboot
#
