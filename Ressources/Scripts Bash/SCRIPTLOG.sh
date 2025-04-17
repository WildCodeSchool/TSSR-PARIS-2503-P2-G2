#!/bin/bash
######################################################################
# Auteur : Pauline PRAK
# Version : 1.0 
# Description : Script d'informations OS - Projet 2 
# Utilisable en SSH
######################################################################

ORDINATEUR=$(hostname)
DATE=$(date +"%d-%m-%Y")
HEURE=$(date +"%H:%M:%S")

# Création du fichier log
FICHIERDUJOUR="Info_${ORDINATEUR}_${DATE}.log"
LOGFILE="/var/log/$FICHIERDUJOUR"

# === Fonction ENTREE ===
function ENTREE() {
    ORDINATEUR=$(hostname)
    DATE=$(date +"%d-%m-%Y")
    HEURE=$(date +"%H:%M:%S")

    # Création du fichier log
#    FICHIERDUJOUR="Info_${ORDINATEUR}_${DATE}.log"
#    LOGFILE="/var/log/$FICHIERDUJOUR"

    # Création du fichier log avec droits root
#    sudo touch "$LOGFILE"
#    sudo chmod 600 "$LOGFILE"

    # Entrée dans le fichier log   
    echo "$1 $2" | sudo tee -a "$LOGFILE" > /dev/null

    # Export pour usage global
    export FICHIERDUJOUR
    export LOGFILE
    export ORDINATEUR
}

# === Fonction SORTIE ===
function SORTIE() {
    DATE=$(date +"%d-%m-%Y")
    HEURE=$(date +"%H:%M:%S")
    echo "$DATE $HEURE $ORDINATEUR === Script terminé ===" | sudo tee -a "$LOGFILE" > /dev/null
}

echo "$DATE $HEURE === Script lancé ===" | sudo tee -a "$LOGFILE" > /dev/null
# === Appel initial (optionnel ou exemple) ===
ENTREE "Lancement" "manuel"
echo "FICHIERDUJOUR : $FICHIERDUJOUR"
echo "LOGFILE       : $LOGFILE"
echo "ORDINATEUR    : $ORDINATEUR"
echo ""

# === Demande IP ou nom d'hôte du client ===
echo "Entrez l'adresse IP ou le nom d'hôte de la machine Ubuntu client :"
read -r client

# === Menu principal ===
while true; do
    echo "==============================="
    echo "1 - Afficher la version de l'OS du client"
    echo "2 - Retour au menu précédent"
    echo "==============================="
    read -p "Votre choix : " choix

    case "$choix" in
        1)
            echo "Connexion à $client..."
            ENTREE "Requête" "Version OS"
            ssh -tt "$client" "hostnamectl | awk 'NR==6'" | sudo tee -a "$LOGFILE"
            SORTIE
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
