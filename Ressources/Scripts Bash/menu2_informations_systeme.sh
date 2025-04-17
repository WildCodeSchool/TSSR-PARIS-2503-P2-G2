######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 2 : informations systeme
# LOGS a finir  
######################################################################

echo "______________________ INFORMATIONS SYSTEME ______________________"
echo "Informations Interfaces : 1"
echo "Informations Matériel : 2"
echo "Informations Logs : 3"
echo "Informations Applications et Utilisateurs Locaux : 4"
echo "Retour menu précédent : 5"
read -p "Votre choix : " choix

while [ "$choix" != "5" ]; do
case "$choix" in
        1) 
        #Informations Interfaces
        source ./Informations_Interfaces.sh
        ;;
        2) 
        #Informations Matériel
        source ./Informations_Materiels.sh
        ;;
        3) 
        #Informations Logs
        source ./Informations_Logs.sh
        ;; 
        4) 
        #Informations Applications et Utilisateurs Locaux
        source ./Informations_Applications_Utilisateurs.sh
        ;;
        5) 
        #retour menu précédent 
        echo "Retour au menu principal"
        sleep 3
        source ./ScriptFinal.sh 
        ;;
esac
done
