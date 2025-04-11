#!/bin/bash

Function ENTREE ()
{
ORDINATEUR=hostname 

DATE=(date +"%d %m %Y")
HEURE=echo $(%H:%M:%S)
LOGFILE=/var/log/$FICHIERDUJOUR

#Création du fichier avec le nom généré
FICHIERDUJOUR=touch "Info_$ORDINATEUR_$DATE.log"
echo "$DATE $HEURE === Script lancé ===" >> $LOGFILE

# Fichier log avec date du jour
chmod 600 "$LOGFILE"

#Redirection entrée dans LOGFILE  
echo "$1 $2" >> $LOGFILE
}

Function SORTIE ()
{
Sortie 
echo $DATE $HEURE $ORDINATEUR 2>&1 >> $LOGFILE
}
