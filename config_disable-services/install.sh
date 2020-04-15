#!/bin/bash
# ACTION: Disable some unnecessary services for no start in boot time
# INFO: Some services included in Debian are unnecesary for most usres (like NetworkManager-wait-online.service, ModemManager.service or pppd-dns.service)
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

systemctl mask NetworkManager-wait-online.service
systemctl status NetworkManager.service &>/dev/null && systemctl networking disable
systemctl disable wpa_supplicant			# No mask, may be needed by network manager
systemctl disable ModemManager.service
systemctl disable pppd-dns.service
