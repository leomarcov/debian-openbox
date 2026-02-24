#!/bin/bash
# ACTION: Remove unnecesary packages and saved .deb files
# INFO: APT install some unnecesary recommended packages and stores lots of .deb files
# DEFAULT: y


# Uninstall unnecesary packages
echo -e "\e[1mUninstalling unnecesary packages...\e[0m"
pkg_list="${pkg_list} gnome-keyring modemmanager yelp xdg-desktop-portal-gnome geoclue-2.0 popularity-contest tasksel installation-report"
pkg_list="${pkg_list} fonts-noto-cjk fonts-noto-extra fonts-noto-ui-extra fonts-noto-unhinted fonts-freefont-ttf "
pkg_list="${pkg_list} gvfs* exim4*"
pkg_list="${pkg_list} xfce4-settings xfce4-helpers"
pkg_list="${pkg_list} brasero-common cdrdao"
pkg_list="${pkg_list} debian-reference-es debian-faq doc-debian"
pkg_list="${pkg_list} build-essential gcc g++ make dpkg-dev fakeroot"
pkg_list="${pkg_list} nodejs* node-*"
pkg_list="${pkg_list} sane-utils sane-airscan libsane*"
pkg_list=$(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')	 # Clean pkg_list with only installed packages
apt-get purge -y ${pkg_list}

# Uninstall unnecesary VirtualBox guest packagesevin	
if [ "$(systemd-detect-virt)" = "oracle" ]; then
	echo -e "\e[1mUninstalling unnecesary firmware packages for VirtualBox guest...\e[0m"
    apt-get purge -y firmware-*
fi

# APT autoremove and clean
echo -e "\e[1mCleaning packages and .deb files...\e[0m"
apt-get -y autoremove --purge
apt-get clean
