#!/bin/bash
# ACTION: Remove unnecesary packages and saved .deb files
# INFO: APT stores a lot of unnecesary files and packages
# DEFAULT: n


# Uninstall unnecesary packages
echo -e "\e[1mUninstalling unnecesary packages...\e[0m"
apt-get purge -y gnome-keyring modemmanager yelp xdg-desktop-portal-gnome  geoclue-2.0 popularity-contest tasksel installation-report
apt-get purge -y fonts-noto-cjk fonts-noto-extra

 
# Uninstall unnecesary VirtualBox guest packages
if [ "$(systemd-detect-virt)" = "oracle" ]; then
	echo -e "\e[1mUninstalling unnecesary firmware packages for VirtualBox guest...\e[0m"
    apt-get purge -y firmware-realtek firmware-atheros firmware-mediatek firmware-misc-nonfree firmware-amd-graphics
fi

# APT autoremove and clean
echo -e "\e[1mCleaning packages and .deb files...\e[0m"
apt-get -y autoremove --purge
apt-get clean
