#!/bin/bash
# ACTION: Remove unnecesary packages and clean autoremove and .deb packages
# INFO: APT stores a lot of unnecesary files and packages
# DEFAULT: y


if [ "$(systemd-detect-virt)" = "oracle" ]; then
    apt purge -y firmware-realtek firmware-atheros firmware-mediatek firmware-misc-nonfree
fi

apt-get -y autoremove --purge
apt-get clean
