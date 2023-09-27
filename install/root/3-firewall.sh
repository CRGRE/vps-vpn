#!/usr/bin/env bash

firewall-cmd --state

firewall-cmd --permanent --new-zone=vpnserver

firewall-cmd --permanent --zone=vpnserver --set-target=DROP

firewall-cmd --permanent --zone=vpnserver --add-service=http
firewall-cmd --permanent --zone=vpnserver --add-service=https
firewall-cmd --permanent --zone=vpnserver --add-service=ssh
firewall-cmd --permanent --zone=vpnserver --add-port=30022/tcp
firewall-cmd --permanent --zone=vpnserver --add-port=61000-61099/tcp
firewall-cmd --permanent --zone=vpnserver --add-port=61000-61099/udp

firewall-cmd --permanent --zone=vpnserver --add-masquerade
firewall-cmd --permanent --zone=vpnserver --add-forward-port=port=80:proto=tcp:toport=30080
firewall-cmd --permanent --zone=vpnserver --add-forward-port=port=443:proto=tcp:toport=30443

firewall-cmd --reload
firewall-cmd --set-default-zone=vpnserver

firewall-cmd --info-zone=vpnserver