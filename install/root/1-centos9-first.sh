#!/usr/bin/env bash

passwd
dnf upgrade -y
# reboot

dnf install mc nano git nmap-ncat curl sudo bind-utils sqlite -y

curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.rpm.sh | bash
dnf install speedtest -y

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version

openssl version

# https://www.procustodibus.com/blog/2022/10/wireguard-in-podman/
# lsmod | grep wireguard
# cat >/etc/modules-load.d/wireguard-podman.conf <<EOF
# wireguard
# iptable_nat
# xt_MASQUERADE
# xt_nat
# ip_tables
# iptable_filter
# EOF
# systemctl restart systemd-modules-load