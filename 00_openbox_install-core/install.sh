#!/bin/bash
# ACTION: Install Openbox WM and essential tools and configs
# INFO: Openbox is a lightweight window manager, but needs some additional tools and configs for make it usable
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\e[1mInstalling packages...\e[0m"
paru -Sy openbox obconf xinit lxappearance compton xfce4-screenshooter xfce4-clipman xfce4-power-manager xfce4-settings arandr gsimplecal xcape gparted file-roller xautomation yad inxi networkmanager network-manager-applet --noconfirm

echo -e "\e[1mCopying themes and tools...\e[0m"
# Copy theme
tar -xzvf "$base_dir"/openbox_theme.tgz -C /usr/share/themes/
cp -rv "$base_dir/openbox-menu" /usr/share/icons/

# Install help docs
d="help"
cp -rv "$base_dir/$d" "/usr/share/doc/openbox/"

# Install system info dependences
#wget -P /usr/bin "https://raw.githubusercontent.com/pixelb/ps_mem/master/ps_mem.py" && chmod a+x /usr/bin/ps_mem.py
#wget -P /usr/bin "https://raw.githubusercontent.com/aristocratos/bashtop/master/bashtop" && chmod a+x /usr/bin/bashtop
paru -Sy s-tui dfc btop hwinfo --noconfirm

# Copy cups-session
cp -v ${base_dir}/cups-session /usr/bin
chmod a+x /usr/bin/cups-session
# Copy bt-session
cp -v ${base_dir}/bt-session /usr/bin
chmod a+x /usr/bin/bt-session
# Copy welcome
cp -v ${base_dir}/welcome /usr/bin
chmod a+x /usr/bin/welcome
cp -v ${base_dir}/welcome.desktop /user/share/applications/

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in /etc/skel /home/*/ /root; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes

	# Create config folder if no exists
	d="$d/.config/"; [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	
	# Copy compton file
	f="compton.conf"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"	
	# Copy mimeapps.list file
	f="mimeapps.list"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"	
	
	# Create config folders if no exists
	d2="$d"
	d="$d/openbox/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"

	# Copy openbox config file
	f="rc.xml"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"
	# Copy openbox autostart file
	f="autostart"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"
	# Copy openbox menu file
	f="menu.xml"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"	
	# Delete bluetooth item from menu if no BT present
	dmesg | grep -qi bluetooth || sed -i '/DEBIAN-OPENBOX-bluetooth/Id' "$d/$f"	
	# Create welcome link
	ln -s /usr/bin/welcome "$d/welcome"
	
	# Copy fonts.conf
	d="$d2/fontconfig/";  [ ! -d "$d" ] && mkdir -v "$d" && chown -R $(stat "$(dirname "$d")" -c %u:%g) "$d"
	f="fonts.conf"
	cp -v "$base_dir/$f" "$d" && chown -R $(stat "$d" -c %u:%g) "$d/$f"

done