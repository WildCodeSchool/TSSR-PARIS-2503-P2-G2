######################################################################
#! /bin/bash
# Auteur : Chahine MARZOUK
# version : 1.0 
# Description : Gestion Logiciels
# VERIFIE
######################################################################

#!/bin/bash

# Vérifie que l'utilisateur est root pour les opérations d'installation/désinstallation

if [ "$(id -u)" -ne 0 ]; 
then
  echo "Veuillez exécuter ce script en tant que root (sudo)."
  exit 1
fi

# Affiche le menu
echo "Que souhaitez-vous faire ?"
echo "1. Installer un logiciel"
echo "2. Désinstaller un logiciel"
echo "3. Exécuter un script sur une machine distante"
read -p "Entrez le numéro de l'option : " choix

case $choix in
  1)
    read -p "Nom du logiciel à installer : " logiciel
    apt update && apt install -y "$logiciel"
    ;;
  2)
    read -p "Nom du logiciel à désinstaller : " logiciel
    apt remove -y "$logiciel"
    ;;
  3)
    read -p "Adresse IP ou nom d'hôte de la machine distante : " hote
    read -p "Nom d'utilisateur distant : " utilisateur
    read -p "Chemin absolu du script à exécuter sur la machine distante : " chemin_script
    ssh "${utilisateur}@${hote}" "bash $chemin_script"
    ;;
  *)
    echo "Option invalide."
    exit 1
    ;;
esac
