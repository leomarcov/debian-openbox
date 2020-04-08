 
#!/bin/bash
# ACTION: Config to disable some unnecessary services (no start in boot time)
# INFO: Services are: NetworkManager-wait-online.service, ModemManager.service, pppd-dns.service
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

systemctl mask NetworkManager-wait-online.service
systemctl status NetworkManager.service &>/dev/null && systemctl networking disable
systemctl disable wpa_supplicant
systemctl disable ModemManager.service
systemctl disable pppd-dns.service
