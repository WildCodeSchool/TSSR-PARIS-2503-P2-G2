######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# Version : 1.1 
# Description : Script de gestion des droits et permissions via SSH
# boucle while true OK  
######################################################################

read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user
read -p "Nom de l'utilisateur à modifier : " user

echo
echo "------------------------------------------------------------"
echo "Pour ajouter au groupe admin      : 1"
echo "Pour ajouter à un groupe local    : 2"
echo "Pour supprimer d'un groupe local  : 3"
echo "Pour quitter                      : retour"
echo "------------------------------------------------------------"
read -p "Choix : " choix

while [ "$choix" != "retour" ]; do
    case "$choix" in
        1) 
        # Ajouter au groupe admin
            ssh -t "${ssh_user}@${ip}" << EOF
            sudo usermod -aG adm "$user"
            echo "$user ajouté au groupe adm"
EOF
        ;;
        2) 
        # Ajouter au groupe local
        	cat /etc/group
            read -p "Groupe local dans lequel ajouter $user : " group
            ssh -t "${ssh_user}@${ip}" << EOF 
            if grep -q "^$group:" /etc/group; then  
                    sudo usermod -aG "$group" "$user"
                    echo "$user ajouté au groupe $group"        
            else 
                    echo "Groupe $group inexistant"
            fi 
EOF
        ;;
        3) 
        # Suppression du groupe local
        	cat /etc/group
            read -p "Groupe local dans lequel supprimer $user : " group
            ssh -t "${ssh_user}@${ip}" << EOF
            if grep -q "^$group:" /etc/group; then
                    sudo gpasswd -d "$user" "$group"
                    echo "$user supprimé du groupe $group"
            else
                    echo "Groupe $group inexistant"
            fi 
EOF
        ;;
        retour)
            echo "Retour menu précedent. "
            sleep 3
            source ./menu1_gestion_utilisateursetdossier.sh
        ;;
    esac
done
