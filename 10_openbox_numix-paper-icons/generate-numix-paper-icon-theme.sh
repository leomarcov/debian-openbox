#!/bin/bash
#===================================================================================
# FILE: generate-numix-paper-icon-theme.sh.sh
# DESCRIPTION: Generates new icon theme based on Numix (using folder grey icons) and Paper
# REQUIREMENTS: numix-icon-theme [paper-icon-theme] [bunsen-paper-icon-theme]
# AUTHOR: Leonardo Marco
# VERSION: 1.0
# CREATED: 21.05.2018
# MODIFIED: 20.04.219
#===================================================================================

# CHECKS
read -p "Install directory (/usr/share/icons/): " install_dir
[ ! "$install_dir" ] && install_dir="/usr/share/icons"
install_dir="$install_dir/Numix-Paper/"

numix_dir="$(dirname "$install_dir")/Numix"
paper_dir="$(dirname "$install_dir")/Paper"

if [ ! -d "$numix_dir" ]; then
	echo "Numix icon theme sould be installed in $numix_dir, but not found"
	exit 1
fi
if [ ! -d "$paper_dir" ]; then
	echo "Paper icon theme sould be installed in $paper_dir, but not found"
	read -p "Continue using only Numix icons? (Y/n) " q
	[ "${q,,}" = "n" ] && exit 0
fi


echo -e "\nGENERATING $install_dir dirs"
[ ! -d "$install_dir" ] && mkdir -v "$install_dir"
[ ! -w /"$install_dir" ] && echo "Can't create $install_dir directory" && exit 1
cp "$(readlink -f "$0")" "$install_dir"

cd "$install_dir"
find . ! -name "$(basename $0)" -exec rm -rf {} \; 2> /dev/null  # Delete all unless this script
cp "$numix_dir/index.theme" "$install_dir"
sed -i "s/^Name *= *.*/Name=Numix-Paper/" "$install_dir/index.theme"
sed -i "s/^Inherits *= *.*/Inherits=Numix/" "$install_dir/index.theme"
sed -i "s/^Comment *= *.*/Comment=Theme mix Numix-Paper for BunsenLabs/" "$install_dir/index.theme"
for d in $(find ../Numix/ -type d); do
	[ "$d" == "../Numix" ] && continue
	mkdir -v $(echo "$d" | sed 's/..\/Numix\///g' ) 
done

if [ -d "$paper_dir" ]; then
	echo -e "\nºnGENERATING PAPER LINKS..."
	for f in $(ls ../Paper/*/apps/* ../Paper/*/panel/*); do
		ln -svf "../../$f" $(echo "$f" | sed 's/..\/Paper\///g' | sed 's/^[0-9]\+x//g') 2> /dev/null
	done
	# Change terminator icon for terminal 
	for f in $(find . -name "terminator.*"); do
		ln -svf "$(basename $(echo "$f"  | sed 's/terminator/terminal/g'))" "$f" 
	done	
	# Add xfce4-power-manager-settings icon
	for f in $(ls ../Paper/*/categories/xfpm-ac-adapter.png); do
		ln -svf "../../$f" $(echo "$f" | sed 's/..\/Paper\///g' | sed 's/^[0-9]\+x//g' | sed 's/categories/apps/g') 2> /dev/null
	done
fi

echo -e "\n\nGENERATING NUMIX LINKS..."
default_color="grey"
for link in $(find ../Numix/ -mindepth 2 -type l); do 
	linked_name=$(basename $(readlink -f "$link"))
	echo "$linked_name" | grep "default" &> /dev/null|| continue
	linked_path=$(dirname $link)/$(echo $linked_name | sed 's/default/'$default_color'/g')
	[ ! -f "$linked_path" ] && continue

	ln -vsf "../../$linked_path" $(echo "$link" | sed 's/..\/Numix\///g')
done

# Add clipman icon linked to clipboard icon
for f in $(find ../Numix/ -name "*clipman*"); do
	src="$(echo "$f"  | sed 's/..\/Numix\///g' | sed 's/status/panel/g' | sed 's/clipman/clipboard/g')"
	[ -r "$src" ] && ln -vs  "../../$src" $(echo "$f"  | sed 's/..\/Numix\///g')
done
