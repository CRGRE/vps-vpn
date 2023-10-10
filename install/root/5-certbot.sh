#!/usr/bin/env bash

dnf install epel-release -y
dnf install certbot -y
certbot --version

certbot certonly -d petchup.ddns.net --standalone \
    --register-unsafely-without-email \
    --agree-tos \
    --noninteractive \
    --http-01-port 65080 \
    --server https://acme-staging-v02.api.letsencrypt.org/directory

PODMAN_USER="vpn"
if id "$PODMAN_USER" >/dev/null 2>&1
    then
        CERTBOT_HOOKS_PATH="$(eval realpath ~$PODMAN_USER/vps-vpn/certbot)"
        certbot renew --pre-hook $CERTBOT_HOOKS_PATH/pre-hook.sh --post-hook $CERTBOT_HOOKS_PATH/post-hook.sh
fi