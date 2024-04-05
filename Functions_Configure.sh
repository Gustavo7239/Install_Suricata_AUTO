#!/bin/bash

modify_suricata_config() {
    local ip_address=$(ip route get 8.8.8.8 | head -1 | awk '{print $7}')
    local interface_name=$(ip -o -4 route show to default | awk '{print $5}')
    local config_file="/etc/suricata/suricata.yaml"

    if [[ -f "$config_file" ]]; then
        sudo sed -i "s/HOME_NET: \"\[192.168.0.0\/16,10.0.0.0\/8,172.16.0.0\/12\]\"/HOME_NET: \"[$ip_address\/24]\"/" "$config_file"
        sudo sed -i "s/interface: eth0/interface: $interface_name/" "$config_file"
        echo "Suricata configuration file updated successfully."
    else
        echo "Suricata configuration file not found."
    fi
}