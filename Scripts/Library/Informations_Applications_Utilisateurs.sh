######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script Informations Application Utilisateurs 
######################################################################

echo "Entrez l'adresse IP de la machine Ubuntu client :"
read client

    echo "=============================="
    echo "Pour voir la liste des paquets installés : 1"
    echo "Pour voir la liste des utilisateurs locaux : 2"
    echo "Pour revenir au menu precedent : retour"
    echo "Pour quitter le script : quitter"
    echo "=============================="
    read -p "Votre choix : " choix

while [ "$choix" != "retour" ]; do
    case "$choix" in
        1)
            echo "Connexion à $client..."
            sudo echo "$DATE-$HEURE-$USER-$1 : affichage de la liste des paquets installées : $ip" >> $LOGFILE
            ssh "$client" 'dpkg --list | less'sudo echo "$DATE-$HEURE-$USER-$1 : demande IP de la machine distante : $ip" >> $LOGFILE
            ;;
        2)
            sudo echo "$DATE-$HEURE-$USER-$1 : affichage de la liste des utilisateurs locaux : $ip" >> $LOGFILE
            ssh "$client" "awk -F: '{ print \$1}' /etc/passwd"
            ;;
        retour)
            sudo echo "$DATE-$HEURE-$USER-$1 : retour au menu précédent" >> $LOGFILE
            echo "Retour au menu precedent "
            sleep 3 
            ;;
        quitter) 
            exit 0
            ;;
    esac
done
