######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 2 : informations systeme
# LOGS a finir  
######################################################################

echo -e "\n______________________ INFORMATIONS SYSTEME ______________________\n"
echo "Informations Interfaces                                             : 1"
echo "Informations Materiel                                               : 2"
echo "Informations Logs                                                   : 3"
echo "Informations Applications et Utilisateurs Locaux                    : 4"
echo "Retour menu precedent                                               : 5"
echo -e "Quitter                                                             : 6\n"
read -p "Votre choix : " choix

while [ "$choix" != "5" ]; do
case "$choix" in
        1) 
        #Informations Interfaces
        source $(pwd)/Library/Informations_Interfaces.sh
        ;;
        2) 
        #Informations Matériel
        source source $(pwd)/Library/Informations_Materiels.sh
        ;;
        3) 
        #Informations Logs
        source $(pwd)/Library/Informations_Logs.sh
        ;; 
        4) 
        #Informations Applications et Utilisateurs Locaux
        source $(pwd)/Library/Informations_Applications_Utilisateurs.sh
        ;;
        5) 
        #retour menu précédent 
        echo "Retour au menu principal"
        sleep 1
        ;;
        6)
        exit 0
        ;;
esac
done
