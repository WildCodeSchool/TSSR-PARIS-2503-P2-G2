#####################################################################
#! /bin/bash
# Auteur : Chahine Marzouk 
# version : 1.0 
# Description : script projet 2 
#####################################################################

while true; do
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
            lscpu | grep -E "Model name|Socket|Thread|CPU\(s\)"
            ;;
        2)
            echo "=== Mémoire RAM Totale ==="
            free -h | grep "Mem" | awk '{print "RAM Totale : " $2}'
            ;;
        3)
            echo "=== Utilisation de la RAM ==="
            free -h
            ;;
        4)
            echo "=== Utilisation du disque ==="
            df -h --total | grep "total"
            ;;
        5)
            echo "=== Utilisation du processeur ==="
            top -bn1 | grep "Cpu(s)" | awk '{print "Utilisation CPU : " $2 "%"}'
            ;;
        6)
            echo "Fin du script."
            exit 0
            ;;
        *)
            echo "Option invalide. Veuillez choisir un nombre entre 1 et 6."
            ;;
    esac
    echo ""
done
