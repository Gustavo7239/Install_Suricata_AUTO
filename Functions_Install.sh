#!/bin/bash

install_and_update(){
    if check_suricata_installed; then
        wait
        choose_main_options
    else
        sudo apt update -y
        sudo add-apt-repository ppa:oisf/suricata-stable -y
        sudo apt upgrade -y
        install_suricata
    fi
}

install_suricata(){
    sudo apt install suricata jq -y
}

create_our_directory_rules(){
    sudo touch "$suricata_rules_file"
    sudo sh -c 'echo "#-----------------------[MoTechno Rules]-----------------------" >> "$0"' "$suricata_rules_file"
}