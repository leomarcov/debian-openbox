#!/bin/bash
# ACTION: Config Linux login in text mode (tty) using ufetch style and install a tty locker (physlock)
# INFO: Login in tty text mode is faster, light and cool
# INFO: This script config system to login in tty and show a login screen with ufetch info
# INFO: Additionaly install a tty locker (physlock) for reautenticate users when go back from suspend or lock screen
# INFO: and config tty1 to autostart X session when user login
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#ARCHLINUX-OPENBOX-loginfetch"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Config runlevel 3
systemctl set-default multi-user.target

# Install physlock
echo -e "\e[1mInstalling locker packages...\e[0m"
paru -Sy physlock --noconfirm
	
# Config physlock for start after suspend
cp "$base_dir"/physlock.service /etc/systemd/system/
systemctl enable physlock.service
	
# Config tty1 to autoexec startx
echo -e "\e[1mSetting tty1 to autostart X...\e[0m"
sed -i "/$comment_mark/Id" /etc/profile
echo '[ ! "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && PROMPT_COMMAND="startx && exit;" '"$comment_mark" >> /etc/profile

# Copy script and config files:
echo -e "\e[1mInstalling script loginfetch...\e[0m"
[ ! -f /etc/issue.net ] && touch /etc/issue.net
cp -v /etc/issue /etc/issue.old
cp -v "$base_dir/loginfetch" /usr/bin/
chmod -v a+x /usr/bin/loginfetch
	
# Config getty to run loginfetch every time tty login is displayed:
[ ! -d "/etc/systemd/system/getty@.service.d/" ] && mkdir -vp "/etc/systemd/system/getty@.service.d/"
echo '[Service]
ExecStartPre=-/bin/bash -c "/usr/bin/loginfetch"' | tee "/etc/systemd/system/getty@.service.d/override.conf"


