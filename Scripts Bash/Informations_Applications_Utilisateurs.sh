
######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Informations Application Utilisateurs projet 2 
######################################################################

echo "Entrez l'adresse IP de la machine Ubuntu client :"
read client

while true; do
    echo "=============================="
    echo "1 - Voir la liste des paquets installés"
    echo "2 - Voir la liste des utilisateurs locaux"
    echo "3 - Quitter"
    echo "=============================="
    read -p "Votre choix : " choix

    case "$choix" in
        1)
            echo "Connexion à $client..."
            ssh "$client" 'dpkg --list | less'
            ;;
        2)
            echo "Connexion à $client..."
            ssh "$client" "awk -F: '{ print \$1}' /etc/passwd"
            ;;
        3)
            echo "Au revoir !"
            break
            ;;
        *)
            echo "Choix invalide, veuillez réessayer."
            ;;
    esac

    echo ""
    read -p "Appuyez sur Entrée pour revenir au menu..."
    clear
done
