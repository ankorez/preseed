# post-install.sh
#!/bin/bash

# Rename Computer
MY_HOSTNAME="ML-$(dmidecode -s system-serial-number | cut -d'-' -f2- | tr -d ' ')"
echo $MY_HOSTNAME > /etc/hostname
echo $MY_HOSTNAME 

# Fix DNS
systemctl disable systemd-resolved.service
systemctl stop systemd-resolved
sed -i '/plugins=ifupdown,keyfile/a dns=default' /etc/NetworkManager/NetworkManager.conf
rm /etc/resolv.conf
systemctl restart network-manager
