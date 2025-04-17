##########################################################
#!/bin/bash
# Auteur : Chahine MARZOUK 
# version : 1.0 
# Description : Script Informations Port Parefeu via SSH
# OK SSH
##########################################################

# Demander l'IP ou le nom d'hôte de la machine distante
read -p "Adresse IP ou nom d'hôte de la machine distante : " cible

# Demander l'utilisateur SSH distant
read -p "Nom de l'utilisateur distant (avec droits sudo) : " ssh_user

# Tester la connexion SSH avant de procéder
if ! ssh -q -o LogLevel=QUIET "${ssh_user}@${cible}" exit; then
    echo "Impossible de se connecter à $cible avec l'utilisateur $ssh_user."
    exit 1
fi

# Boucle principale pour le menu
while true; do
    echo "===== Menu Informations Pare-feu ====="
    echo "1) Liste des ports ouverts (TCP/UDP)"
    echo "2) Statut du pare-feu (ufw)"
    echo "3) Quitter"
    read -p "Choisissez une option (1-3) : " choix

    case $choix in
        1)
            echo "----- 🔍 Liste des ports ouverts (TCP/UDP) -----"
            ssh -t "${ssh_user}@${cible}" "
                if command -v ss >/dev/null 2>&1; then
                    ss -tuln
                elif command -v netstat >/dev/null 2>&1; then
                    netstat -tuln
                else
                    echo 'Erreur : ni ss ni netstat n’est disponible.'
                    exit 1
                fi
            "
            ;;
        2)
            echo "----- 🔐 Statut du pare-feu (ufw) -----"
            ssh -t "${ssh_user}@${cible}" "
                if command -v ufw >/dev/null 2>&1; then
                    sudo ufw status verbose
                else
                    echo 'ufw n’est pas installé sur cette machine.'
                fi
            "
            ;;
        3)
            echo "Fin du script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir un nombre entre 1 et 3."
            ;;
    esac

    echo ""
    read -p "Appuyez sur Entrée pour revenir au menu..."
    clear
done
