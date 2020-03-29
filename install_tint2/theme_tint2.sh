#!/bin/bash
# ACTION: Install new tint2 theme
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

base_dir="$(dirname "$(readlink -f "$0")")"

# Check if laptop:
[ -f /sys/module/battery/initstate ] || [ -d /proc/acpi/battery/BAT0 ] && laptop="true"
# Check if virtualmachine:
cat /proc/cpuinfo | grep -i hypervisor &>/dev/null && virtualmachine="true"

for d in /usr/share/bunsen/skel/.config/tint2/  /home/*/.config/tint2/; do
	cp -v "$base_dir/"*tint* "$d"
	[ "$laptop" ] && [ ! "$virtualmachine" ] && tint_version="_laptop"
	
	# Set taskbar.tint and menu.tint as default tints
	echo "$d/taskbar${tint_version}.tint" > "$d/tint2-sessionfile"
	echo "$d/menu.tint" >> "$d/tint2-sessionfile"
done
