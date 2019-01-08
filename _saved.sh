#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

wifi_log "remembered networks:"

while IFS=":::" read -r ssid _; do
	wifi_log "\t$ssid"
done < "${wifi_list}"
