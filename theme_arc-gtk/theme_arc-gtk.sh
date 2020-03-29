#!/bin/bash
# ACTION: Install theme Arc GTK and set as default
# INFO: Arc GTK theme is a clear and cool GTK theme. 
# DEFAULT: y

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

gtk_default="Arc"

find /var/cache/apt/pkgcache.bin -mtime 0 &>/dev/null ||  apt-get update  
apt-get -y install arc-theme

# Change accent color blue (#5294e2) for grey:
find /usr/share/themes/Arc -type f -exec sed -i 's/#5294e2/#b3bcc6/g' {} \;   
	
for f in  /usr/share/bunsen/skel/.gtkrc-2.0  /home/*/.gtkrc-2.0 ; do
	sed -i 's/^gtk-theme-name *= *.*/gtk-theme-name="'"$gtk_default"'"/' "$f"		
done
for f in  /usr/share/bunsen/skel/.config/gtk-3.0/settings.ini  /home/*/.config/gtk-3.0/settings.ini ; do
	sed -i 's/^gtk-theme-name *= *.*/gtk-theme-name='"$gtk_default"'/' "$f"
done	
