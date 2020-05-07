# Openbox script collection for Debian
<img align="left"  src="https://user-images.githubusercontent.com/32820131/79635263-47d9d580-8170-11ea-87b1-943144be83d7.png" width="90"> Openbox is a beautiful and lightweight window manager, but tediuos to install and config a full usable environment. This script collection automatize **Openbox** installation and essentials tools and apply configurations, styles and themes. You can install all scripts from bare Debian netinstall to config full environment or **exec only some scripts** you are interested. Each folder has a particular action script for install pacakges, add scripts, apply configs or install some themes or styles.

The main script `install` can exec all scripts or only a select list:
  * `install`: exec all scripts interactively.
  * `install -l`: list all scripts.
  * `install -d`: install all scripts with default option Y.
  * `install -a 5,8-12`: exec selected scripts.
  * `install -a grub`: exec all actions with `grub` in description.

&nbsp; 
## Main features
  * Install Openbox and dependences.
  * Install and config essential Openbox tools: Tint2, Rofi, Terminator, Thunar, volume control, gsimplecal, etc.
  * Config a basic themes and styles for Openbox, Gtk, fonts, icon pack, wallpapers, exit menu.
  * Install some user tools: Brave/Chrome browser, SublimeText, Atom, VirtualBox and Extensión Pack, sudo,nomacs image viewer, WPS Office and others.
  * Config prompt,  path, aliases and home directories permissions.
  * Config Grub for skip menu or protect by password and show messages during boot.
  * Install [**`vim`**](ttps://github.com/leomarcov/debian-openbox/tree/master/install_vim) and some plugins and themes.
  * Install [**`Numix-Paper icon theme`**](https://github.com/leomarcov/debian-openbox/tree/master/10_openbox_numix-paper-icons), a theme based on Numix and Paper icon packs.
  * Install [**`autosnap Windows for Openbox`**](https://github.com/leomarcov/debian-openbox/tree/master/10_openbox_autosnap), a script for autosnap active windows (half-maximice). 
  * Install [**`loginfetch`**](https://github.com/leomarcov/debian-openbox/blob/master/script_loginfetch/README.md), a tty login based on ufetch style and config tty lock screen with physlock.
  * Install [**`update-notification script`**](https://github.com/leomarcov/debian-openbox/tree/master/10_openbox_update-notification) for check and manage repositories updates.
  * Install [**`brightness control script`**](https://github.com/leomarcov/debian-openbox/tree/master/script_brightness-control) for increase/decrease birghtness screen.
  * Install [**`exit menu`**](https://github.com/leomarcov/debian-openbox/tree/master/10_openbox_exit-menu) based on rofi to show power and exit options.

<img align="center" width="450" src="https://user-images.githubusercontent.com/32820131/79147593-764c5f00-7dc4-11ea-9ca2-f2569260928f.png"> <img align="center" width="450" src="https://user-images.githubusercontent.com/32820131/79147594-76e4f580-7dc4-11ea-9f2c-56376bd9e6fa.png">

<img align="center" width="450" src="https://user-images.githubusercontent.com/32820131/79147600-777d8c00-7dc4-11ea-9e01-f3d072fa8961.png"> <img align="center" width="450" src="https://user-images.githubusercontent.com/32820131/79166592-cbe53380-7de5-11ea-8a62-e88f10d6b2a0.png">

&nbsp; 
## Install
  * Install Debian 10 netinstall (better don't install `Debian desktop environment`, install only `standard system utilities`).
  * Clone or download this project: `git clone https://github.com/leomarcov/debian-openbox`
  * Exec `install` script and select scripts you want to install.
  
```
$ ./install -h
Exec a set of scripts
Usage: install [-l] [-a <actions>] [-y] [-d] [-h]
   -l		Only list actions 
   -a <actions>	Filter selected actions by number range or text pattern (comma separated)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help


# Exec all actions interactively:
$ ./install

# Exec all actions and answer yes to all (no ask):
$ ./install -y

# Exec all actions and answer default to all (no ask and only exec actions with default Y):
$ ./install -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ ./install -a 5,7,10-15

# Exec only actions with grub text in description:
$ ./install -a grub

# List all actions:
$ ./install -l
 [1]   INSTALL  Install some basic packages (Y)
 [2]   OPENBOX  Install Openbox WM and essential tools and configs (Y)
 [3]   OPENBOX  Install theme Arc GTK and set as default (Y)
 [4]   OPENBOX  Install script autosnap for half-maximize windows with mouse middle click in titlebar (Y)
 [5]   OPENBOX  Install Conky and add basic sysinfo-shortcuts panel (Y)
 [6]   OPENBOX  Install script obexit with exit-power menu based on rofi (Y)
 [7]   OPENBOX  Install some popular fonts (Y)
 [8]   OPENBOX  Install nomacs image viewer (Y)
 [9]   OPENBOX  Install clear xfce4-notify theme (Y)
 [10]  OPENBOX  Install icon theme Numix-Paper and set as default icons (Y)
 [11]  OPENBOX  Install rofi launcher and config as default launcher (Y)
 [12]  OPENBOX  Install Terminator terminal and configs (Y)
 [13]  OPENBOX  Install Thunar filemanager and some configs (show toolbar and double-click for active items) (Y)
 [14]  OPENBOX  Install tint2 taskbar and config some taskbar/menu themes (Y)
 [15]  OPENBOX  Install script update-notification for check periodically APT updates (Y)
 [16]  OPENBOX  Install pnmixer and pavucontrol volume control (Y)
 [17]  OPENBOX  Install script to rotate everyday Linux solarized wallpapers pack by Andreas Linz (Y)
 [18]  OPENBOX  Install nitrogen tool, copy wallpapers pack and set default wallpaper to all users (Y)
 [19]  CONFIG   Add Debian repositories contrib and non-free (Y)
 [20]  CONFIG   Config some useful aliases (for ls, grep and ip commands) (Y)
 [21]  CONFIG   Config modified .profile file with new path (sbin for all users) and color definitions (Y)
 [22]  CONFIG   Config new bash prompt (Y)
 [23]  CONFIG   Config system for show text messages during boot time (Y)
 [24]  CONFIG   Disable some unnecessary services (Y)
 [25]  CONFIG   Config GRUB with password protection for prevent users edit entries (N)
 [26]  CONFIG   Config GRUB for skip menu (timeout=0) (N)
 [27]  CONFIG   Config users home directories permissions to 750 (for current and future users) (Y)
 [28]  CONFIG   Enable CTRL+ALT+BACKSPACE shortcut for kill X server (Y)
 [29]  CONFIG   Install sudo and add user 1000 to sudo group (Y)
 [30]  INSTALL  Install Atom text editor (N)
 [31]  INSTALL  Install Brave browser, add to repositories and set has default browser (N)
 [32]  INSTALL  Install CUPS printer system and add user 1000 to lpadmin group (N)
 [33]  INSTALL  Install Google Chrome, add to repositories and set has default browser (Y)
 [34]  INSTALL  Install Sublime Text, add repositories and set as default editor (Y)
 [35]  INSTALL  Install vim editor, and apply some configs and plugins (Y)
 [36]  INSTALL  Install VirtualBox 6.1 and Extension Pack and add to repositories  (Y)
 [37]  INSTALL  Install WPS Office Suite (Y)
 [38]  SCRIPT   Install script poweroff_last for auto-poweroff if no users logged in 20 minutes (N)
 [39]  SCRIPT   Install script to control screen brightness (Y)
 [40]  SCRIPT   Config Linux login in text mode (tty) using ufetch style and install a tty locker (physlock) (Y)
```
  
&nbsp; 
## Customize
The script can be easily customized. Each `install.sh` script placed in a subdirectory are automatillacy recognized by `install`.
  * For **remove action** simply delete the action directory.
  * For **add action** simply add new folder and place inside `install.sh` script and dependences. `install.sh` script must have this header:
  ```
  #!/bin/bash
  # ACTION: Description of the action
  # INFO: Optional additional info
  # DEFAULT: y
  
  scripts commands to do action
  
  ```

&nbsp;  
## Lincense
[GPLv3](LICENSE)

## Contact
My name is Leonardo Marco. I'm sysadmin teacher in [CIFP Carlos III](https://cifpcarlos3.es/), Cartagena, Murcia (Spain).

You can email me for suggestions, contributions, labadmin help or share your feelings: labadmin@leonardomarco.com
