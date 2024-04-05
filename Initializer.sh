#!/bin/bash

# Incluir las funciones y vistas necesarias
source Views.sh
source Functions.sh

# Archivo de reglas de Suricata
#suricata_rules_file="/etc/suricata/rules/my2.rules"
suricata_rules_file="/var/lib/suricata/rules/suricata.rules"

# Punto de entrada principal
main() {
    choose_main_options
}

# Ejecutar el programa principal
presentation
main
