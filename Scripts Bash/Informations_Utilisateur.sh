######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script informations utilisateurs 
# REVOIR formatage date 1) et 3) et commande du 2) 
######################################################################
# Demander IP/hostname de la machine cliente
read -p "Adresse IP ou nom d'hôte de la machine Ubuntu client : " client

# Demander l'utilisateur à auditer
read -p "Nom de l'utilisateur à auditer : " utilisateur

# Menu
while true; do
    echo "========================================"
    echo "Audit utilisateur : $utilisateur @ $client"
    echo "1 - Date de dernière connexion"
    echo "2 - Date de dernière modification du mot de passe"
    echo "3 - Liste des sessions actives de l'utilisateur"
    echo "4 - Quitter"
    echo "========================================"
    read -p "Votre choix : " choix

    case "$choix" in
        1)
            echo -e "Dernière connexion de $utilisateur :"
            ssh "$client" "lastlog -u $utilisateur | awk 'NR==2 {print}'"

            ;;
        2)
            echo -e "Dernière modification du mot de passe :"
            ssh "$client" "chage -l $user | awk 'NR==1 {print}'"
            ;;
        3)
            echo -e "Sessions ouvertes pour $utilisateur :"
            ssh "$client" "who | grep '^$utilisateur'"
            ;;
        4)
            echo "Fin de l'audit."
            break
            ;;
        *)
            echo "Choix invalide, réessayez."
            ;;
    esac

    echo ""
    read -p "Appuyez sur Entrée pour revenir au menu..."
    clear
done
