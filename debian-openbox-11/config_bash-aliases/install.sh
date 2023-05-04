#!/bin/bash
# ACTION: Config some useful aliases (for ls, grep and ip commands)
# INFO: Aliases allow exec commands fast with short name or including complex parameters
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"
comment_mark="#DEBIAN-OPENBOX"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Copy users config
echo -e "\e[1mSetting configs to all users...\e[0m"
for d in  /etc/skel/  /root  /home/*/; do
	[ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
    
	sed -i "/$comment_mark/Id" "$d/.bash_aliases" 2>/dev/null
	cat "$base_dir/bash_aliases" >> "$d/.bash_aliases"
done

# Load .bash_aliases from root .bashrc
grep -q ".bash_aliases" /root/.bashrc || echo '
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
' >> /root/.bashrc
