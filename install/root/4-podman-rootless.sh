#!/usr/bin/env bash

PODMAN_USER="vpn"

getenforce
dnf install fuse-overlayfs slirp4netns -y
fuse-overlayfs --version
slirp4netns --version

dnf -y install podman -y
podman version
grep cgroup /proc/filesystems # cgroup2
grep -E '^runtime' /usr/share/containers/containers.conf #crun

useradd -d /opt/$PODMAN_USER -G systemd-journal -U -s /bin/bash $PODMAN_USER
passwd -x -1 $PODMAN_USER
usermod --add-subuids 100000-165535 --add-subgids 100000-165535 $PODMAN_USER
loginctl enable-linger $PODMAN_USER
cp -R .ssh /opt/$PODMAN_USER
sudo chown -R $PODMAN_USER: /opt/$PODMAN_USER