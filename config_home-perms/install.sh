
#!/bin/bash
# ACTION: Config users home directories permissions to 750 
# INFO: By default permissions are 755 and has access permissions to all users
# DEFAULT: y

# Config variables
base_dir="$(dirname "$(readlink -f "$0")")"

# Check root
[ "$(id -u)" -ne 0 ] && { echo "Must run as root" 1>&2; exit 1; }

# Config adduser for create users with $HOME permisions 0750
[ -f /etc/adduser.conf ] && sed -i 's/DIR_MODE=[0-9]*/DIR_MODE=0750/g' /etc/adduser.conf

for d in  /home/*/; do
    [ "$(dirname "$d")" = "/home" ] && ! id "$(basename "$d")" &>/dev/null && continue	# Skip dirs that no are homes 
	
	# Set current home permissions
	chmod -v 0750 "$d"
done
