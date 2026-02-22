#!/bin/bash
# ACTION: Remove unnecesary packages and clean autoremove and .deb packages
# INFO: APT stores a lot of unnecesary files and packages
# DEFAULT: n


# Uninstall unnecesary packages
apt-get -y purge gnome-keyring modemmanager


# Uninstall unnecesary VirtualBox guest packages
if [ "$(systemd-detect-virt)" = "oracle" ]; then
    apt purge -y firmware-realtek firmware-atheros firmware-mediatek firmware-misc-nonfree firmware-amd-graphics
fi

# APT autoremove and clean
apt-get -y autoremove --purge
apt-get clean
