######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

echo "1 pour connaitre la liste des applications/paquets installées"
echo "2 pour voir la liste des utilisateurs locaux"

read choix 

    case "$choix" in
        1)
            dpkg --list 
            #Ajouter commande retour menu précédent 
            ;;
        2)
            awk -F: '{ print $1}' /etc/passwd 
            # Ajouter commande retour menu précédent 
            ;;
    esac