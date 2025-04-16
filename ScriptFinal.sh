######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Script Global
# LOGS a finir  
######################################################################


# initialisation fonction pour créer un fichier log avec la date du jour + changement des droits 
function creation_fichier_log () {
    ORDINATEUR=$(hostname)
    DATE=$(date +"%d-%m-%Y")
    HEURE=$(date +"%H:%M:%S")

    # Création du fichier log
    FICHIERDUJOUR="Info_${ORDINATEUR}_${DATE}.log"
    LOGFILE="/var/log/$FICHIERDUJOUR"

    # Création du fichier log avec droits root
    sudo touch "$LOGFILE"
    sudo chmod 600 "$LOGFILE"
}


# initialisation fonction menu_principal 
function menu_principal() {
echo "______________________ MENU PRINCIPAL ______________________"
echo "Gestion utilisateur : 1"
echo "Informations du système : 2"
echo "Maintenance du système : 3"
echo "Quitter le script : 4"
read -p "Votre choix : " choix_menu_principal

while [ "$choix_menu_principal" != "4" ]; do 
        1) #Gestion utilisateurs et dossier
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
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
        ;;
        2) #Information système
                        echo "______________________ INFORMATIONS SYSTEME ______________________"
                        echo "Informations Interfaces : 1"
                        echo "Informations Matériel : 2"
                        echo "Informations Logs : 3"
                        echo "Informations Applications et Utilisateurs Locaux : 4"
                        echo "Retour menu précédent : 5"
                        read -p "Votre choix : " choix_information_systeme

                        while [ "$choix_information_systeme" != "5" ]; do
                                1) #Informations Interfaces
                                        source ./Informations_Interfaces.sh
                                        ;;
                                2) #Informations Matériel
                                        source ./Informations_Materiels.sh
                                        ;;
                                3) #Informations Logs
                                        source ./Informations_Logs.sh
                                        ;; 
                                4) #Informations Applications et Utilisateurs Locaux
                                        source ./Informations_Applications_Utilisateurs.sh
                                        ;;
                                5) #retour menu précédent 
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
        ;;
        3) #maintenance systeme
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
                                1) #Information OS
                                        source ./Informations_OS.sh
                                        ;;
                                2) #Mise à jour de l'OS
                                        source ./MAJ.sh
                                        ;;
                                3) #Informations pare-feu
                                        source ./Informations_Port_Parefeu.sh
                                        ;; 
                                4) #Gestion pare-feu
                                        source ./Gestion_Parefeu.sh
                                        ;;
                                5) #Gestion logiciels
                                        source ./Gestion_Logiciels.sh
                                        ;;
                                6) #Arret, redémarrage et verrouillage
                                        source ./Etat_Ordinateur.sh
                                        ;;
                                7) #Gestion à distance
                                        source ./Gestion_Distance.sh
                                        ;; 
                                8) #retour menu précédent
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
        ;;
        4) #Quitter 
            echo "Fin du script"
            sleep 3 
            exit        
        ;;
done
}


# initialisation fonction menu_gestion_utilisateurs_dossier 
function menu_gestion_utilisateurs_dossier() {
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
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
}


# initialisation fonction menu_information_système 
function menu_information_système() {
                        echo "______________________ INFORMATIONS SYSTEME ______________________"
                        echo "Informations Interfaces : 1"
                        echo "Informations Matériel : 2"
                        echo "Informations Logs : 3"
                        echo "Informations Applications et Utilisateurs Locaux : 4"
                        echo "Retour menu précédent : 5"
                        read -p "Votre choix : " choix_information_systeme

                        while [ "$choix_information_systeme" != "5" ]; do
                                1) #Informations Interfaces
                                        source ./Informations_Interfaces.sh
                                        ;;
                                2) #Informations Matériel
                                        source ./Informations_Materiels.sh
                                        ;;
                                3) #Informations Logs
                                        source ./Informations_Logs.sh
                                        ;; 
                                4) #Informations Applications et Utilisateurs Locaux
                                        source ./Informations_Applications_Utilisateurs.sh
                                        ;;
                                5) #retour menu précédent 
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
}


# initialisation fonction maintenance_systeme 
function maintenance_systeme() {
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
                                1) #Information OS
                                        source ./Informations_OS.sh
                                        ;;
                                2) #Mise à jour de l'OS
                                        source ./MAJ.sh
                                        ;;
                                3) #Informations pare-feu
                                        source ./Informations_Port_Parefeu.sh
                                        ;; 
                                4) #Gestion pare-feu
                                        source ./Gestion_Parefeu.sh
                                        ;;
                                5) #Gestion logiciels
                                        source ./Gestion_Logiciels.sh
                                        ;;
                                6) #Arret, redémarrage et verrouillage
                                        source ./Etat_Ordinateur.sh
                                        ;;
                                7) #Gestion à distance
                                        source ./Gestion_Distance.sh
                                        ;; 
                                8) #retour menu précédent
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
}


#appel de la fonction création de fichier 
creation_fichier_log

# FIN DES INITIALISATIONS 

echo "______________________ MENU PRINCIPAL ______________________"
echo "Gestion utilisateur : 1"
echo "Informations du système : 2"
echo "Maintenance du système : 3"
echo "Quitter le script : 4"
read -p "Votre choix : " choix_menu_principal

while [ "$choix_menu_principal" != "4" ]; do 
        1) #Gestion utilisateurs et dossier
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
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
        ;;
        2) #Information système
                        echo "______________________ INFORMATIONS SYSTEME ______________________"
                        echo "Informations Interfaces : 1"
                        echo "Informations Matériel : 2"
                        echo "Informations Logs : 3"
                        echo "Informations Applications et Utilisateurs Locaux : 4"
                        echo "Retour menu précédent : 5"
                        read -p "Votre choix : " choix_information_systeme

                        while [ "$choix_information_systeme" != "5" ]; do
                                1) #Informations Interfaces
                                        source ./Informations_Interfaces.sh
                                        ;;
                                2) #Informations Matériel
                                        source ./Informations_Materiels.sh
                                        ;;
                                3) #Informations Logs
                                        source ./Informations_Logs.sh
                                        ;; 
                                4) #Informations Applications et Utilisateurs Locaux
                                        source ./Informations_Applications_Utilisateurs.sh
                                        ;;
                                5) #retour menu précédent 
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
        ;;
        3) #maintenance systeme
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
                                1) #Information OS
                                        source ./Informations_OS.sh
                                        ;;
                                2) #Mise à jour de l'OS
                                        source ./MAJ.sh
                                        ;;
                                3) #Informations pare-feu
                                        source ./Informations_Port_Parefeu.sh
                                        ;; 
                                4) #Gestion pare-feu
                                        source ./Gestion_Parefeu.sh
                                        ;;
                                5) #Gestion logiciels
                                        source ./Gestion_Logiciels.sh
                                        ;;
                                6) #Arret, redémarrage et verrouillage
                                        source ./Etat_Ordinateur.sh
                                        ;;
                                7) #Gestion à distance
                                        source ./Gestion_Distance.sh
                                        ;; 
                                8) #retour menu précédent
                                        #cmd a ajouter 
                                        sleep 3
                                        exit
                        done
        ;;
        4) #Quitter 
            echo "Fin du script"
            sleep 3 
            exit        
        ;;
done
        