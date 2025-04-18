######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 3 : maintenance systeme
# LOGS a finir  
######################################################################

echo -e "\n______________________ MAINTENANCE SYSTEME ______________________\n"
echo "Information sur OS                                            : 1"
echo "Mise a jour de l'OS                                           : 2"
echo "Informations pare-feu                                         : 3"
echo "Gestion pare-feu                                              : 4"
echo "Gestion logiciels                                             : 5"
echo "Arret, redemarrage et verrouillage                            : 6"
echo "Gestion à distance                                            : 7"
echo "Retour menu precedent                                         : 8"
echo -e "Quitter le script                                             : 9\n"
read -p "Votre choix : " choix

while [ "$choix" != "8" ]; do

        case "$choix" in
                1) 
                #Information OS
                        source $(pwd)/Informations_OS.sh
                        ;;
                2) 
                #Mise à jour de l'OS
                        source $(pwd)/MAJ.sh
                        ;;
                3) 
                #Informations pare-feu
                        source $(pwd)/Informations_Port_Parefeu.sh
                        ;; 
                4) 
                #Gestion pare-feu
                        source $(pwd)/Gestion_Parefeu.sh
                        ;;
                5) 
                #Gestion logiciels
                        source $(pwd)/Gestion_Logiciels.sh
                        ;;
                6) 
                #Arret, redémarrage et verrouillage
                        source $(pwd)/Etat_Ordinateur.sh
                        ;;
                7) 
                #Gestion à distance
                        source $(pwd)/Gestion_Distance.sh
                        ;; 
                8) 
                #retour menu précédent
                        echo "Retour au menu principal"
                        sleep 3
                        exit
                        ;;
                9) 
                #quitter le script
                        exit 0
                        ;;
        esac
done
