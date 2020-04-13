# Openbox install script collection for Debian
<img align="left"  src="https://user-images.githubusercontent.com/32820131/77852132-2de64c00-71dd-11ea-8a66-e4cd3de916f8.png" width="90"> Openbox is a beautiful and lightweight window manager, but tediuos to install and config a full usable environment. This script collection automatize **Openbox** installation and essentials tools and apply configurations, styles and themes. Althoughs is a collection of my particular configs may be interesting for someone. You can install all scripts from bare Debian netinstall to config full environment or exec only some scripts you are interested. Each folder has a particular action script for install pacakges, add scripts, apply configs or install some themes or styles.

The main script `install` can exec all scripts or only a select list:
  * `install -l`: list all scripts.
  * `install`: exec all scripts interactively asking for each one if install or not.
  * `install -d`: install all default scripts.
  * `install -a 5,8-12`: install selected scripts.
  * `install -a bash`: install all actions with text bash in description

&nbsp; 
## Main features
  * Install Openbox and dependences.
  * Install and config essential Openbox tools: Tint2, Rofi, Terminator, Thunar, volume control, gsimplecal, etc.
  * Config a basic themes and styles for Openbox, Gtk, fonts, icon pack, wallpapers, exit menu.
  * Install some user tools: Brave/Chrome browser, SublimeText, Atom, VirtualBox and Extensión Pack, sudo,nomacs image viewer, WPS Office and others.
  * Config prompt,  path, aliases and home directories permissions.
  * Config Grub for skip menu or protect by password and show messages during boot.
  * Install [**`Numix-Paper icon theme`**](https://github.com/leomarcov/debian-openbox/tree/master/theme_numix-paper-icon), a theme based on Numix and Paper icon packs.
  * Install [**`autosnap Windows for Openbox`**](https://github.com/leomarcov/debian-openbox/tree/master/script_autosnap), a script for autosnap active windows (half-maximice). 
  * Install [**`tty login neofetch`**](https://github.com/leomarcov/debian-openbox/tree/master/script_tty-login-neofetch), a tty login based on neofetch info and config tty lock screen with physlock.
  * Install [**`update-notification script`**](https://github.com/leomarcov/debian-openbox/tree/master/script_update-notification-tint) for check and manage repositories updates.
  * Install [**`brightness control script`**](https://github.com/leomarcov/debian-openbox/tree/master/script_brightness-control) for increase/decrease birghtness screen.
  * Install [**`exit menu`**](https://github.com/leomarcov/debian-openbox/tree/master/script_exitmenu) based on rofi to show power and exit options.

<img align="center" src="https://user-images.githubusercontent.com/32820131/79074955-ce656180-7cef-11ea-939e-bcf2175a7a56.png">


&nbsp; 
## Install
  * Install Debian 10 netinstall, better don't install `Debian desktop environment`.
  * Clone or download this project: `git clone https://github.com/leomarcov/debian-openbox`
  * Exec `install` script and select scripts you want to install.
  
```
$ ./install -h
Exec scripts actions
Usage: install [-l] [-a <actions>] [-y] [-d] [-h]
   -l		Only list actions 
   -a <actions>	Only do selected actions by number range (e.g: -a 5,6,10-15)
   -a <pattern>	Only do selected actions by text pattern (e.g: -a terminator)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help



# Exec all actions interactively:
$ ./install

# Exec all actions and answer yes to all:
$ ./install -y

# Exec all actions and answer default to all:
$ ./install -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ ./install -a 5,7,10-15


# List all actions:
$ ./install -l
[1] Install Openbox and essential tools and configs (y)
[2] Install Atom text editor (n)
[3] Install some basic packages (y)
[4] Install Brave browser, add to repositories and set has default browser (y)
[5] Install Conky and add basic sysinfo-shortcuts panel (y)
[6] Install CUPS printer system and add user 1000 to lpadmin group (n)
[7] Install Google Chrome, add to repositories and set has default browser (y)
[8] Install nomacs image viewer (y)
[9] Install rofi and config as default launcher (y)
[10] Install Sublime Text, add repositories and set as default editor  (y)
[11] Install sudo and add user 1000 to sudo group (y)
[12] Install Termiantor terminal and config theme (y)
[13] Install Thunar filemanager and configs (show toolbar and double-click for active items) (y)
[14] Install tint2 taskbars and taskbar/menu themes (y)
[15] Install VirtualBox 6.1 and Extension Pack and add to repositories  (y)
[16] Install mixer and volume control (y)
[17] Install WPS Office Suite (y)
[18] Add Debian repositories contrib and non-free (y)
[19] Config useful aliases (y)
[20] Config modified .profile file with new path (sbin for all users) and color definitions (y)
[21] Config new bash prompt (y)
[22] Config system for show text messages during boot (y)
[23] Config to disable some unnecessary services (no start in boot time) (y)
[24] Config GRUB with password protection for prevent users edit entries (n)
[25] Config GRUB for skip menu (timeout=0) (n)
[26] Config all users home directories permissions to 750  (y)
[27] Config CTRL+ALT+BACKSPACE shortcut for kill X server (y)
[28] Config vim with custom configs (y)
[29] Install script poweroff_last for automatize shutdown if no users logged in 20 minutes (n)
[30] Install script autosnap for half-maximize windows with mouse middle click in titlebar (y)
[31] Install script for inc/dec screen brightness (used in taskbar for inc/dec brightness with mouse wheel) (y)
[32] Install script obexit with exit-power menu based on rofi (y)
[33] Config login in text tty mode instead of graphical desktop manager (y)
[34] Install script update-notification for check periodically APT updates and show in tint2 bar executor (y)
[35] Install script to rotate everyday Linux solarized wallpapers pack by Andreas Linz (y)
[36] Install theme Arc GTK and set as default (y)
[37] Install some popular fonts (y)
[38] Install clear xfce4-notify theme (y)
[39] Install icon theme Numix-Paper and set as default (y)
[40] Install nitrogen tool, copy wallpapers pack and set default wallpaper to all users (y)

```
  
&nbsp; 
## Customize
The script can be easily customized. Each `install.sh` script placed in a subdirectory are automatillacy recognized by `install`.
  * For remove action simply delete the action directory.
  * For add action simply add new folder and place the install script `install.sh` and dependences. The script must have this header:
  ```
  #!/bin/bash
  # ACTION: Description of the action
  # INFO: Optional aditional info
  # DEFAULT: y
  
  scripts commands
  
  ```

&nbsp;  
## Lincense
[GPLv3](LICENSE)

## Contact
My name is Leonardo Marco. I'm sysadmin teacher in [CIFP Carlos III](https://cifpcarlos3.es/), Cartagena, Murcia (Spain).

You can email me for suggestions, contributions, labadmin help or share your feelings: labadmin@leonardomarco.com
