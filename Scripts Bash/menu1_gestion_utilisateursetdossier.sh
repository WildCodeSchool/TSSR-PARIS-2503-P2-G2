######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Menu 1 : gestion utilisateur et dossier
# LOGS a finir  
######################################################################

echo "______________________ GESTION UTILISATEURS ET DOSSIER ______________________"
                        echo "Gestion des utilisateurs : 1"
                        echo "Gestion des groupes : 2"
                        echo "Informations des utilisateurs : 3"
                        echo "Gestion répertoire : 4"
                        echo "Gestion droits et permissions : 5"
                        echo "Retour menu précédent : 6"
                        read -p "Votre choix : " choix_gestion_utilisateurs_dossier

                        while [ "$choix_gestion_utilisateurs_dossier" != "6" ]; do
                                1) #Gestion des utilisateurs
                                        source ./Gestion_Utilisateur.sh
                                        ;;
                                2) #Gestion des groupes
                                        source ./Gestion_Groupe.sh
                                        ;;
                                3) #Informations des utilisateurs
                                        source ./Informations_Utilisateur.sh
                                        ;;
                                4) #Gestion des répertoires
                                        source ./Gestion_repertoire.sh
                                        ;;
                                5) #Gestion droits et permissions
                                        source ./Gestion_DroitsPermission.sh
                                        ;;
                                6) #retour menu précédent
                                        echo "Retour au menu principal"
                                        sleep 3
                                        source ./ScriptFinal.sh
                                        ;;
                        done
