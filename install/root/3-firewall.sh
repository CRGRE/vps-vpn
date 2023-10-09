#!/usr/bin/env bash

firewall-cmd --state

firewall-cmd --permanent --new-zone=vpnserver

firewall-cmd --permanent --zone=vpnserver --set-target=DROP

firewall-cmd --permanent --zone=vpnserver --add-port=22/tcp
firewall-cmd --permanent --zone=vpnserver --add-port=80/tcp
firewall-cmd --permanent --zone=vpnserver --add-port=443/tcp
firewall-cmd --permanent --zone=vpnserver --add-port=443/udp
firewall-cmd --permanent --zone=vpnserver --add-port=65432/tcp

firewall-cmd --permanent --zone=vpnserver --add-masquerade
# firewall-cmd --permanent --zone=vpnserver --add-forward-port=port=22:proto=tcp:toport=65022
firewall-cmd --permanent --zone=vpnserver --add-forward-port=port=80:proto=tcp:toport=65080
firewall-cmd --permanent --zone=vpnserver --add-forward-port=port=443:proto=tcp:toport=65443
firewall-cmd --permanent --zone=vpnserver --add-forward-port=port=443:proto=udp:toport=65443

firewall-cmd --reload
firewall-cmd --set-default-zone=vpnserver

firewall-cmd --info-zone=vpnserver

# firewall-cmd --permanent --delete-zone=vpnserver