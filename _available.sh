#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

wifi_log "available networks:"

while read -r network_line; do
	wifi_log "\t${network_line#SSID: }"
done <<< $(iw dev wlp3s0 scan | grep "SSID:")
