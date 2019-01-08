#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

if [[ -z $1 || -z $2 ]]; then
	wifi_log "need SSID and password to add a network"
	exit 1
fi

ssid="$1"
pass="$2"

echo "$ssid:::$pass" | cat - "${wifi_list}" > "temp" && mv "temp" "${wifi_list}" && chmod 000 "${wifi_list}" && wifi_log "successfully added '$ssid'" && exit 0

wifi_log "could not add '$ssid'"
