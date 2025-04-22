######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script informations interfaces  
# manque logs
######################################################################

echo "Entrez l'adresse IP ou le nom d'hôte de la machine Ubuntu client :"
read client

    echo "Pour connaitre le nombre d'interfaces réseau : 1 "
    echo "Pour connaitre les adresses IP : 2 "
    echo "Pour connaitre les adresses MAC : 3 "
    echo "Pour revenir au menu précédent : retour "
    echo "Pour quitter le script : quitter "

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
        quitter)
            exit 0
    esac
done
