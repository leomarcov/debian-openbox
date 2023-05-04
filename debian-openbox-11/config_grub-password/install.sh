#!/bin/bash
# ACTION: Config GRUB with password protection for prevent users edit entries
# INFO: By default everyone can edit GRUB entries during boot time and login with root privileges
# DEFAULT: n

# Config variables
comment_mark="#DEBIAN-OPENBOX"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Ask for password
read -p "Enter password for admin user: " pass
if [ ! "$pass" ]; then
	echo "Password can't be empty"
	exit 1
fi

# Config admin user and password
echo -e "\e[1mSetting GRUB config...\e[0m"
pbkdf2_pass="$(echo -e "$pass\n$pass"| grub-mkpasswd-pbkdf2  | grep "grub.pbkdf2.*" -o)"
sed -i "/${comment_mark}/Id" /etc/grub.d/40_custom
echo 'set superusers="admin"    '"$comment_mark"'
password_pbkdf2 admin '"$pbkdf2_pass   $comment_mark" | tee -a /etc/grub.d/40_custom 

# Config others users for select entry
for f in /etc/grub.d/*; do 
	sed -i 's/--unrestricted//g' "$f"
	sed -i 's/\bmenuentry\b/menuentry --unrestricted /g' "$f" 
done

echo -e "\e[1mUpdating GRUB...\e[0m"
update-grub
