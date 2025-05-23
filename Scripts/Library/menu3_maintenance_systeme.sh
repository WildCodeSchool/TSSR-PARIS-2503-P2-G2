######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 3 : maintenance systeme
# LOGS a finir  
######################################################################

echo -e "\n______________________ MAINTENANCE SYSTEME ______________________\n"
echo "Information sur OS_____________________________________________: 1"
echo "Mise a jour de l'OS____________________________________________: 2"
echo "Informations pare-feu__________________________________________: 3"
echo "Gestion pare-feu_______________________________________________: 4"
echo "Gestion logiciels______________________________________________: 5"
echo "Arret, redemarrage et verrouillage_____________________________: 6"
echo "Gestion à distance_____________________________________________: 7"
echo "Retour menu precedent__________________________________________: 8"
echo -e "Quitter le script______________________________________________: 9\n"
read -p "Votre choix : " choix

while [ "$choix" != "8" ]; do

        case "$choix" in
                1) 
                #Information OS
                        source $(pwd)/Library/Informations_OS.sh
                        ;;
                2) 
                #Mise à jour de l'OS
                        source $(pwd)/Library/MAJ.sh
                        ;;
                3) 
                #Informations pare-feu
                        source $(pwd)/Library/Informations_Port_Parefeu.sh
                        ;; 
                4) 
                #Gestion pare-feu
                        source $(pwd)/Library/Gestion_Parefeu.sh
                        ;;
                5) 
                #Gestion logiciels
                        source $(pwd)/Library/Gestion_Logiciels.sh
                        ;;
                6) 
                #Arret, redémarrage et verrouillage
                        source $(pwd)/Library/Etat_Ordinateur.sh
                        ;;
                7) 
                #Gestion à distance
                        source $(pwd)/Library/Gestion_Distance.sh
                        ;; 
                8) 
                #retour menu précédent
                        echo "Retour au menu principal"
                        sleep 1
                        exit
                        ;;
                9) 
                #quitter le script
                        exit 0
                        ;;
        esac
done
