#!/bin/bash

wireless_interface="wlo1"

wifi_list="/home/sami/dev/bash/wifi/wifi.list"

wifi_log() {
	printf "wifi: $1\n"
}

print_available() {
    while read -r network_line; do
	    printf "${network_line#SSID: }\n"
    done <<< $(iw dev "${wireless_interface}" scan | grep "SSID:")
}

is_network_interface_down() {
    wireless_line="$(ip link | grep ${wireless_interface})"
    wireless_line="${wireless_line#*state }"
    wireless_state="${wireless_line%% *}"

    if [[ ${wireless_state} == "DOWN" ]]; then
        printf "0\n"
    else printf "1\n"
    fi
}
