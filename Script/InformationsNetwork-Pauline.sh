######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

echo "1 - Connaitre le nombre d'interface réseaux"
echo "2 - Connaitre les adresses IP"
echo "3 - Connaitre les adresses MAC"
echo "4 - Retour au menu précédent"
read choix

case $choix in 
    # nombre d'interfaces
    1)  ip -brief address show | awk '{print $1, $3}' | wc -l ;
        Retour menu précédent 
        ;;
    # Adresse IP de chaque interface
    2)  ip addr show | grep 'inet ' | awk '{print $2}' | cut -d/ -f1
        Retour menu précédent
        ;;
    # Adresse Mac
    3)  ip link show | grep 'link/ether' | awk '{print $2}'
        ;;
        Retour menu précédent
    4)  Retour menu précédent
        ;;
esac
