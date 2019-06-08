#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

if [[ -z $1 ]]; then
	wifi_log "need to give network's SSID"
	exit 1
fi

given_ssid="$1"

while read -r available_ssid; do
	if [[ ${available_ssid} == ${given_ssid} ]]; then
	    given_ssid_available_flag=0
	    break
    fi
done <<< $(print_available)

if [[ -z ${given_ssid_available_flag} ]]; then
    wifi_log "the network '${given_ssid}' is not detected. continue?"

    read -n1 cont
    printf "\n"
    if [[ ! ${cont} == 'Y' || ! ${cont} == 'y' ]]; then
        exit 1
    fi
fi

wifi_log "provide password for '${given_ssid}'"
read -s given_pass

echo "${given_ssid}:::${given_pass}" | cat - "${wifi_list}" > "temp" && mv "temp" "${wifi_list}" && chmod 000 "${wifi_list}" && wifi_log "successfully added '${given_ssid}'" && exit 0

wifi_log "could not add '${given_ssid}'"
