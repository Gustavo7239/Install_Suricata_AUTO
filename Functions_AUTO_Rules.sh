#!/bin/bash

add_new_rules() {
    while true; do
        action_name=""
        choose_action
        protocol_name=""
        choose_protocol
        message_text=""
        enter_message
        content_name=""
        enter_content_name
        sid_calculated=$(obtain_last_sid)
        rev_count="1"
        final_file="$suricata_rules_file"

        create_final_rule

        final_steps_rule_creation

    done
}

choose_action() {
    true_action=1
    while [ "$true_action" -eq 1 ]; do
        clear
        state_rule
        action_rules_menu
        read -p "INTRODUCE A NUMBER: " number_action
        
        if [ "$number_action" -eq 0 ]; then
            choose_main_options
            break
            
        elif [ "$number_action" -eq 1 ]; then
            action_name="pass"
            true_action=0
            break
        elif [ "$number_action" -eq 2 ]; then
            action_name="drop"
            true_action=0
            break
        elif [ "$number_action" -eq 3 ]; then
            action_name="reject"
            true_action=0
            break
        elif [ "$number_action" -eq 4 ]; then
            action_name="alert"
            true_action=0
            break
        else
            echo "[ERROR]: Number failed."
            wait
        fi
    done
}


choose_protocol() {
    true_protocol=1
    while [ "$true_protocol" -eq 1 ]; do
        clear
        state_rule
        protocol_rules_menu
        read -p "INTRODUCE A NUMBER: " number_protocol

        if [ "$number_protocol" -eq 0 ]; then
            echo "AUTO-Creator Rules Canceled."
            break

        elif [ "$number_protocol" -eq 1 ]; then
            protocol_name="tcp"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 2 ]; then
            protocol_name="udp"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 3 ]; then
            protocol_name="icmp"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 4 ]; then
            protocol_name="http"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 5 ]; then
            protocol_name="ftp"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 6 ]; then
            protocol_name="smtp"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 7 ]; then
            protocol_name="dns"
            true_protocol=0
            break
        elif [ "$number_protocol" -eq 8 ]; then
            protocol_name="tls"
            true_protocol=0
            break
        else
            echo "[ERROR]: Number failed."
            wait
        fi
    done
}

enter_message() {
    clear
    #echo -e "| $(color 31 ${action_name}) | $(color 31 ${protocol_name}) | "
    state_rule
    echo "Introduce a message for your new rule:"
    read -p "> " message_text
    wait
}

enter_content_name() {
    clear
    #echo -e "| $(color 31 ${action_name}) | $(color 31 ${protocol_name}) | $(color 31 ${message_text}) |"
    state_rule
    echo "Introduce domain name to block:"
    read -p "> " content_name
    wait
}

obtain_last_sid() {
    local file_path="$suricata_rules_file"
    local last_sid=""

    # Obtener el último SID del archivo, excluyendo las líneas comentadas
    last_sid=$(awk -F'sid:|;' '/^alert/ && !/^#/ && /sid:[0-9]+;/ { match($0, /sid:([0-9]+)/, arr); sid = arr[1]; if (sid > max) max = sid } END { if (max == "") max = "000000001"; print max }' "$file_path")

    # Devolver el último SID
    echo "$last_sid"
}


create_final_rule() {
    clear
    #echo -e "| $(color 31 ${action_name}) | $(color 31 ${protocol_name}) | $(color 31 ${message_text}) | $(color 31 ${content_name}) | $(color 31 ${sid_calculated}) | $(color 31 ${rev_count}) |"
    state_rule
    final_rule="${action_name} ${protocol_name} any any -> any any (msg:\"${message_text}\"; content:\"${content_name}\"; nocase; classtype:policy-violation; sid:${sid_calculated}; rev:${rev_count};)"
    echo "This is your new rule: "
    echo "${final_rule}"
    wait
}

final_steps_rule_creation(){
    true_final_steps=1
    while [ "$true_final_steps" -eq 1 ]; do
        clear
        state_rule
        final_steps_rule_creation_menu
        read -p "> " number_final_steps
        
        if [ "$number_final_steps" -eq 1 ]; then
            save_rule
            true_final_steps=0
            reset_option_rule
            break
        elif [ "$number_final_steps" -eq 2 ]; then
            edit_rule
            true_final_steps=0
            break
        elif [ "$number_final_steps" -eq 3 ]; then
            true_final_steps=0
            reset_option_rule
            break
        else
            echo "[ERROR]: Number failed."
            wait
        fi
    done
}

save_rule(){
    clear
    state_rule
    save_final_rule
    echo "Your rule has been save successfully."
    test_rules_suricata
    wait
}

reset_option_rule(){
    action_name=""
    protocol_name=""
    message_text=""
    content_name=""
    sid_calculated=""
    rev_count=""
    final_file=""
}

edit_rule() {
    while true; do
        clear
        state_rule
        edit_rule_menu
        
        read -p "> " edit_choice

        case $edit_choice in
            1) choose_action ;;
            2) choose_protocol ;;
            3) enter_message ;;
            4) enter_content_name ;;
            5) final_steps_rule_creation ;;
            *) echo "Invalid option" ;;
        esac
    done
}