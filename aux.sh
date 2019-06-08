#!/bin/bash

wireless_interface="wlo1"

wifi_list="/home/sami/dev/bash/wifi/wifi.list"

wifi_log() {
	printf "wifi: $1\n"
}

print_available() {
    while read -r network_line; do
	    printf "${network_line#SSID: }\n"
    done <<< $(iw dev "$wireless_interface" scan | grep "SSID:")
}