######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# Version : 1.1 
# Description : Script de gestion des droits et permissions via SSH
######################################################################

read -p "Adresse IP de la machine distante : " ip
echo "$DATE-$HEURE-$USER-$1 : adresse ip communiqué : $ip" >> $LOGFILE

read -p "Nom d'utilisateur SSH : " ssh_user
echo "$DATE-$HEURE-$USER-$1 : utilisateur distant communiqué $ssh_user" >> $LOGFILE

read -p "Nom de l'utilisateur à modifier : " user
echo "$DATE-$HEURE-$USER-$1 : utilisateur a modifier $user" >> $LOGFILE


echo
echo "------------------------------------------------------------"
echo "Pour ajouter au groupe admin      : 1"
echo "Pour ajouter à un groupe local    : 2"
echo "Pour supprimer d'un groupe local  : 3"
echo "Pour quitter                      : retour"
echo "------------------------------------------------------------"
read -p "Choix : " choix
echo "$DATE-$HEURE-$USER-$1 : choix utilisateur $choix" >> $LOGFILE


while [ "$choix" != "retour" ]; do
    case "$choix" in
        1) 
        # Ajouter au groupe admin
            echo "$DATE-$HEURE-$USER-$1 : choix utilisateur : ajouter $user au groupe admin" >> $LOGFILE
            ssh -t "${ssh_user}@${ip}" << EOF
            sudo usermod -aG adm "$user"
            echo "$DATE-$HEURE-$USER-$1 : $user ajouté au groupe admin" >> $LOGFILE
            echo "$user ajouté au groupe adm"
EOF
        ;;
        2) 
        # Ajouter au groupe local
            echo "$DATE-$HEURE-$USER-$1 : choix utilisateur : ajouter au groupe local" >> $LOGFILE
        	cat /etc/group
            read -p "Groupe local dans lequel ajouter $user : " group
            ssh -t "${ssh_user}@${ip}" << EOF 
            if grep -q "^$group:" /etc/group; then  
                    sudo usermod -aG "$group" "$user"
                    echo "$user ajouté au groupe $group"  
                    echo "$DATE-$HEURE-$USER-$1 : $user ajouté au groupe $group" >> $LOGFILE

            else 
                    echo "Groupe $group inexistant"
                    echo "$DATE-$HEURE-$USER-$1 : $group inexistant" >> $LOGFILE

            fi 
EOF
        ;;
        3) 
        # Suppression du groupe local
        	cat /etc/group
            read -p "Groupe local dans lequel supprimer $user : " group
            echo "$DATE-$HEURE-$USER-$1 : choix utilisateur : suppression $user du groupe local" >> $LOGFILE
            ssh -t "${ssh_user}@${ip}" << EOF
            if grep -q "^$group:" /etc/group; then
                    sudo gpasswd -d "$user" "$group"
                    echo "$DATE-$HEURE-$USER-$1 : $user supprimé du groupe $group" >> $LOGFILE
                    echo "$user supprimé du groupe $group"
            else
                    echo "$DATE-$HEURE-$USER-$1 : Groupe $group inexistant" >> $LOGFILE
                    echo "Groupe $group inexistant"
            fi 
EOF
        ;;
        retour)
            echo "Retour menu précedent. "
            echo "$DATE-$HEURE-$USER-$1 : retour au menu precedent" >> $LOGFILE
            sleep 3
        ;;
    esac
done
