#! /bin/bash
# Auteur : Chahine MARZOUK
# version : 1.1 
# Description : Gestion Logiciels à distance via SSH
# VERIFIE
######################################################################

# Demande des informations de connexion SSH avant l'exécution des choix
read -p "Adresse IP ou nom d'hôte de la machine distante : " hote
read -p "Nom d'utilisateur SSH distant : " utilisateur

# Affiche le menu des options
echo "Que souhaitez-vous faire ?"
echo "1. Installer un logiciel"
echo "2. Désinstaller un logiciel"
echo "3. Exécuter un script sur une machine distante"
read -p "Entrez le numéro de l'option : " choix

case $choix in
  1)
    # Demande du logiciel à installer
    read -p "Nom du logiciel à installer : " logiciel
    # Envoie la commande à la machine distante via SSH
    ssh -t "${utilisateur}@${hote}" "sudo apt install -y $logiciel"
    ;;
  2)
    # Demande du logiciel à désinstaller
    read -p "Nom du logiciel à désinstaller : " logiciel
    # Envoie la commande à la machine distante via SSH
    ssh -t "${utilisateur}@${hote}" "sudo apt remove -y $logiciel"
    ;;
  3)
    # Demande du chemin du script à exécuter à distance
    read -p "Chemin absolu du script à exécuter sur la machine distante : " chemin_script
    # Envoie la commande à la machine distante via SSH
    ssh -t "${utilisateur}@${hote}" "bash $chemin_script"
    ;;
  *)
    echo "Option invalide."
    exit 1
    ;;
esac
