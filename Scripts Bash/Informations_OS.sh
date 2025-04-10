######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script informations OS projet 2 
# A verifier ssh
######################################################################


echo "Entrez l'adresse IP ou le nom d'hôte de la machine Ubuntu client :"
read client

while true; do
    echo "==============================="
    echo "1 - Afficher la version de l'OS du client"
    echo "2 - Retour au menu précédent"
    echo "==============================="
    read -p "Votre choix : " choix

    case "$choix" in
        1)
            echo "Connexion à $client..."
            ssh "$client" "hostnamectl | awk 'NR==6'"
            ;;
        2)
            echo "Retour au menu précédent."
            break
            ;;
        *)
            echo "Choix invalide. Veuillez réessayer."
            ;;
    esac

    echo ""
    read -p "Appuyez sur Entrée pour revenir au menu..."
    clear
done
