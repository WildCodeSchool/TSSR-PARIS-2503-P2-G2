######################################################################
#! /bin/bash
# Auteur : Sadek SABIRI 
# version : 1.0 
# Description : script Gestion Droits Permissions
# OK SSH
######################################################################

# === Demande les infos de connexion SSH ===
read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user

# === Menu utilisateur ===
echo "=== Menu de gestion de l'ordinateur distant ==="
echo "1) Arrêter l'ordinateur"
echo "2) Redémarrer l'ordinateur"
echo "3) Verrouiller la session"
echo "4) Quitter"

# Lire le choix de l'utilisateur
read -p "Votre choix : " choix
echo "Vous avez entré : $choix"

case "$choix" in
    1)
        sudo echo "$DATE-$HEURE-$USER-$1 : Arret de l'ordinateur" >> $LOGFILE
        echo "Arrêt de l'ordinateur distant..."
        sleep 3
        ssh -t ${ssh_user}@${ip} "sudo shutdown now"
        ;;
    2)
        sudo echo "$DATE-$HEURE-$USER-$1 : Redemarrage de l'ordinateur" >> $LOGFILE
        echo "Redémarrage de l'ordinateur distant..."
        sleep 3
        ssh -t ${ssh_user}@${ip} "sudo reboot"
        ;;
    3)
        sudo echo "$DATE-$HEURE-$USER-$1 : Verrouillage de la session distante " >> $LOGFILE
        echo "Verrouillage de la session distante..."
        sleep 3
        ssh -t ${ssh_user}@${ip} '
            SESSION_ID=$(loginctl | grep "$(whoami)" | awk "{print \$1}")
            if [[ -n "$SESSION_ID" ]]; then
                loginctl lock-session "$SESSION_ID"
            else
                echo "Impossible de déterminer l'ID de session pour l'utilisateur distant."
            fi
        '
        ;;
    4)
        echo "Fermeture du script."
        exit 0
        ;;
    *)
        echo "Choix invalide. Merci de sélectionner 1, 2, 3 ou 4."
        ;;
esac
