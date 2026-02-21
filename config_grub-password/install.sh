#!/bin/bash
# ACTION: Config GRUB with password protection for prevent users edit entries
# INFO: By default everyone can edit GRUB entries during boot time and login with root privileges
# DEFAULT: n

# Config variables
comment_mark="#DEBIAN-OPENBOX"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Ask for username and password
echo -n "Enter GRUB username: " ; read guser
if [[ ! "$guser" =~ ^[a-zA-Z0-9_-]+$ ]]; then
	echo "Username must math ^[a-zA-Z0-9_-]+$"
	exit 1
fi
echo -n "Enter password for $guser user: " ; read gpass
if [ ! "$gpass" ]; then
	echo "Password can't be empty"
	exit 1
fi

# Config user and password
echo -e "\e[1mSetting GRUB config...\e[0m"
pbkdf2_pass="$(echo -e "$gpass\n$gpass"| grub-mkpasswd-pbkdf2  | grep "grub.pbkdf2.*" -o)"
sed -i "/${comment_mark}/Id" /etc/grub.d/40_custom
echo "set superusers=\"$guser\"    $comment_mark
password_pbkdf2 $guser $pbkdf2_pass   $comment_mark" | tee -a /etc/grub.d/40_custom 

# Config others users for select entry
for f in /etc/grub.d/*; do 
	sed -i 's/--unrestricted//g' "$f"
	sed -i 's/\bmenuentry\b/menuentry --unrestricted /g' "$f" 
done

echo -e "\e[1mUpdating GRUB...\e[0m"
update-grub
