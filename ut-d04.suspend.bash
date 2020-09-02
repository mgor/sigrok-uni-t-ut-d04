#!/usr/bin/env bash

main() {
    local port="${1##*/}"
    declare -A settings
    settings[power/control]="auto"
    settings[power/autosuspend]="0"

    [[ -z "${port}" ]] && return 1

    local device="/sys/bus/usb/devices/${port}"

    [[ -e "${device}/manufacturer" ]] || return 1

    for setting in "${!settings[@]}"; do
        local path="${device}/${setting}"
        local value="${settings[${setting}]}"
        echo "${value}" > "${path}"
    done

    return 0
}

main "$@"
exit $?

