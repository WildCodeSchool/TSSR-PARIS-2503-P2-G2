#! /bin/bash
######################################################################
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Script Global
# LOGS a finir  
######################################################################

USER=$(whoami)
ORDINATEUR=$(hostname)
DATE=$(date +"%d-%m-%Y")
FICHIERDUJOUR="Info_${ORDINATEUR}_${DATE}.log"
LOGFILE="/var/log/$FICHIERDUJOUR"

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


# vérification existence fichier log journalier + sinon appel de la fonction création de fichier 
if [ ! -f "$LOGFILE" ] 
then 
creation_fichier_log 
fi 


while [ "$choix_menu_principal" != "4" ]; do
    
        echo -e "\n________________________ MENU PRINCIPAL ________________________\n"
        echo "Gestion utilisateur___________________________________________: 1"
        echo "Informations du système_______________________________________: 2"
        echo "Maintenance du système________________________________________: 3"
        echo -e "Quitter le script_____________________________________________: 4\n"
        read -p "Votre choix svp : " choix_menu_principal    

        case "$choix_menu_principal" in
        1) 
        #Gestion utilisateurs et dossier
        source $(pwd)/Library/menu1_gestion_utilisateursetdossier.sh        
        ;;
        2) 
        #Information système
        source $(pwd)/Library/menu2_informations_systeme.sh
        ;;
        3) 
        #maintenance systeme
        source $(pwd)/Library/menu3_maintenance_systeme.sh
        ;;
        4) 
        #Quitter 
            echo "Fin du script"
            sleep 1
            exit 0       
        ;;
        esac
done