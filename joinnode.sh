#!/bin/bash
apt update -y
apt upgrade -y

# Download và cài rke2 agent
curl -sfL https://get.rke2.io | INSTALL_RKE2_TYPE="agent" sh -
systemctl enable rke2-agent.service

# Cài đặt file kết nối
mkdir -p /etc/rancher/rke2/
rm -rf /etc/rancher/rke2/config.yaml
touch /etc/rancher/rke2/config.yaml

# Nhập giá trị cho biến server
echo "Nhập địa chỉ server: (example: https://82.180.162.37:9345)"
read server

# Nhập giá trị cho biến token
echo "Nhập token: (dùng lệnh: cat /var/lib/rancher/rke2/server/node-token ở node master)"
read token


# Ghi nội dung vào file config.yaml
echo "server: $server" >> /etc/rancher/rke2/config.yaml
echo "token: $token" >> /etc/rancher/rke2/config.yaml
echo "Đã ghi thông tin vào /etc/rancher/rke2/config.yaml"

# Start agent
echo "Starting agent..."
systemctl start rke2-agent.service

# Hiển thị log
journalctl -u rke2-agent -f