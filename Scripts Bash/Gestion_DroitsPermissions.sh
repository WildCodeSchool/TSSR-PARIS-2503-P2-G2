#!/bin/bash
######################################################################
# Auteur : Pauline PRAK
# Version : 1.2 
# Description : Script de gestion des droits/permissions avec sudo sécurisé et boucle interactive
# Test SSH OK
# boucle while true OK  
######################################################################

# Infos SSH
read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user

# Fichier/dossier et utilisateur cible
read -p "Veuillez indiquer le chemin du fichier/dossier : " chemin 
read -p "Veuillez indiquer l'utilisateur concerné : " user 

# Mot de passe sudo (caché à l'affichage)
read -s -p "Mot de passe sudo du user distant : " sudo_pass
echo

# Vérification du fichier et de l'utilisateur sur la machine distante
ssh ${ssh_user}@${ip} "[ -e \"$chemin\" ] && id \"$user\" &>/dev/null"
if [ $? -ne 0 ]; then
    echo "Erreur : Le fichier/dossier ou l'utilisateur n'existe pas sur la machine distante."
    exit 1
else
    echo "Vérification réussie."
fi

# Boucle interactive
while true; do
    echo -e "\n--- Menu Gestion des Droits ---"
    echo -e "Tapez :\n  add     → pour ajouter un droit\n  del     → pour supprimer un droit\n  retour  → pour quitter le script"
    read -p "Votre choix : " choice

    case "$choice" in
        add)
            echo -e "Ajouter :\n  +r → lecture\n  +w → écriture\n  +x → exécution"
            read -p "Votre choix : " choixAdd
            case "$choixAdd" in
                +r)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+r '$chemin' && echo 'Lecture ajoutée avec succès.'"
                    ;;
                +w)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+w '$chemin' && echo 'Écriture ajoutée avec succès.'"
                    ;;
                +x)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+x '$chemin' && echo 'Exécution ajoutée avec succès.'"
                    ;;
                *)
                    echo "Choix invalide."
                    ;;
            esac
            ;;
        del)
            echo -e "Supprimer :\n  -r → lecture\n  -w → écriture\n  -x → exécution"
            read -p "Votre choix : " choixDel
            case "$choixDel" in
                -r)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-r '$chemin' && echo 'Lecture supprimée avec succès.'"
                    ;;
                -w)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-w '$chemin' && echo 'Écriture supprimée avec succès.'"
                    ;;
                -x)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-x '$chemin' && echo 'Exécution supprimée avec succès.'"
                    ;;
                *)
                    echo "Choix invalide."
                    ;;
            esac
            ;;
        retour)
            echo "Fin du script."
            sleep 3
            break
            ;;
        *)
            echo "Choix non reconnu, veuillez réessayer."
            ;;
    esac
done
