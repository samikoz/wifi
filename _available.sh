#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

wifi_log "available networks:"

while read -r ssid; do
	wifi_log "\t$ssid"
done <<< $(print_available)