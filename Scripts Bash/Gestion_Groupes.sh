######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# Version : 1.0 
# Description : Script de gestion des droits et permissions via SSH
######################################################################

read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user
read -p "Nom de l'utilisateur à modifier : " user

echo "Pour ajouter au groupe admin : 1"
echo "Pour ajouter à un groupe local : 2"
echo "Pour supprimer d'un groupe local : 3"
read -p "Choix : " choix

case $choix in
        1) # Ajouter au groupe admin
                ssh -t **"${ssh_user}@${ip}"** << EOF
                sudo usermod -aG adm "$user"
                echo "$user ajouté au groupe adm"
EOF
        ;;
        2) # Ajouter au groupe local
                read -p "Groupe local à ajouter : " group
                ssh -t **"${ssh_user}@${ip}"** << EOF 
                        if grep -q "^$group:" /etc/group; then  
                                sudo usermod -aG "$group" "$user"
                                echo "$user ajouté au groupe $group"
                        else 
                                echo "Groupe $group inexistant"
                        fi 
EOF
        ;;
        3) # Suppression du groupe local
                read -p "Groupe local à supprimer : " group
                ssh -t **"${ssh_user}@${ip}"** << EOF
                        if grep -q "^$group:" /etc/group; then
                                sudo gpasswd -d "$user" "$group"
                                echo "$user supprimé du groupe $group"
                        else
                                echo "Groupe $group inexistant"
                        fi 
EOF
        ;;
        *)  # Si choix invalide
                echo "Choix invalide"
        ;;
esac
