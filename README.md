# Kangadesk Mate Setup
This Guide will take you through the steps of updating your Kangadesk Mate.

NOTE
----------------------
(1) Requires Raspbian OS to run.
<br />
(2) Before installing / updating the necessary addons to run your Mate, the updater will run through the system update process on your system. No need to run these commands:

apt-get update
apt-get upgrade
apt-get dist-upgrade


To get started with the updater, please run this command inside of the terminal window.

wget -O - "https://raw.githubusercontent.com/kangadesk/kangadesk-mate/master/update.sh" | sudo bash
