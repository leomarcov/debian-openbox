#!/bin/bash
# ACTION: Install pnmixer and pavucontrol volume control
# INFO: Openbox dont include tools for manage sound devices
# DEFAULT: y

# Install packages
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
su nobody -c 'paru -Sy pnmixer pavucontrol --noconfirm'

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel /home/*/ /root; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

	# Create config folders if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	d="$d/pnmixer/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Set theme icon
	f="$d/config"
	if [ ! -f "$f" ]; then
		echo -e "[PNMixer]\nSystemTheme=true\nVolumeControlCommand=pavucontrol" > "$f" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$f"
	else
		sed -i 's/SystemTheme=.*/SystemTheme=true/' "$f"
	fi
done



