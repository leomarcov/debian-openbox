#!/bin/bash
# ACTION: Remove unnecesary packages and saved .deb files
# INFO: APT install some unnecesary recommended packages and stores lots of .deb files
# DEFAULT: n


# Uninstall unnecesary packages
echo -e "\e[1mUninstalling unnecesary packages...\e[0m"
pkg_list="gnome-keyring modemmanager* xdg-desktop-portal-gnome geoclue-2.0 popularity-contest tasksel* installation-report ipp-usb colord gstreamer* usb-modeswitch* libnss-mdns"
pkg_list="${pkg_list} fonts-noto-cjk fonts-noto-extra fonts-noto-ui-extra fonts-noto-unhinted fonts-freefont-ttf"
pkg_list="${pkg_list} gvfs* exim4* avahi*"
pkg_list="${pkg_list} cdrdao* libburn* libisofs*"
pkg_list="${pkg_list} debian-reference* debian-faq* doc-debian* docbook-xml sgml-data yelp*"
pkg_list="${pkg_list} build-essential gcc g++ make dpkg-dev fakeroot"
pkg_list="${pkg_list} nodejs* node-*"
pkg_list="${pkg_list} sane-utils sane-airscan libsane*"
apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')

# Uninstall unnecesary VirtualBox GUEST packages
if [ "$(systemd-detect-virt)" = "oracle" ]; then
	echo -e "\e[1mUninstalling unnecesary firmware packages for VirtualBox guest...\e[0m"
	pkg_list="firmware-*"
	apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')
fi

# Uninstall old kernels
echo -e "\e[1mUninstalling old kernels and headers...\e[0m"
pkg_list="linux-headers* linux-kbuild*"
for p in $(dpkg -l 'linux-image-[0-9]*' | awk '/^ii/{print $2}'); do
	v="${p#linux-image-}"
    dpkg --compare-versions "$v" lt $(uname -r) && pkg_list="${pkg_list} $p"
done
apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')

# APT autoremove and clean
echo -e "\e[1mCleaning packages and .deb files...\e[0m"
apt-get -y autoremove --purge
apt-get clean

echo -e "\e[1m\nAccording your neededs you may be to install:\e[0m
* gvfs: graphic access to automount USB, smb, ftp, mtp, trash, etc
* exim4: mail server
* avahi: mDNS to detect local hostnames
* build-essential gcc g++ make dpkg-dev: basic dev tools"

