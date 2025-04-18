######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# Version : 1.0 
# Description : Fonction pour logs 
# A valider + ajouter dans le script global 
######################################################################

# Fonction à ajouter au début du script global
function INITIALISATION ()
{
    # Initialisation des variables pour le fichier log 
    ORDINATEUR=$(hostname)
    DATE=$(date +"%d-%m-%Y")
    HEURE=$(date +"%H:%M:%S")
    FICHIERLOG="Info_${ORDINATEUR}_${DATE}.log"
    LOGPATH="/var/log/$FICHIERLOG"

    # Création du fichier log
    sudo touch "$LOGPATH"
    
    # Ajout ==========StartScript========== dans le fichier log
    echo "$DATE $HEURE $ORDINATEUR ==========StartScript==========" | sudo tee -a "$LOGPATH" > /dev/null

    # Changements des droits sur le fichier log
    sudo chmod 600 "$LOGPATH"
}

# Fonction à ajouter à chaque début de code 
function ENTREE ()
{
    echo "$0" | sudo tee -a "$LOGPATH" > /dev/null
    echo "$1" | sudo tee -a "$LOGPATH" > /dev/null
}

# Fonction à ajouter à chaque fin de code 
function SORTIE ()
{
    if [ $? -eq 0 ]; then
        # Si le code de retour est 0 (succès), afficher "Ceci est une sortie standard"
        echo "Ceci est une sortie standard" | sudo tee -a "$LOGPATH" > /dev/null
    else  
        # Si le code de retour est différent de 0 (échec), afficher "Ceci est une sortie d'erreur"
        echo "Ceci est une sortie d'erreur" | sudo tee -a "$LOGPATH" > /dev/null
    fi 
}

# Fonction à ajouter avant la sortie du script global 
function FIN_SCRIPT ()
{
    # Ajout ==========EndScript========== dans le fichier log
    echo "$DATE $HEURE $ORDINATEUR ==========EndScript==========" | sudo tee -a "$LOGPATH" > /dev/null
}
