######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# Version : 1.0 
# Description : Fonction pour logs 
# A valider + ajouter dans le script global 
######################################################################

#fonction à ajouter au début du script global 
function INITIALISATION ()
{
#Initialisation des variables pour le fichier log 
ORDINATEUR=$(hostname)
DATE=$(date +"%d-%m-%Y")
HEURE=$(date +"%H:%M:%S")
FICHIERLOG="Info_${ORDINATEUR}_${DATE}.log"
LOGPATH="/var/log/$FICHIERLOG"

#Création fichier log 
sudo touch "$FICHIERLOG"
#Ajout ==========StartScript========== dans le fichier log 
echo "$DATE$HEURE$ORDINATEUR==========StartScript==========" >> $FICHIERLOG

#changements droits fichier log
sudo chmod 600 "$FICHIERLOG"
}





#fonction à ajouter à chaque début de code 
function ENTREE ()
{
echo "$0" | sudo tee -a /var/log/"$FICHIERLOG" > /dev/null
echo "$1" | sudo tee -a /var/log/"$FICHIERLOG" > /dev/null
}





#fonction à ajouter à chaque fin de code 
function SORTIE ()
{
if #? [ -eq 0 ]; 
then 
echo "Ceci est une sortie standard" >> /var/log/"$FICHIERLOG" 2>&1
else  
echo "Ceci est une sortie d'erreur" >> /var/log/"$FICHIERLOG" 2>&1
fi 
}





#fonction à ajouter avant la sortie du script global 
function FIN_SCRIPT ()
{
#Ajout ==========EndScript========== dans le fichier log 
echo "$DATE$HEURE$ORDINATEUR==========EndScript==========" >> $FICHIERLOG
}