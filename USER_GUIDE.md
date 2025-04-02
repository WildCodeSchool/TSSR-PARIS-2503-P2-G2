#!/bin/bash
# Squelette de script de gestion système
# Auteur : Chahine Marzouk

# Fonction pour afficher le menu principal
show_main_menu() {
    echo "=============================="
    echo " Menu Principal"
    echo "=============================="
    echo "1) GESTION UTILISATEURS/DOSSIERS"
    echo "2) INFORMATIONS DU SYSTEME"
    echo "3) MAINTENANCE DU SYSTEME"
    echo "4) Quitter"
    read -p "Choisissez une option (1-4) : " choice
    case $choice in
        1) show_user_management_menu ;;
        2) show_system_info_menu ;;
        3) show_system_maintenance_menu ;;
        4) exit 0 ;;
        *) echo "Option invalide!" && show_main_menu ;;
    esac
}

# Fonction pour afficher le menu GESTION UTILISATEURS/DOSSIERS
show_user_management_menu() {
    echo "=============================="
    echo " GESTION UTILISATEURS/DOSSIERS"
    echo "=============================="
    echo "1) Création de compte utilisateur local"
    echo "2) Changement de mot de passe"
    echo "3) Suppression de compte utilisateur local"
    echo "4) Désactivation de compte utilisateur local"
    echo "5) Ajout à un groupe d'administration"
    echo "6) Ajout à un groupe local"
    echo "7) Sortie d’un groupe local"
    echo "8) Date de dernière connexion d’un utilisateur"
    echo "9) Date de dernière modification du mot de passe"
    echo "10) Liste des sessions ouvertes par l'utilisateur"
    echo "11) Création de répertoire"
    echo "12) Suppression de répertoire"
    echo "13) Droits/permissions de l’utilisateur sur un dossier"
    echo "14) Droits/permissions de l’utilisateur sur un fichier"
    echo "15) Retour au menu principal"
    read -p "Choisissez une option (1-15) : " choice
    case $choice in
        1) ./Gestion_Utilisateur.sh ;;
        2) ./Changement_Mot_De_Passe.sh ;;
        3) ./Suppression_Compte_Utilisateur.sh ;;
        4) ./Desactivation_Compte_Utilisateur.sh ;;
        5) ./Gestion_Groupe.sh ;;
        6) ./Ajout_Groupe_Local.sh ;;
        7) ./Sortie_Groupe_Local.sh ;;
        8) ./Informations_Utilisateur.sh ;;
        9) ./Date_Modification_Mot_De_Passe.sh ;;
        10) ./Liste_Sessions_Utilisateurs.sh ;;
        11) ./Gestion_repertoire.sh ;;
        12) ./Suppression_Repertoire.sh ;;
        13) ./Gestion_DroitsPermission.sh ;;
        14) ./Droits_Permission_Fichier.sh ;;
        15) show_main_menu ;;
        *) echo "Option invalide!" && show_user_management_menu ;;
    esac
}

# Fonction pour afficher le menu INFORMATIONS DU SYSTEME
show_system_info_menu() {
    echo "=============================="
    echo " INFORMATIONS DU SYSTEME"
    echo "=============================="
    echo "1) Nombre d'interface"
    echo "2) Adresse IP de chaque interface"
    echo "3) Adresse Mac"
    echo "4) Type de CPU, nombre de coeurs, etc."
    echo "5) Mémoire RAM totale"
    echo "6) Utilisation de la RAM"
    echo "7) Utilisation du disque"
    echo "8) Utilisation du processeur"
    echo "9) Recherche des evenements dans le fichier log_evt.log pour un utilisateur"
    echo "10) Recherche des evenements dans le fichier log_evt.log pour un ordinateur"
    echo "11) Liste des applications/paquets installées"
    echo "12) Liste des utilisateurs locaux"
    echo "13) Retour au menu principal"
    read -p "Choisissez une option (1-13) : " choice
    case $choice in
        1) ./Informations_Interfaces.sh ;;
        2) ./Adresse_IP_Interfaces.sh ;;
        3) ./Adresse_Mac.sh ;;
        4) ./Informations_Materiels.sh ;;
        5) ./Memoire_RAM.sh ;;
        6) ./Utilisation_RAM.sh ;;
        7) ./Utilisation_Disque.sh ;;
        8) ./Utilisation_Processeur.sh ;;
        9) ./Informations_Logs.sh ;;
        10) ./Recherche_Evenements_Ordinateur.sh ;;
        11) ./Informations_Applications_Utilisateurs.sh ;;
        12) ./Liste_Utilisateurs_Locaux.sh ;;
        13) show_main_menu ;;
        *) echo "Option invalide!" && show_system_info_menu ;;
    esac
}

# Fonction pour afficher le menu MAINTENANCE DU SYSTEME
show_system_maintenance_menu() {
    echo "=============================="
    echo " MAINTENANCE DU SYSTEME"
    echo "=============================="
    echo "1) Version de l'OS"
    echo "2) Mise-à-jour du système"
    echo "3) Liste des ports ouverts"
    echo "4) Statut du pare-feu"
    echo "5) Définition de règles de pare-feu"
    echo "6) Activation du pare-feu"
    echo "7) Désactivation du pare-feu"
    echo "8) Installation de logiciel"
    echo "9) Désinstallation de logiciel"
    echo "10) Exécution de script sur la machine distante"
    echo "11) Arrêt"
    echo "12) Redémarrage"
    echo "13) Verrouillage"
    echo "14) Prise de main à distance (GUI)"
    echo "15) Retour au menu principal"
    read -p "Choisissez une option (1-15) : " choice
    case $choice in
        1) ./Informations_OS.sh ;;
        2) ./MAJ.sh ;;
        3) ./Informations_Port_Parefeu.sh ;;
        4) ./Statut_Parefeu.sh ;;
        5) ./Gestion_Parefeu.sh ;;
        6) ./Activation_Parefeu.sh ;;
        7) ./Desactivation_Parefeu.sh ;;
        8) ./Gestion_Logiciels.sh ;;
        9) ./Desinstallation_Librairie.sh ;;
        10) ./Execution_Script_Distant.sh ;;
        11) ./Etat_Ordinateur.sh ;;
        12) ./Redemarrage_Ordinateur.sh ;;
        13) ./Verrouillage_Ordinateur.sh ;;
        14) ./Prise_Main_Distance.sh ;;
        15) show_main_menu ;;
        *) echo "Option invalide!" && show_system_maintenance_menu ;;
    esac
}

# Lancer le menu principal
show_main_menu
