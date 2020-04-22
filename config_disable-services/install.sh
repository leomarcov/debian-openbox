#!/bin/bash
# ACTION: Disable some unnecessary services
# INFO: Some boot services included in Debian are unnecesary for most usres (like NetworkManager-wait-online.service, ModemManager.service or pppd-dns.service)
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

systemctl stop NetworkManager-wait-online.service
systemctl mask NetworkManager-wait-online.service

systemctl stop wpa_supplicant
systemctl disable wpa_supplicant	# No mask, may be needed by network manager

systemctl stop ModemManager.service
systemctl disable ModemManager.service

systemctl stop pppd-dns.service
systemctl disable pppd-dns.service

if systemctl status NetworkManager.service &>/dev/null; then
	#apt-get purge ifupdown
	systemctl networking disable

	#apt-get purge network-dispacher
	systemctl stop systemd-networkd.service
	systemctl disable systemd-networkd.service
fi
