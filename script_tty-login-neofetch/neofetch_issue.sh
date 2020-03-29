#!/bin/bash
#===================================================================================
# NEOFETCH TTY LOGIN THEME
# FILE: neofetch-tty-login.sh
#
# DESCRIPTION: Generate a /etc/issue file based on neofetch and other system info
#
# AUTHOR: Leonardo Marco
# VERSION: 1.0
# CREATED: 2018.06.05
#===================================================================================

issue="$(clear)"
issue="${issue}\e[90m\l\e[0m"
issue="${issue}\n$(neofetch --config /usr/share/neofetch/config_tty)"

issue="$(echo -e "$issue" | sed -z 's/\n\n\n/ /g')" 	# Sometimes neofetch add extra \n

# Pending updates
updates=$(wc -l /var/cache/update-notification 2>/dev/null | cut -f1 -d" ")
[ "$updates" -gt 0 ] &>/dev/null && issue="$(echo -e "$issue" | sed "/Packages/ s/$/($updates pending updates)/")"

# Add iface to local ip
iface=$(ip route get 8.8.8.8 | awk '{print $5}')
issue="$(echo -e "$issue" | sed "/Local IP/ s/$/($iface)/")"

# Show users:
issue="${issue}\n\n\e[1mUsers\e[0m: "
for u in $(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | tac); do 
	# Red if lock user:
	[ "$(passwd -S $u | cut -f2 -d" ")" = "L" ] && issue="${issue}\e[91m"
	# Add * to sudo users:
	grep -Po '^sudo.+:\K.*$' /etc/group | grep -w "$u" &>/dev/null && u="${u}*"
	
	issue="${issue}$u\e[0m  " 
done
issue="${issue}\n"

echo -e "$issue" > /etc/issue

