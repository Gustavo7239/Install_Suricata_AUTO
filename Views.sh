#!/bin/bash
#source Functions.sh
#source Initializer.sh

action_rules_menu(){
    clear
    title_rules_1
    echo "*. Select a action for your new rule:"
    echo "   - Pass > Drop > Reject > Alert - "
    echo -e "   1. $(color 32 'Pass')"
    echo -e "   2. $(color 31 'Drop')"
    echo -e "   3. $(color 91 'Reject')"
    echo -e "   4. $(color 93 'Alert')"
    echo    "   0. Exit"
    echo ""
}

protocol_rules_menu() {
    echo "Seleccione un protocolo para la regla:"
    echo "0. Cancelar"
    echo "1. TCP"
    echo "2. UDP"
    echo "3. ICMP"
    echo "4. HTTP"
    echo "5. FTP"
    echo "6. SMTP"
    echo "7. DNS"
    echo "8. TLS"
} 

presentation(){
    clear
    title_main_1
    echo -e "by: $(color 32 'MoTechno')"
    motechno_logo_img
    wait
}

title_main_1(){
    echo "---------------------------------------[BASIC SURICATA]---------------------------------------"
}

title_rules_1(){
    echo "---------------------------------[MoTechno AUTO-Creator Rules]---------------------------------"
}

main_options_menu(){
    title_main_1
    echo "1. Install Suricata"
    echo "2. Test NFQ"
    echo "3. Configure Suricata"
    echo "4. Add personal Rules"
    echo "5. Start Suricata"
    echo "6. Restart Suricata"
    echo "0. Exit"
}

edit_rule_menu(){
    title_rules_1
    echo "Which part of the rule do you want to change?"
    echo "1. Action"
    echo "2. Protocol"
    echo "3. Message"
    echo "4. Content"
    echo "5. Finish Edit"
}

final_steps_rule_creation_menu(){
    title_rules_1
    echo "What do you want to do now?"
    echo "1. Save"
    echo "2. Edit"
    echo "3. Cancel"
}

exit_menu(){
    clear
    echo "Thanks for trust in MoTechno company"
    motechno_logo_img
    wait
    clear
}

motechno_logo_img(){
    echo -e "\033[32m                                                                                                                                                                               
                                              /   &#/*  (./(/.  /.(  &/                                             
                                    #,.,%    ,,./   #,#&&.( #,(%#,/  #,,& %#                                    
                                       &.%   #*(%#               #. %,  ,*.* .,.(                               
                             (&         **      (%(*,..........,/#/         %.#   /*                            
                          &,#@#           #,......,................,...,(/     (,.#  #.#                        
                           /,&,/     @*.,...,...*# /..(%..(*.,#  /..,# /....**     %.%                          
                     #    #%      /..*( .*..../   ,.,( #../  *.#   #....%   *(..(     /*  (.,(                  
                      (.(.&    (..#     %..,*,..,..(   %..&   ,.. ..*(...*      %,.%    #.&  *.&                
                  (*,%      .,.*/      ,.*     (....,.............%     *.,.       *./    /,*.%                 
                //.   ,    *.*       %./       ,,*     /.,*     #..       #.,.       (.*      &*.*/             
              /,@.&*#    (...#      *.*       *.(      %..&      %.,        *.%    #,....#    //%*&.            
              ,(.,.%   .,.& /#/......#       /.*        ,.&       #..       %.....*%    #.,    #..#             
            %*%&      %.(        %..,..,.,***..#       #,.#       (........,/#,.*        ,..#     %/..#         
           &,  @,    ,.#         ,.&       %...........,,......,*/*,..%       ...#         /./                  
           ,*#/.*    ,/         (.%        %..&        #,,*        ,..#        %.,          ,,    &,/,&,        
                    #..        (..         #./         #..#         *.*         /.(         #.#    *%# /#       
         ,,,..,     ,*         #.,         /.(         #..&         #.,         %.,         &.,                 
           %,#     ../         /,.         .,*         #..(         %../        %../        /,.     ,&*&,       
        .*.%       ...........,.,.........,.,.,.....................................,,******,..     *%/%*@      
                   ../         #.&        #../          /.(         #..*        %.,          .,                 
                                                                                                              
       (00000\   /0000|           ,000o000oOO0,                        ,0000                                                   
       (0/,000%%.*,000| ,ooooooooo,   ,000|   ,.00ooooo%,  ,ooooooooo, ,0000oooooo, ,ÜÜÜÜoooooo, ,ooooooooo,        
       (0/*00000, ,000| 0000   0000   ,000|  &.000    |00  0000        ,0000  '0000 ,0000   0000 0000   0000          
       (0/ #000,  ,000| 0000   0000   ,000|  *.000******'  0000        ,0000   0000 ,0000   0000 0000   0000         
       (0   000   ,000| '000#&#000'   ,000|   *.########'  '000#&#000' ,0000   0000 ,0000   0000 '000#&#000'

      &#%%%#%%#%#%%%%%%#%#%##%%%#%##%%%##%#%%#%%#%#######%%%##%%%%##%%#####%#%%#%%############%#####%##%####/                                                                                                                                                                                                                  
\033[0m"
}
