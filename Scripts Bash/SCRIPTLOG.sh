#!/bin/bash

Function LOGENTREE ()
{
# Variable nom de l'ordinateur 
ORDINATEUR=hostname 

#Variable date jour 
DATE=(date +"%d %m %Y")

#Variable Date jour + heure 
DATEHEURE=echo "$(date +'%Y-%m-%d %H:%M:%S')"

#Créer le fichier avec le nom généré
FICHIERDUJOUR=touch "Info_$ORDINATEUR_$DATE.log"
echo "$DATEHEURE === Script lancé ===" >> $LOGFILE

# Variable chemin fichier log 
LOGFILE="/var/log/$FICHIERDUJOUR"      

# Fichier log avec date du jour
chmod 600 "$LOGFILE"

#Redirection entrée dans LOGFILE  
echo "$1 $2" >> $LOGFILE
}

Function DIRSOR ()
{
Sortie 
> $LOGFILE 2>&1
}
