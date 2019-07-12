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
    wireless_line="${wireless_line#*<}"
    wireless_line="${wireless_line%%>*}"

    IFS=,
    for info in ${wireless_line}; do
        if [[ ${info} == DOWN ]]; then
            printf "0\n"
            break
        elif [[ ${info} == UP ]]; then
            printf "1\n"
            break
        fi
    done
    unset IFS
}
