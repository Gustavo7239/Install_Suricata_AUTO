#!/bin/bash
source Functions_Install.sh
source Functions_AUTO_Rules.sh
source Functions_Configure.sh


#-----------------[COLORS]-----------------
color(){
    local codeColor="$1"
    local text="$2"
    local textColor="\033[0;${codeColor}m${text}\033[0m"
    echo "$textColor"
}
#-----------------[FUNCTIONS]-----------------
wait(){
    echo -e "$(color 31 'Please press [ENTER] to continue.')"
    read w   
}

check_suricata_installed(){
    if dpkg -l | grep suricata > /dev/null; then
        echo "Suricata is already installed."
        return 0
    else
        echo "Suricata is not installed."
        return 1
    fi
}

save_final_rule() {
    echo "${final_rule}" | sudo tee -a "$suricata_rules_file" >/dev/null
}

state_rule(){
    echo -e "| $(color 31 ${action_name}) | $(color 31 ${protocol_name}) | $(color 31 ${message_text}) | $(color 31 ${content_name}) | $(color 31 ${sid_calculated}) | $(color 31 ${rev_count}) |"
}

ask_for_save(){
    clear
    echo "Are you sure to save your new rule?"
}

run_suricata_command() {
    gnome-terminal --title="Please do not close this terminal" -- sudo suricata -c /etc/suricata/suricata.yaml -q 0 <<< "echo Please do not close this terminal; sudo suricata -c /etc/suricata/suricata.yaml -q 0; read -p 'Press Enter to close this terminal'"
}

delate_iptables_for_comment() {
    local comment="$1"
    local rule_type="$2"

    rules=$(sudo iptables -L $rule_type -n --line-numbers --verbose | grep "$comment" | awk '{print $1}')

    if [ -z "$rules" ]; then
        echo "No rule found with the comment '$comment'."
    else
        for rule in $rules; do
            sudo iptables -D $rule_type "$rule"
        done
        echo "Rule(s) with the comment '$comment' removed successfully."
    fi
}

insert_ip_tables(){
    #sudo iptables -F
    delate_iptables_for_comment "MTRules" "INPUT"
    delate_iptables_for_comment "MTRules" "OUTPUT"
    sudo iptables -I INPUT -j NFQUEUE -m comment --comment "MTRules"
    sudo iptables -I OUTPUT -j NFQUEUE -m comment --comment "MTRules"
    sudo iptables -L
    wait
}

test_rules_suricata(){
    sudo suricata -T
}

restart_suricata(){
    insert_ip_tables
    test_rules_suricata
}

start_suricata(){
    run_suricata_command
    insert_ip_tables
    choose_main_options
}

test_NFQUEUE(){
    if sudo suricata --build-info | grep -q "NFQueue support"; then
        if sudo suricata --build-info | grep -q "NFQueue support: yes"; then
            echo "NFQueue support is already enabled."
        else
            echo "NFQueue support is not enabled. Enabling..."
            
            sudo sed -i 's/NFQueue support: no/NFQueue support: yes/' /etc/suricata/suricata.yaml

            echo "NFQueue support has been enabled."
        fi
    else
        echo "Unable to determine NFQueue support status. Please check Suricata build information manually."
    fi
}

choose_main_options() {
    true_main=1
    while [ "$true_main" -eq 1 ]; do
        clear
        main_options_menu
        read -p "> " number_main_option
        
        if [ "$number_main_option" -eq 1 ]; then
            install_and_update
            create_our_directory_rules
            break
        elif [ "$number_main_option" -eq 2 ]; then
            test_NFQUEUE
            wait
            choose_main_options
            break
        elif [ "$number_main_option" -eq 3 ]; then
            modify_suricata_config
            wait
            choose_main_options
            break
        elif [ "$number_main_option" -eq 4 ]; then
        #create_our_directory_rules
            add_new_rules
            break
        elif [ "$number_main_option" -eq 5 ]; then
            start_suricata
            break
        elif [ "$number_main_option" -eq 6 ]; then
            restart_suricata
            break    
        elif [ "$number_main_option" -eq 0 ]; then
            exit_menu
            exit
        else
            echo "[ERROR]: Number failed."
            wait
        fi
    done
}
