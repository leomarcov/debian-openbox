#!/bin/bash
# ACTION: Install Openbox WM and essential tools and configs
# INFO: Openbox is a lightweight window manager, but needs some additional tools and configs for make it usable
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Install packages
echo -e "\n\e[1mInstalling packages...\e[0m"
[ "$(find /var/cache/apt/pkgcache.bin -mtime 0 2>/dev/null)" ] || apt-get update

apt-get install -y xserver-xorg xserver-xorg-core xserver-xorg-input-libinput xinit xauth x11-common x11-utils x11-xserver-utils x11-xkb-utils xkb-data xterm dbus dbus-x11 dbus-user-session polkitd ukui-polkit
apt-get install -y xdg-utils xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-gtk xdg-dbus-proxy shared-mime-info desktop-file-utils
apt-get install -y openbox obconf lxappearance compton xfce4-clipman xfce4-power-manager upower xfce4-settings arandr gsimplecal xcape file-roller xautomation yad inxi
apt-get install -y libcanberra-gtk3-0 adwaita-icon-theme gtk-update-icon-cache gsettings-desktop-schemas
apt-get install -y network-manager network-manager-applet wpasupplicant wireless-regdb
systemctl disable NetworkManager-wait-online.service

# Installing graphics drivers
echo -e "\n\e[1mInstalling graphics drivers...\e[0m"
if systemd-detect-virt -q; then
    virt=$(systemd-detect-virt)
    case "$virt" in
        oracle) 	gpu_pkgs="xserver-xorg-video-vbox"    ;;
        vmware) 	gpu_pkgs="xserver-xorg-video-vmware" ;;
        qemu|kvm)   gpu_pkgs="xserver-xorg-video-qxl"    ;;
        *)          gpu_pkgs="xserver-xorg-video-fbdev"  ;;
    esac
else
	gpu="$(lspci -nn | grep -Ei 'vga|3d|display')"
    if echo "$gpu" | grep -qi intel; then
        gpu_pkgs="xserver-xorg-video-intel firmware-misc-nonfree"
    elif echo "$gpu" | grep -qi amd; then
        gpu_pkgs="xserver-xorg-video-amdgpu firmware-amd-graphics"
    elif echo "$gpu" | grep -qi nvidia; then
        dpkg -l | grep -q '^ii  nvidia-driver'
		[ $? -eq 0 ] && gpu_pkgs="nvidia-driver firmware-misc-nonfree" || gpu_pkgs="xserver-xorg-video-nouveau firmware-misc-nonfree"            
    else
        gpu_pkgs="xserver-xorg-video-fbdev"
    fi
fi
apt-get install -y $gpu_pkgs

echo -e "\n\e[1mCopying themes and tools...\e[0m"
# Copy theme
tar -xzvf "$base_dir"/openbox_theme.tgz -C /usr/share/themes/
cp -rv "$base_dir/openbox-menu" /usr/share/icons/

# Install help docs
d="help"
cp -rv "$base_dir/$d" "/usr/share/doc/openbox/"

# Install system info dependences
wget -P /usr/bin "https://raw.githubusercontent.com/pixelb/ps_mem/master/ps_mem.py" && chmod a+x /usr/bin/ps_mem.py
sed -i 's/#\!\/usr\/bin\/env python/#\!\/usr\/bin\/env python3/g' /usr/bin/ps_mem.py
wget -P /usr/bin "https://raw.githubusercontent.com/aristocratos/bashtop/master/bashtop" && chmod a+x /usr/bin/bashtop
apt-get install -y s-tui dfc htop hwinfo

# Copy cups-session
cp -v ${base_dir}/cups-session /usr/bin
chmod a+x /usr/bin/cups-session
# Copy bt-session
cp -v ${base_dir}/bt-session /usr/bin
chmod a+x /usr/bin/bt-session
# Copy welcome
cp -v ${base_dir}/welcome /usr/bin
chmod a+x /usr/bin/welcome
cp -v ${base_dir}/welcome.desktop /usr/share/applications/

# Copy users config
echo -e "\n\e[1mSetting configs to all users...\e[0m"
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


# Set as default
echo -e "\n\e[1mSetting as default alternative...\e[0m"
update-alternatives --set x-session-manager /usr/bin/openbox-session
