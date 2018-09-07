#Script de preparation de l'image pour rpi en mode kiosque

sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade

sudo apt-get install chromium-browser unclutter lxde
sudo iwlist wlan0 scan

sudo echo "network={ssid='RVNetworkMobile' psk='42714271'}" >> "/etc/wpa_supplicant/wpa_supplicant.conf"

sudo echo "@xset s off" >> ~/.config/lxsession/LXDE/autostart
sudo echo "@xset -dpms" >> ~/.config/lxsession/LXDE/autostart
sudo echo "@xset s noblank" >> ~/.config/lxsession/LXDE/autostart
sudo echo "@sed -i s/"exited_cleanly": false /"exited_cleanly": true/' ~/.config/chromium-browser Default/Preferences" >> ~/.config/lxsession/LXDE/autostart
sudo echo "@chromium-browser --noerrdialogs --kiosk https://blockdev.io --incognito --disable-translate" >> ~/.config/lxsession/LXDE/autostart

sudo echo "@lxpanel --profile LXDE-pi" >> ~/.config/lxsession/LXDE/autostart
sudo echo "@pcmanfm --desktop --profile LXDE-pi" >> ~/.config/lxsession/LXDE/autostart

sudo reboot
