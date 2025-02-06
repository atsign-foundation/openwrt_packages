#!/bin/sh
. /lib/functions.sh
enroll_atsign() {
    local section="$1"

    config_get atsign "$section" "atsign"
    if [ -z "$atsign" ]; then
        echo "sshnpd: atsign must be configured in /etc/config/sshnpd"
        return 1
    fi

    config_get device "$section" "device"
    if [ -z "$device" ]; then
        echo "sshnpd: device must be configured in /etc/config/sshnpd"
        return 1
    fi

    config_get otp "$section" "otp"
    if [ -z "$otp" ]; then
        echo "sshnpd: otp must be configured in /etc/config/sshnpd"
        return 1
    fi

    config_get user             "$section" user
    if [ -z "$user" ]; then
        user='root'
    fi

    config_get home             "$section" home
    if [ -z "$home" ]; then
        if [ "$user" = "root" ]; then
            home='/root'
        else
            home="/home/${user}"
        fi
    fi

    if [ -f "${home}/.atsign/keys/${atsign}_key.atKeys" ]; then
        echo "sshnpd: atsign keys file already present, exiting enrollment"
        return 1
    fi

    at_activate enroll -a ${atsign} -s ${otp} -p noports -k ${home}/.atsign/keys/${atsign}_key.atKeys -d ${device} -n "sshnp:rw,sshrvd:rw"

}
config_load sshnpd
config_foreach enroll_atsign sshnpd
