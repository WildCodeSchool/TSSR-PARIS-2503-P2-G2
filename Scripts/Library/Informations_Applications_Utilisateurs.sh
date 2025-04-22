######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script Informations Application Utilisateurs 
# manque logs
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
            ssh "$client" 'dpkg --list | less'
            ;;
        2)
            echo "Connexion à $client..."
            ssh "$client" "awk -F: '{ print \$1}' /etc/passwd"
            ;;
        retour)
            echo "Retour au menu precedent "
            sleep 3 
            ;;
        quitter) 
            exit 0
            ;;
    esac
done
