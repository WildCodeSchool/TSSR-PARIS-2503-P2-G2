######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

echo "1 pour connaitre la liste des applications/paquets installées"
echo "2 pour voir la liste des utilisateurs locaux"

read choix 

    case $choix in
        1) #Liste des applications/paquets installées
            dpkg --list
            #retour menu précédent
            ;;
        2) # Liste des utilisateurs locaux 
            awk -F: '{ print $1 }' /etc/passwd
            # retour menu précédent
            ;;
    esac