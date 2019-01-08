#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

wifi_log "setting up wireless interface"
ip link set "$wireless_interface" up

wifi_log "starting dhcpcd"
dhcpcd
