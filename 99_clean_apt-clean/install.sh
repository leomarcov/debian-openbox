#!/bin/bash
# ACTION: Remove unnecesary packages and saved .deb files
# INFO: APT install some unnecesary recommended packages and stores lots of .deb files
# DEFAULT: n


# Uninstall unnecesary packages
echo -e "\n\e[1mUninstalling unnecesary packages...\e[0m"
pkg_list="gnome-keyring modemmanager* xdg-desktop-portal-gnome geoclue-2.0 popularity-contest tasksel* installation-report ipp-usb colord usb-modeswitch* libnss-mdns cdrdao"
pkg_list="${pkg_list} fonts-noto-cjk fonts-noto-extra fonts-noto-ui-extra fonts-noto-unhinted fonts-freefont-ttf"
pkg_list="${pkg_list} exim4* avahi*"
pkg_list="${pkg_list} debian-reference* debian-faq* doc-debian* docbook-xml sgml-data yelp*"
pkg_list="${pkg_list} build-essential gcc g++ make dpkg-dev fakeroot"
pkg_list="${pkg_list} nodejs* node-*"
pkg_list="${pkg_list} sane-utils sane-airscan libsane*"
apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')

# Uninstall unnecesary VirtualBox GUEST packages
if [ "$(systemd-detect-virt)" = "oracle" ]; then
	echo -e "\n\e[1mUninstalling unnecesary firmware packages for VirtualBox guest...\e[0m"
	pkg_list="firmware-*"
	apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')
fi

# Uninstall old kernels
echo -e "\n\e[1mUninstalling old kernels and headers...\e[0m"
pkg_list="linux-headers* linux-kbuild*"
for p in $(dpkg -l 'linux-image-[0-9]*' | awk '/^ii/{print $2}'); do
	v="${p#linux-image-}"
    dpkg --compare-versions "$v" lt $(uname -r) && pkg_list="${pkg_list} $p"
done
apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')


# Uninstall graphics drivers
echo -e "\n\e[1mUninstalling unused graphics drivers...\e[0m"
unset pkg_list
if systemd-detect-virt -q; then
    virt=$(systemd-detect-virt)
    case "$virt" in
        oracle) 	gpu_pkgs=""							    ;;
        vmware) 	gpu_pkgs="xserver-xorg-video-vmware" 	;;
        qemu|kvm)   gpu_pkgs="xserver-xorg-video-qxl"    	;;
		*)      	gpu_pkgs=""							 	;;
    esac
else
	gpu="$(lspci -nn | grep -Ei 'vga|3d|display')"
    if echo "$gpu" | grep -qi intel; then
        gpu_pkgs="xserver-xorg-video-intel firmware-intel-graphics"
    elif echo "$gpu" | grep -qi amd; then
        gpu_pkgs="xserver-xorg-video-amdgpu firmware-amd-graphics"
    elif echo "$gpu" | grep -qi nvidia; then
        dpkg -l | grep -q '^ii  nvidia-driver'
		[ $? -eq 0 ] && gpu_pkgs="nvidia-driver firmware-misc-nonfree" || gpu_pkgs="xserver-xorg-video-nouveau firmware-misc-nonfree"            
    fi
fi
unset pkg_list
for p in $(dpkg -l 'xserver-xorg-video-*' | awk '/^ii/{print $2}') $(dpkg -l 'firmware-*graphics' | awk '/^ii/{print $2}'); do
	echo "$gpu_pkgs" | grep -qw "$p" || pkg_list="${pkg_list} ${p}"
done
echo "$pkg_list"
apt-get purge -y $(set -f; dpkg -l $pkg_list 2>/dev/null | awk '/^ii/{print$2}')


# APT autoremove and clean
echo -e "\n\e[1mCleaning packages and .deb files...\e[0m"
apt-get -y autoremove --purge
apt-get clean

echo -e "\e[1m\nAccording your neededs you may need to install:\e[0m
* \e[1mexim4\e[0m: mail server
* \e[1mavahi\e[0m: mDNS to detect local hostnames
* \e[1mbuild-essential gcc g++ make dpkg-dev\e[0m: basic dev tools"

