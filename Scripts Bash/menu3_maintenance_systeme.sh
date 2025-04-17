######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 3 : maintenance systeme
# LOGS a finir  
######################################################################

echo "______________________ MAINTENANCE SYSTEME ______________________"
echo "Information sur OS : 1"
echo "Mise à jour de l'OS : 2"
echo "Informations pare-feu : 3"
echo "Gestion pare-feu : 4"
echo "Gestion logiciels : 5"
echo "Arret, redémarrage et verrouillage : 6"
echo "Gestion à distance : 7"
echo "Retour menu précédent : 8"
read -p "Votre choix : " choix_maintenance_systeme

while [ "$choix_maintenance_systeme" != "8" ]; do

        case "expression" in
                1) 
                #Information OS
                        source ./Informations_OS.sh
                        ;;
                2) 
                #Mise à jour de l'OS
                        source ./MAJ.sh
                        ;;
                3) 
                #Informations pare-feu
                        source ./Informations_Port_Parefeu.sh
                        ;; 
                4) 
                #Gestion pare-feu
                        source ./Gestion_Parefeu.sh
                        ;;
                5) 
                #Gestion logiciels
                        source ./Gestion_Logiciels.sh
                        ;;
                6) 
                #Arret, redémarrage et verrouillage
                        source ./Etat_Ordinateur.sh
                        ;;
                7) 
                #Gestion à distance
                        source ./Gestion_Distance.sh
                        ;; 
                8) 
                #retour menu précédent
                        echo "Retour au menu principal"
                        sleep 3
                        source ./ScriptFinal.sh 
                        exit
        esac
done
