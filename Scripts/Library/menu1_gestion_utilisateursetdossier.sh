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
echo "Gestion repertoire : 4"
echo "Gestion droits et permissions : 5"
echo "Retour menu precedent : 6"
echo "Quitter le script : 7"
read -p "Votre choix : " choix

while [ "$choix" != "6" ]; do
        case "$choix" in
                1) 
                #Gestion des utilisateurs
                source /home/pauline/Bureau/"PROJET 2"/TSSR-PARIS-2503-P2-G2/Scripts/Library/Gestion_Utilisateur.sh
                ;;
                2) 
                #Gestion des groupes
                source /home/pauline/Bureau/"PROJET 2"/TSSR-PARIS-2503-P2-G2/Scripts/Library/Gestion_Groupe.sh
                ;;
                3) 
                #Informations des utilisateurs
                source /home/pauline/Bureau/"PROJET 2"/TSSR-PARIS-2503-P2-G2/Scripts/Library/Informations_Utilisateur.sh
                ;;
                4) 
                #Gestion des répertoires
                source /home/pauline/Bureau/"PROJET 2"/TSSR-PARIS-2503-P2-G2/Scripts/Library/Gestion_repertoire.sh
                ;;
                5) 
                #Gestion droits et permissions
                source /home/pauline/Bureau/"PROJET 2"/TSSR-PARIS-2503-P2-G2/Scripts/Library/Gestion_DroitsPermission.sh
                ;;
                6) 
                #retour menu précédent
                echo "Retour au menu principal"
                sleep 3
                ;;
                7)
                exit 0
                ;;
        esac
done
