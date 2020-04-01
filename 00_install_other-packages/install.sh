
#!/bin/bash
# ACTION: Add contrib and non-free repositories and install some basic packages
# INFO: Useful packages: rar ttf-mscorefonts-installer
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Add contrib and non-free sections
deb_lines="deb http://deb.debian.org/debian/ buster main
deb-src http://deb.debian.org/debian/ buster main
deb http://security.debian.org/debian-security buster/updates main
deb-src http://security.debian.org/debian-security buster/updates main
deb http://deb.debian.org/debian/ buster-updates main
deb-src http://deb.debian.org/debian/ buster-updates main"

(
IFS=$'\n'
for l in $deb_lines; do
	sed -i "s\\^$l$\\$l contrib non-free\\" /etc/apt/sources.list
done
)


# Update and install packages
apt-get update  
apt-get install ttf-mscorefonts-installer rar
