# debian-openbox
<img align="left"  src="https://user-images.githubusercontent.com/32820131/77852132-2de64c00-71dd-11ea-8a66-e4cd3de916f8.png" width="90"> A collection of scripts to automatize **Openbox** installation and essentials tools and apply configurations, styles and themes to get a beatuful and lightweight environment. 
Script must be exec over **Debian 10** installation (best on netinstall without desktop environment installed). 

&nbsp; 
## Main features
  * Install Openbox and dependences.
  * Install and config essential Openbox tools: Tint2, Rofi, Terminator, Thunar, volume control, etc.
  * Config a basic themes and styles for Openbox, Gtk, fonts, icon pack, wallpapers.
  * Install some user tools: Brave/Chrome browser, SublimeText, Atom, VirtualBox and Extensión Pack,
  * Config prompt and aliases.
  * Install [**`Numix-Paper icon theme`**](https://github.com/leomarcov/debian-openbox/tree/master/theme_numix-paper-icon), a theme based on Numix and Paper icon packs.
  


&nbsp; 
## Install
  * Install Debian 10 netinstall without desktop environment.
  * Clone or download project.
  * Exec `install` script and select scripts you want to install.
  
```
$ ./install -h
Exec scripts actions
Usage: install [-l] [-a <actions>] [-y] [-d] [-h]
   -l		Only list actions 
   -a <actions>	Only do selected actions (e.g: -a 5,6,10-15)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help


# List all actions:
$ ./install -l
[1] Config useful aliases (y)
[2] Config new bash prompt (y)
[3] Config system for show messages during boot (y)
[4] Config CTRL+ALT+BACKSPACE shortcut for kill X server (y)
[5] Config vim with custom configs (y)
[6] Install Atom text editor (n)
[7] Install Brave browser, add to repositories and set has default browser (y)
[8] Install Google Chrome, add to repositories and set has default browser (n)
[9] Install Openbox and tools for full environment (y)
[10] Install script ps_mem.py (y)
[11] Install rofi and config as default (y)
[12] Install some useful packages (y)
[13] Install Sublime Text, add repositories and set as default editor  (y)
[14] Install sudo and add user 1000 to sudo (y)
[15] Install Termiantor terminal and config theme (y)
[16] Install and config Thunar (show toolbar and double-click for active items) (y)
[17] Install tint2 bar and themes (y)
[18] Install mixer and volume control (y)
[19] Install script autosnap for autosnap windows with double click in titlebar (y)
[20] Config text mode login using tty instead of lightdm display manager (y)
[21] Install theme Arc GTK and set as default (y)
[22] Install pack of popular fonts (y)
[23] Install icon theme Numix-Paper and set as default (y)
[24] Install nitrogen and copy wallpapers pack and set Aptenodytes wallpaper as default (y)



# Exec all actions interactively:
$ sudo ./install

# Exec all actions and answer yes to all:
$ sudo ./install -y

# Exec all actions and answer default to all:
$ sudo ./install -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ sudo ./install -a 5,7,10-15
```
  
&nbsp; 
## Customize
The script can be easily customized. Each action script `.sh` placed in a subdirectory are automatillacy recognized by `install`.
  * For remove action simply delete the action directory.
  * For add action simply add new folder and place the install script `.sh` and dependences. The script must have this header:
  ```
  #!/bin/bash
  # ACTION: Description of the action
  # INFO: Optional aditional info
  # DEFAULT: y
  
  commands to do
  
  ```

&nbsp;  
## Lincense
[GPLv3](LICENSE)

## Contact
My name is Leonardo Marco. I'm sysadmin teacher in [CIFP Carlos III](https://cifpcarlos3.es/), Cartagena, Murcia (Spain).

You can email me for suggestions, contributions, labadmin help or share your feelings: labadmin@leonardomarco.com
