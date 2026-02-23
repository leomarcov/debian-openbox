#!/bin/bash
# ACTION: Remove unnecesary packages and saved .deb files
# INFO: APT install some unnecesary recommended packages and stores lots of .deb files
# DEFAULT: n


# Uninstall unnecesary packages
echo -e "\e[1mUninstalling unnecesary packages...\e[0m"
apt-get purge -y gnome-keyring modemmanager yelp xdg-desktop-portal-gnome geoclue-2.0 popularity-contest tasksel installation-report
apt-get purge -y fonts-noto-cjk fonts-noto-extra fonts-noto-ui-extra fonts-noto-unhinted fonts-freefont-ttf 
apt-get purge -y gvfs*
apt-get purge -y xfce4-settings xfce4-helpers
apt-get purge -y brasero-common cdrdao
apt-get purge -y debian-reference-es debian-faq doc-debian
apt-get purge -y build-essential gcc g++ make dpkg-dev fakeroot
apt-get purge -y purge nodejs nodejs-doc node-*
apt-get purge -y purge sane-utils sane-airscan
 
# Uninstall unnecesary VirtualBox guest packagesevin	
if [ "$(systemd-detect-virt)" = "oracle" ]; then
	echo -e "\e[1mUninstalling unnecesary firmware packages for VirtualBox guest...\e[0m"
    apt-get purge -y firmware-realtek firmware-atheros firmware-mediatek firmware-misc-nonfree firmware-amd-graphics
fi

# APT autoremove and clean
echo -e "\e[1mCleaning packages and .deb files...\e[0m"
apt-get -y autoremove --purge
apt-get clean
