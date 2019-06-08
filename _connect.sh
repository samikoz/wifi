#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"


# load the list of saved networks

declare -i saved_index=0

while IFS=":::" read -r saved_ssid _; do
	saved[${saved_index}]="$saved_ssid"
	saved_index+=1
done < "${wifi_list}"


# load the list of available networks

declare -i available_index=0

while read -r network_line; do
	available[${available_index}]="${network_line#SSID: }"
	available_index+=1
done <<< $(iw dev "$wireless_interface" scan | grep "SSID:")


# find the first saved among the available

for (( i=0 ; $i < $saved_index ; i+=1 )); do
	for (( j=0 ; $j < $available_index ; j+=1 )); do
		if [[ ${saved[$i]} = ${available[$j]} ]]; then
			ssid_connectee="${saved[$i]}"
			break 2
		fi
	done
done

if [[ -z $ssid_connectee ]]; then
	wifi_log "no saved network available"
	exit 1
fi


# obtain password for given SSID

pass_connectee="$(cat "${wifi_list}" | grep "$ssid_connectee" | tr -s ":::" "\n" | sed -n 2p)"

wifi_log "connecting to $ssid_connectee"
wpa_supplicant -i "$wireless_interface" -c <(wpa_passphrase "$ssid_connectee" "$pass_connectee") &
