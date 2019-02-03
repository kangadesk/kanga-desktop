#!/bin/bash

cd /opt/kangadesk/
File="VERSION.md"
if [ -d "$File" ]; 
  then
                echo "Boot File already exists. Doing nothing."
	else
		wget -q "https://raw.githubusercontent.com/kangadesk/mate-desktop/master/etc/systemd/system/boot.service"
		echo "boot.service created."
fi
#
