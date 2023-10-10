#!/usr/bin/env bash

PODMAN_USER="vpn"
POD_YAML_PATH="$(eval realpath ~$PODMAN_USER/vps-vpn/vpnserver-pod.yaml)"
POD_YAML_PATH_ESCAPED="$(systemd-escape $POD_YAML_PATH)"

if [ "$USER" = "$PODMAN_USER" ]
  then
    systemctl --user stop podman-kube@$POD_YAML_PATH_ESCAPED.service
  else
    sudo -u $PODMAN_USER XDG_RUNTIME_DIR="/run/user/$(id -u $PODMAN_USER)" systemctl --user stop podman-kube@$POD_YAML_PATH_ESCAPED.service
fi

# change permissions for certs
if [ "$USER" = "root" ]
  then
    setfacl --recursive --modify u:$PODMAN_USER:rX,d:u:$PODMAN_USER:rX /etc/letsencrypt/{live,archive}
fi