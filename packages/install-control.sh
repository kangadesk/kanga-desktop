#!/bin/bash

cd /etc/
File="os-release"
if grep -q "bian" "$File";
	then
		sleep 5
	else
		sleep 5
    		whiptail --title "Mate Setup Wizard" --msgbox "System not supported. Click OK To exit installer." 10 60
    		exit
fi

cd /opt/mate/
File="VERSION.md"
if [ -d "$File" ]; 
	then
              sleep 5
              Status="Fail"
	else
	      sleep 5
              Status="Pass"
fi
