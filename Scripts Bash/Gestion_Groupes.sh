######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Gestion_DroitsPermission projet 2 
# OK SSH
######################################################################


read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user
read -p "Nom de l'utilisateur à modifier : " user
echo "1) Ajouter au groupe admin"
echo "2) Ajouter à un groupe local"
echo "3) Supprimer d'un groupe local"
read -p "Choix : " choix

case $choix in
    1)
        ssh -t ${ssh_user}@${ip} "sudo usermod -aG adm $user && echo '$user ajouté au groupe adm'"
        ;;
    2)
        read -p "Groupe local à ajouter : " group
        ssh -t ${ssh_user}@${ip} "grep -q '^$group:' /etc/group && sudo usermod -aG $group $user || echo 'Groupe $group inexistant'"
        ;;
    3)
        read -p "Groupe local à supprimer : " group
        ssh -t ${ssh_user}@${ip} "grep -q '^$group:' /etc/group && sudo gpasswd -d $user $group || echo 'Groupe $group inexistant'"
        ;;
esac
