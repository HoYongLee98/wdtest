#!/bin/bash

# Get the Ubuntu version
UBUNTU_VERSION=$(grep 'VERSION_ID' /etc/os-release | cut -d '"' -f 2)

if [ "$UBUNTU_VERSION" == "20.04" ]; then

    sudo dhclient p2p0
    sudo ip route replace default via 192.168.49.1 dev p2p0 metric 200
    sudo ip route del default via 192.168.49.1 dev p2p0

elif [ "$UBUNTU_VERSION" == "22.04" ]; then\

    sudo dhclient wlan0
    sudo ip route replace default via 192.168.49.1 dev wlan0 metric 200
    sudo ip route del default via 192.168.49.1 dev wlan0

else
    echo "Unsupported Ubuntu version: $UBUNTU_VERSION"
    exit 1
fi
