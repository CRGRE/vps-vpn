passwd
dnf upgrade -y
reboot

dnf install mc nano git nmap-ncat -y

curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | sudo bash
dnf install speedtest -y

dnf install fuse-overlayfs slirp4netns -y
fuse-overlayfs --version
slirp4netns --version

dnf -y install podman -y
grep cgroup /proc/filesystems
grep runtime /usr/share/containers/containers.conf

useradd -d /opt/vpn -G systemd-journal -U -s /bin/bash vpn
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 vpn


firewall-cmd --state
firewall-cmd --new-zone=vpnserver --permanent
firewall-cmd --zone=vpnserver --set-target=DROP --permanent
firewall-cmd --zone=vpnserver --add-masquerade --permanent
firewall-cmd --zone=vpnserver --add-service=http --permanent
firewall-cmd --zone=vpnserver --add-service=https --permanent
firewall-cmd --zone=vpnserver --add-service=ssh --permanent
firewall-cmd --zone=vpnserver --add-port=30022/tcp --permanent
firewall-cmd --zone=vpnserver --add-forward-port=port=80:proto=tcp:toport=30080 --permanent
firewall-cmd --zone=vpnserver --add-forward-port=port=443:proto=tcp:toport=30443 --permanent
firewall-cmd --set-default-zone=vpnserver
firewall-cmd --reload
firewall-cmd --list-all-zones


sed -i 's/#Port 22/Port 30022/' /etc/ssh/sshd_config
systemctl restart sshd

dnf config-manager --set-enabled crb
dnf install epel-release epel-next-release
dnf install fail2ban -y
systemctl enable --now fail2ban

