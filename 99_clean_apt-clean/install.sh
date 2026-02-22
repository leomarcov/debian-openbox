#!/bin/bash
# ACTION: Remove unnecesary packages and clean autoremove and .deb packages
# INFO: APT stores a lot of unnecesary files and packages
# DEFAULT: n


# Uninstall unnecesary packages
echo -e "\e[1mUninstalling unnecesary packages...\e[0m"
apt-get purge -y gnome-keyring modemmanager yelp xdg-desktop-portal-gnome  geoclue-2.0 popularity-contest tasksel installation-report
apt-get purge -y fonts-noto-cjk fonts-noto-extra

# Clean documentation
echo 'path-exclude=/usr/share/doc/*
path-exclude=/usr/share/man/*
path-exclude=/usr/share/locale/*
path-include=/usr/share/locale/es*
path-include=/usr/share/locale/en*' > /etc/dpkg/dpkg.cfg.d/01_nodoc
dpkg -l | awk '/^ii/{print $2}' | xargs apt-get install --reinstall -y
 
# Uninstall unnecesary VirtualBox guest packages
if [ "$(systemd-detect-virt)" = "oracle" ]; then
	echo -e "\e[1mUninstalling unnecesary firmware packages for VirtualBox guest...\e[0m"
    apt purge -y firmware-realtek firmware-atheros firmware-mediatek firmware-misc-nonfree firmware-amd-graphics
fi

# APT autoremove and clean
echo -e "\e[1mCleaning packages and .deb files...\e[0m"
apt-get -y autoremove --purge
apt-get clean
