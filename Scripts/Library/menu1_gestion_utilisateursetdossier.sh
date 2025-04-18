######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 1 : gestion utilisateur et dossier
# LOGS a finir  
######################################################################

echo -e "\n______________________ GESTION UTILISATEURS ET DOSSIER ______________________\n"
echo "Gestion des utilisateurs                                                        : 1"
echo "Gestion des groupes                                                             : 2"
echo "Informations des utilisateurs                                                   : 3"
echo "Gestion repertoire                                                              : 4"
echo "Gestion droits et permissions                                                   : 5"
echo "Retour menu precedent                                                           : 6"
echo -e "Quitter le script                                                               : 7\n"
read -p "Votre choix : " choix

while [ "$choix" != "6" ]; do
        case "$choix" in
                1) 
                #Gestion des utilisateurs
                source $(pwd)/Library/Gestion_Utilisateur.sh
                ;;
                2) 
                #Gestion des groupes
                source $(pwd)/Library/Gestion_Groupe.sh
                ;;
                3) 
                #Informations des utilisateurs
                source $(pwd)/Library/Informations_Utilisateur.sh
                ;;
                4) 
                #Gestion des répertoires
                source $(pwd)/Library/Gestion_repertoire.sh
                ;;
                5) 
                #Gestion droits et permissions
                source $(pwd)/Library/Gestion_DroitsPermission.sh
                ;;
                6) 
                #retour menu précédent
                echo "Retour au menu principal"
                sleep 2
                ;;
                7)
                exit 0
                ;;
        esac
done
