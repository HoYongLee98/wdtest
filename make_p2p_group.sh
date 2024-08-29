#!/bin/bash

sudo killall wpa_supplicant
sleep 1
sudo wpa_supplicant -Dnl80211 -iwlan0 -cconf/go_wpa_supplicant.conf -B
sleep 1

sudo wpa_cli -iwlan0 p2p_group_add
sleep 1
sudo ip addr add 192.168.49.1/24 dev wlan0
sudo ip link set wlan0 up

# Check if the dhcpd.leases file exists, if not, create it and set permissions
if [ ! -f /var/lib/dhcp/dhcpd.leases ]; then
    sudo touch /var/lib/dhcp/dhcpd.leases
    sudo chown root:root /var/lib/dhcp/dhcpd.leases
    sudo chmod 644 /var/lib/dhcp/dhcpd.leases
fi

sudo dhcpd -cf conf/custom_dhcpd.conf wlan0