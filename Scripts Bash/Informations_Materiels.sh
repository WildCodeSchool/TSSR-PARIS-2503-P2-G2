#!/bin/bash
######################################################################
# Auteur : Chahine MARZOUK
# Version : 1.1
# Description : Script Informations Système - exécuté à distance via SSH
######################################################################

# Demander l'adresse IP ou le nom d'hôte de la machine distante
read -p "Adresse IP ou nom d'hôte de la machine distante : " client

# Demander le nom d'utilisateur SSH
read -p "Nom de l'utilisateur SSH : " remote_user

# Boucle pour afficher le menu jusqu'à ce que l'utilisateur choisisse "Quitter"
while true; do
    echo ""
    echo "=== Informations Système ==="
    echo "1) Type de CPU, nombre de cœurs, etc."
    echo "2) Mémoire RAM totale"
    echo "3) Utilisation de la RAM"
    echo "4) Utilisation du disque"
    echo "5) Utilisation du processeur"
    echo "6) Quitter"
    read -p "Choisissez une option (1-6) : " choix

    case $choix in
        1)
            echo "=== Informations CPU ==="
            ssh  "$remote_user@$client" "lscpu | grep -E 'Model name|Socket|Thread|CPU\(s\)'"
            ;;
        2)
            echo "=== Mémoire RAM Totale ==="
            ssh  "$remote_user@$client" "free -h | grep 'Mem' | awk '{print \"RAM Totale : \" \$2}'"
            ;;
        3)
            echo "=== Utilisation de la RAM ==="
            ssh  "$remote_user@$client" "free -h"
            ;;
        4)
            echo "=== Utilisation du disque ==="
            ssh  "$remote_user@$client" "df -h --total | grep 'total'"
            ;;
        5)
            echo "=== Utilisation du processeur ==="
            ssh  "$remote_user@$client" "top -bn1 | grep 'Cpu(s)' | awk '{print \"Utilisation CPU : \" \$2 \"%\"}'"
            ;;
        6)
            echo "Fin du script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir un nombre entre 1 et 6."
            ;;
    esac
done
