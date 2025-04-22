######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script informations interfaces  
# OK SSH
# manque logs
######################################################################

echo "Entrez l'adresse IP ou le nom d'hôte de la machine Ubuntu client :"
read client

    echo "===================================="
    echo "1 - Connaitre le nombre d'interfaces réseau"
    echo "2 - Connaitre les adresses IP"
    echo "3 - Connaitre les adresses MAC"
    echo "4 - Retour au menu précédent"
    echo "===================================="
    read -p "Votre choix : " choix

while [ "$choix" != "retour" ]; do
    case "$choix" in
        1)
            ssh "$client" "echo \"Il y a \$(ip -brief address show | awk '{print \$1, \$3}' | wc -l) interfaces actuellement\""
            ;;
        2)
            ssh "$client" "ip addr show | grep 'inet ' | awk '{print \$2}' | cut -d/ -f1"
            ;;
        3)
            ssh "$client" "ip link show | grep 'link/ether' | awk '{print \$2}'"
            ;;
        retour)
            echo "Retour au menu principal."
            sleep 3 
            ;;
    esac
done
