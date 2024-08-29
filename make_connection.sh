#!/bin/bash

# Get the Ubuntu version
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2)

MAC_ADDRESS_FILE="conf/.addresses"  # Change this to the path of your file
if [ -f "$MAC_ADDRESS_FILE" ]; then
    GO_ADDRESS=$(head -n 1 "$MAC_ADDRESS_FILE")
else
    echo "MAC address file not found!"
    exit 1
fi

if [ "$UBUNTU_VERSION" == "20.04" ]; then

    sudo iw dev wlan0 interface add p2p0 type __p2pcl
    sleep 1
    sudo iw dev p2p0 set type __p2pcl
    sudo ip link set p2p0 up

    sudo wpa_cli -ip2p0 p2p_find
    sleep 5
    sudo wpa_cli -ip2p0 p2p_connect $GO_ADDRESS pbc join
    sleep 5
    sudo wpa_cli -ip2p0 wps_pbc

elif [ "$UBUNTU_VERSION" == "22.04" ]; then\

    sudo wpa_cli -iwlan0 p2p_find
    sleep 3
    sudo wpa_cli -iwlan0 p2p_connect $GO_ADDRESS pbc join

else
    echo "Unsupported Ubuntu version: $UBUNTU_VERSION"
    exit 1
fi

