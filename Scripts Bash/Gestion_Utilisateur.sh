######################################################################
#! /bin/bash
# Auteur : Chahine MARZOUK 
# version : 1.0 
# Description : script Gestion des Utilisateurs
######################################################################

# Vérifier si l'utilisateur a les droits sudo
if [[ $EUID -ne 0 ]]; then
    echo "Ce script doit être exécuté en tant que root (ou avec sudo)."
    exit 1
fi

while true; do
    echo "=== Gestion des Utilisateurs ==="
    echo "1) Création de compte utilisateur local"
    echo "2) Changement de mot de passe"
    echo "3) Suppression de compte utilisateur local"
    echo "4) Désactivation de compte utilisateur local"
    echo "5) Quitter"
    read -p "Choisissez une option (1-5) : " choix

    case $choix in
        1)
            read -p "Entrez le nom du nouvel utilisateur : " new_user
            sudo adduser "$new_user"
            echo "Utilisateur $new_user créé avec succès."
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur : " user
            sudo passwd "$user"
            echo "Mot de passe changé pour l'utilisateur $user."
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur à supprimer : " del_user
            sudo userdel -r "$del_user"
            echo "Utilisateur $del_user supprimé."
            ;;
        4)
            read -p "Entrez le nom de l'utilisateur à désactiver : " disable_user
            sudo usermod -L "$disable_user"
            echo "Utilisateur $disable_user désactivé."
            ;;
        5)
            echo "Fin du script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir un nombre entre 1 et 5."
            ;;
    esac
done
