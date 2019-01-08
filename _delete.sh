#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

[[ -z $1 ]] && wifi_log "need SSID to delete a network" && exit 1

ssid="$1"

sed "/^$ssid:::/ d" "$wifi_list" > "temp"

if [[ -z $(diff "temp" "$wifi_list") ]]; then 
	wifi_log "didn't find '$ssid' among saved ones"
	exit 1
else
	mv "temp" "$wifi_list" && wifi_log "successfully deleted '$ssid'"
fi
