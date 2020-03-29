#!/bin/bash
# ACTION: Config GRUB with password for prevent users edit entries
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

comment_mark="#BL-POSTINSTALL"

# Ask for password
read -p "Enter password for admin user: " pass
if [ ! "$pass" ]; then
	echo "Password can't be empty"
	exit 1
fi

# Config admin user and password
pbkdf2_pass="$(echo -e "$pass\n$pass"| grub-mkpasswd-pbkdf2  | grep "grub.pbkdf2.*" -o)"
sed -i "/${comment_mark}/Id" /etc/grub.d/40_custom
echo 'set superusers="admin"    '"$comment_mark"'
password_pbkdf2 admin '"$pbkdf2_pass   $comment_mark" | tee -a /etc/grub.d/40_custom 

# Config others users for select entry
for f in /etc/grub.d/*; do 
	sed -i 's/--unrestricted//g' "$f"
	sed -i 's/\bmenuentry\b/menuentry --unrestricted /g' "$f" 
done

update-grub
