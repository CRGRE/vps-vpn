#!/usr/bin/env bash

getenforce
dnf install fuse-overlayfs slirp4netns -y
fuse-overlayfs --version
slirp4netns --version

dnf -y install podman -y
podman version
grep cgroup /proc/filesystems # cgroup2
grep -E '^runtime' /usr/share/containers/containers.conf #crun

useradd -d /opt/vpn -G systemd-journal -U -s /bin/bash vpn
passwd -x -1 vpn
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 vpn
loginctl enable-linger vpn
cp -R .ssh /opt/vpn
sudo chown -R vpn: /opt/vpn