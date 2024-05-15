#!/bin/bash
apt update
apt upgrade

# Thêm nội dung vào file /etc/multipath.conf
echo "blacklist {" >> /etc/multipath.conf
echo "    devnode \"^sd[a-z0-9]+\"" >> /etc/multipath.conf
echo "}" >> /etc/multipath.conf

echo "Đã thêm nội dung vào /etc/multipath.conf"

# Tắt firewall
ufw disable
systemctl stop ufw
systemctl disable ufw
echo "Đã tắt firewall"

# Install nfs common
apt install nfs-common -y