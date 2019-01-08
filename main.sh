#!/bin/bash

source "/home/sami/dev/bash/wifi/aux.sh"

available_actions=("connect" "disconnect" "add" "delete" "saved" "available" "init")

action="$1"
remaining_params=("${@:2}")

# single-quote each of the remaining_params
quote_mark="'"
for (( i=0 ; $i < ${#remaining_params[@]} ; i+=1 )); do
	remaining_params[$i]="${quote_mark}${remaining_params[$i]}${quote_mark}"
done


for available in "${available_actions[@]}"; do
	if [[ $action = $available ]]; then
		sudo bash -c "/home/sami/dev/bash/wifi/_${action}.sh ${remaining_params[*]}"
		exit $?
	fi
done

[[ -z $action ]] || wifi_log "unrecognised option '$action'"
wifi_log "available options are: ${available_actions[*]}"
