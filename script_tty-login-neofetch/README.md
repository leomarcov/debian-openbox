# Neofetch TTY login message
TTY login message is boring. This script show cool info message at login based on neofetch info.

![image](https://user-images.githubusercontent.com/32820131/40976478-92efc988-68ce-11e8-98ec-f5313a773000.png)


## Install
```bash
# Install neofetch:
apt-get install neofetch

# Copy script and config file:
cp -v /etc/issue /etc/issue.old
[ ! -d "/etc/systemd/system/getty@.service.d/" ] && mkdir -vp "/etc/systemd/system/getty@.service.d/"
[ ! -d "/usr/share/neofetch/" ] && mkdir -vp "/usr/share/neofetch/"
cp -v ./config_tty /usr/share/neofetch/
cp -v ./neofetch-issue.sh /usr/bin/
chmod -v a+x /usr/bin/neofetch-issue.sh

# Config getty to run neofetch_issue.sh every time tty start:
echo '[Service]
ExecStartPre=-/bin/bash -c "/usr/bin/neofetch-issue.sh"' | tee "/etc/systemd/system/getty@.service.d/override.conf"

```
