#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

wifi_log "putting down the network interface"
ip link set "${wireless_interface}" down
wifi_log "killing wpa_supplicant processes"
sudo killall wpa_supplicant
wifi_log "killing dhcpcd processes"
sudo killall dhcpcd

