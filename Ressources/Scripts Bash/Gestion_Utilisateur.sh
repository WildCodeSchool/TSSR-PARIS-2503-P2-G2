######################################################################
#!/bin/bash
# Auteur : Chahine MARZOUK (adapté pour SSH)
# Version : 2.0
# Description : Script de gestion des utilisateurs via SSH
# OK SSH
######################################################################

# Demander l'IP ou le nom d'hôte de la machine distante
read -p "Adresse IP ou nom d'hôte de la machine distante (Ubuntu) : " cible

# Demander l'utilisateur distant (avec droits sudo)
read -p "Nom de l'utilisateur distant : " ssh_user

# Tester la connexion SSH
if ! ssh -q "${ssh_user}@${cible}" exit; then
    echo "Impossible de se connecter à $cible avec l'utilisateur $ssh_user."
    exit 1
fi

while true; do
    echo "=== Gestion des Utilisateurs sur $cible ==="
    echo "1) Création de compte utilisateur local"
    echo "2) Changement de mot de passe"
    echo "3) Suppression de compte utilisateur local"
    echo "4) Désactivation de compte utilisateur local"
    echo "5) Quitter"
    read -p "Choisissez une option (1-5) : " choix

    case $choix in
        1)
            read -p "Entrez le nom du nouvel utilisateur : " new_user
            ssh -t "${ssh_user}@${cible}" "sudo adduser '$new_user'"
            ;;
        2)
            read -p "Entrez le nom de l'utilisateur : " user
            ssh -t "${ssh_user}@${cible}" "echo 'Changement de mot de passe pour $user'; sudo passwd '$user'"
            ;;
        3)
            read -p "Entrez le nom de l'utilisateur à supprimer : " del_user
            ssh -t "${ssh_user}@${cible}" "sudo userdel -r '$del_user' && echo 'Utilisateur $del_user supprimé.'"
            ;;
        4)
            read -p "Entrez le nom de l'utilisateur à désactiver : " disable_user
            ssh -t "${ssh_user}@${cible}" "sudo usermod -L '$disable_user' && echo 'Utilisateur $disable_user désactivé.'"
            ;;
        5)
            echo "Fin du script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir un nombre entre 1 et 5."
            ;;
    esac

    echo ""
    read -p "Appuyez sur Entrée pour continuer..."
    clear
done
