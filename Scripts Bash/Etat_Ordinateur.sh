###################################
#!/bin/bash
#   version 0.0 
#   Auteur : Sadek SABIRI
#   description  : script etat ordinateur
# OK SSH
###################################
#!/bin/bash

# Menu utilisateur
echo "=== Menu de gestion de l'ordinateur ==="
echo "1) Arrêter l'ordinateur"
echo "2) Redémarrer l'ordinateur"
echo "3) Verrouiller la session"
echo "4) Quitter"

# Lire le choix de l'utilisateur
read -p "Votre choix : " choix
echo "vous avez entré :$choix"

case "$choix" in
    1)
        echo "Arrêt de l'ordinateur..."
        shutdown now
        ;;
    2)
        echo "Redémarrage de l'ordinateur..."
        reboot
        ;;
    3)
        echo "Verrouillage de la session..."

        # Récupérer l'ID de la session courante
        SESSION_ID=$(loginctl | grep "$(whoami)" | awk '{print $1}')

        # Verrouiller la session avec loginctl
        if [[ -n "$SESSION_ID" ]]; then
            loginctl lock-session "$SESSION_ID"
        else
            echo "Impossible de déterminer l'ID de session pour l'utilisateur."
        fi
        ;;
    4)
        echo "Fermeture du script."
        exit 0
        ;;
    *)
        echo "Choix invalide. Merci de sélectionner 1, 2, 3 ou 4."
        ;;
esac
