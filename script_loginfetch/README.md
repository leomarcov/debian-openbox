# TTY login fetch
TTY login message is boring. This script show cool info message at login based on ufetch info.

![image](https://user-images.githubusercontent.com/32820131/80919528-ae631400-8d6a-11ea-9898-d51c80ce1250.png | width=100)
![image](https://user-images.githubusercontent.com/32820131/80919527-adca7d80-8d6a-11ea-9e7b-7a7519453d6c.png)

## Install
Exec `install.sh script` to install script, dependences and apply configs. Scripts install and config [Physlock](https://github.com/muennich/physlock), a tty locker called when come back of suspend mode.

&nbsp; 
### Manual install
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

# Recomended: install physlock
```
