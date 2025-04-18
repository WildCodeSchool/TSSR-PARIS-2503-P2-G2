######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script informations utilisateurs 
# OK SSH 
######################################################################
# Demander IP/hostname de la machine cliente
read -p "Adresse IP ou nom d'hôte de la machine Ubuntu client : " client

# Demander l'utilisateur à auditer
read -p "Nom de l'utilisateur à auditer : " utilisateur

    echo "Audit utilisateur : $utilisateur @ $client"
    echo "Pour voir la date de dernière connexion : 1"
    echo "Pour voir la date de dernière modification du mot de passe : 2"
    echo "Pour voir la liste des sessions actives de l'utilisateur : 3"
    echo "Pour retourner au menu précédent : retour "
    echo "Pour quitter le script : quitter "

    read -p "Votre choix : " choix

while [ "$choix" != "retour" ]; do
    case "$choix" in
        1)
            echo -e "Dernière connexion de $utilisateur :"
            ssh "$client" "lastlog -u $utilisateur" 

            ;;
        2)
            echo -e "Dernière modification du mot de passe :"
            ssh "$client" "chage -l $utilisateur | awk 'NR==1 {print}'"
            ;;
        3)
            echo -e "Sessions ouvertes pour $utilisateur :"
            ssh "$client" "who | grep '^$utilisateur'"
            ;;
        retour)
            echo "Retour menu précédent."
            ;;
        quitter)
            exit 0
            ;;
    esac
done
