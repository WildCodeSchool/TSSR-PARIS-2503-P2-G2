######################################################################
#! /bin/bash
# Auteur : Pauline PRAK 
# version : 1.0 
# Description : Script Global
# LOGS a finir  
######################################################################

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
if [ !"LOGFILE -f" ] 
then 
creation_fichier_log 
fi 


echo "______________________ MENU PRINCIPAL ______________________"
echo "Gestion utilisateur : 1"
echo "Informations du système : 2"
echo "Maintenance du système : 3"
echo "Quitter le script : 4"
read -p "Votre choix : " choix_menu_principal

while [ "$choix_menu_principal" != "4" ]; do 
        
        case "choix" in
        1) 
        #Gestion utilisateurs et dossier
        source ./menu1_gestion_utilisateursetdossier.sh
        ;;
        2) 
        #Information système
        source ./menu2_informations_systeme.sh
        ;;
        3) 
        #maintenance systeme
        source ./menu3_maintenance_systeme.sh
        ;;
        4) 
        #Quitter 
            echo "Fin du script"
            sleep 3 
            exit        
        ;;
        esac
done
        