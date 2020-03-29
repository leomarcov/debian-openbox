#!/bin/bash
# ACTION: Config text mode login using tty instead of lightdm display manager
# INFO: Login in text mode is cool and nerd. You can use tt1 login and physlock for enter your password when go back from suspend and lock screen. 
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

comment_mark="#bl-postinstall.sh"
base_dir="$(dirname "$(readlink -f "$0")")"

# Config runlevel 3
systemctl set-default multi-user.target
#apt-get -y remove lightdm

# Install physlock
find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get -y install physlock
	
# Config physlock as default locker
sed  -i 's/^LOCK_COMMAND *= *.*/LOCK_COMMAND=\(\/usr\/bin\/physlock\)/' /usr/bin/bl-lock
	
# Config physlock for start after suspend
cp "$base_dir"/physlock.service /etc/systemd/system/
systemctl enable physlock.service
	
# Config tty1 to autoexec startx
sed -i "/$comment_mark/Id" /etc/profile
echo '[ "$(tty)" = "/dev/tty1" ] && startx && exit   '"$comment_mark" >> /etc/profile

# Show neofetch info at login
which neofetch &>/dev/null || apt-get install neofetch
if which neofetch &>/dev/null; then
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
fi

# Remove light-locker
apt-get -y remove light-locker

# Solve tty error
for f in /etc/skel/.bash_logout /home/*/.bash_logout; do
	sed -i 's/clear_console/clear/g' "$f"
done
