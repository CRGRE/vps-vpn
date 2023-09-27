#!/usr/bin/env bash

sed -i 's/#Port 22/Port 30022/' /etc/ssh/sshd_config
systemctl restart sshd

git clone https://github.com/skeeto/endlessh
cd endlessh
dnf install gcc gcc-c++ kernel-devel -y
make
cp ./endlessh /usr/local/bin/
setcap 'cap_net_bind_service=+ep' /usr/local/bin/endlessh
dnf remove gcc gcc-c++ kernel-devel -y
endlessh --version

cat >/etc/systemd/system/endlessh.service <<EOF
[Unit]
Description=Endlessh SSH Tarpit
Documentation=man:endlessh(1)
Requires=network-online.target

[Service]
Type=simple
Restart=always
RestartSec=30sec
ExecStart=/usr/local/bin/endlessh
KillSignal=SIGTERM

# Stop trying to restart the service if it restarts too many times in a row
StartLimitInterval=5min
StartLimitBurst=4

StandardOutput=journal
StandardError=journal
StandardInput=null

PrivateTmp=true
PrivateDevices=true
ProtectSystem=full
ProtectHome=true
# InaccessiblePaths=/run /var

## If you want Endlessh to bind on ports < 1024
## 1) run: 
##     setcap 'cap_net_bind_service=+ep' /usr/local/bin/endlessh
## 2) uncomment following line
AmbientCapabilities=CAP_NET_BIND_SERVICE
## 3) comment following line
# PrivateUsers=true

NoNewPrivileges=true
ConfigurationDirectory=endlessh
ProtectKernelTunables=true
ProtectKernelModules=true
ProtectControlGroups=true
MemoryDenyWriteExecute=true

[Install]
WantedBy=multi-user.target

EOF

mkdir /etc/endlessh
echo 'Port 22' > /etc/endlessh/config
systemctl daemon-reload
systemctl --now enable endlessh
systemctl status endlessh


dnf config-manager --set-enabled crb
dnf install epel-release epel-next-release
dnf install fail2ban -y
systemctl enable --now fail2ban