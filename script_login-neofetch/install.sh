#!/bin/bash
# ACTION: Config Linux login in text mode (tty) with neofetch style and config tty locker (physlock)
# INFO: Login in text is fast, light and cool. This script install a neofetch style tty login and a tty locker (physlock) for reautenticate users when go back from suspend or lock screen
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX-ttyloginneofetch"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Config runlevel 3
systemctl set-default multi-user.target

# Install physlock
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get -y install physlock neofetch
	
# Config physlock for start after suspend
cp "$base_dir"/physlock.service /etc/systemd/system/
systemctl enable physlock.service
	
# Config tty1 to autoexec startx
sed -i "/$comment_mark/Id" /etc/profile
echo '[ ! "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ] && PROMPT_COMMAND="startx; exit;" '"$comment_mark" >> /etc/profile

# Copy script and config files:
cp -v /etc/issue /etc/issue.old
[ ! -d "/etc/systemd/system/getty@.service.d/" ] && mkdir -vp "/etc/systemd/system/getty@.service.d/"
[ ! -d "/usr/share/neofetch/" ] && mkdir -vp "/usr/share/neofetch/"
cp -v "$base_dir/config_tty" /usr/share/neofetch/
cp -v "$base_dir/neofetch_issue.sh" /usr/bin/
chmod -v a+x /usr/bin/neofetch_issue.sh
	
# Config getty to run neofetch_issue.sh every time tty start:
echo '[Service]
ExecStartPre=-/bin/bash -c "/usr/bin/neofetch_issue.sh"' | tee "/etc/systemd/system/getty@.service.d/override.conf"

# Add physlock as x-locker alternative
update-alternatives --install /usr/bin/x-locker x-locker $(which physlock) 90

