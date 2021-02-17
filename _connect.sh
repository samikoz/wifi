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
done <<< $(iw dev "$wireless_interface" scan | grep "SSID:" | sort -u)


# find those that are recognised_ssids

declare -i recognised_ssids_index=0
for (( i=0 ; $i < $saved_index ; i+=1 )); do
	for (( j=0 ; $j < $available_index ; j+=1 )); do
		if [[ ${saved[$i]} = ${available[$j]} ]]; then
			recognised_ssids[${recognised_ssids_index}]="${saved[$i]}"
			recognised_ssids_index+=1
		fi
	done
done

if [[ ${#recognised_ssids[@]} -eq 0 ]]; then
	wifi_log "no saved network available"
	exit 1
elif [[ ${#recognised_ssids[@]} -eq 1 ]]; then
  	connectee_ssid="${recognised_ssids[0]}"
else
  	wifi_log "recognised networks:"
  	for (( i=0; $i < ${recognised_ssids_index}; i+=1 )); do
    		printf "\t${i}: ${recognised_ssids[$i]}\n"
	done
  read -p "which to connect? " index
  connectee_ssid="${recognised_ssids[index]}"
  if [[ -z ${connectee_ssid} ]]; then
      wifi_log "need to provide correct index"
      exit 1
  fi
fi


# obtain password for given SSID

connectee_pass="$(cat "${wifi_list}" | grep "${connectee_ssid}" | tr -s ":::" "\n" | sed -n 2p)"

wifi_log "connecting to ${connectee_ssid}"
wpa_supplicant -i "$wireless_interface" -c <(wpa_passphrase "${connectee_ssid}" "${connectee_pass}") &
