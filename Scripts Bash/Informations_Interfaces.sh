######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script informations interfaces projet 2 
######################################################################

echo "Entrez l'adresse IP ou le nom d'hôte de la machine Ubuntu client :"
read client

while true; do
    echo "===================================="
    echo "1 - Connaitre le nombre d'interfaces réseau"
    echo "2 - Connaitre les adresses IP"
    echo "3 - Connaitre les adresses MAC"
    echo "4 - Retour au menu précédent"
    echo "===================================="
    read -p "Votre choix : " choix

    case $choix in
        1)
            ssh "$client" "echo \"Il y a \$(ip -brief address show | awk '{print \$1, \$3}' | wc -l) interfaces actuellement\""
            ;;
        2)
            ssh "$client" "ip addr show | grep 'inet ' | awk '{print \$2}' | cut -d/ -f1"
            ;;
        3)
            ssh "$client" "ip link show | grep 'link/ether' | awk '{print \$2}'"
            ;;
        4)
            echo "Retour au menu principal."
            break
            ;;
        *)
            echo "Choix invalide. Veuillez réessayer."
            ;;
    esac

    echo ""
    read -p "Appuyez sur Entrée pour revenir au menu..."
    clear
done
