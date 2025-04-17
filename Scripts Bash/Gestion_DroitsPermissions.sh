#!/bin/bash
######################################################################
# Auteur : Pauline PRAK
# Version : 1.2 
# Description : Script de gestion des droits/permissions avec sudo sécurisé et boucle interactive
# a revoir 
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


    echo "---------- Menu Gestion des Droits ----------"
    echo "→ pour ajouter un droit : add "
    echo "→ pour supprimer un droit : del "
    echo "→ pour retourner dans le menu précédent : retour "
    read -p "Votre choix : " choix


while [ "$choix" != "retour" ]; do
        case "choix" in
        add)
                echo "→ pour ajouter "lecture" : +r "
                echo "→ pour ajouter "écriture" : +w "            
                echo "→ pour ajouter "execution" : +x "
                echo "→ pour retourner au menu précédent : retour "
                read -p "Votre choix : " choix_add

                while [ "$choix_add" != "retour" ]; do
                        +r)
                            ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+r '$chemin' && echo 'Lecture ajoutée avec succès.'"
                            ;;
                        +w)
                            ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+w '$chemin' && echo 'Écriture ajoutée avec succès.'"
                            ;;
                        +x)
                            ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+x '$chemin' && echo 'Exécution ajoutée avec succès.'"
                            ;;
                        retour)
                            source ./Gestion_DroitsPermissions.sh
                            ;;
                done
        ;;
        del)
                echo "→ pour supprimer "lecture" : -r "
                echo "→ pour supprimer "écriture" : -w "            
                echo "→ pour supprimer "execution" : -x "
                echo "→ pour retourner au menu précédent : retour "
                read -p "Votre choix : " choix_del
                
                while [ "$choix_del" != "retour" ]; do
                        -r)
                            ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-r '$chemin' && echo 'Lecture supprimée avec succès.'"
                            ;;
                        -w)
                            ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-w '$chemin' && echo 'Écriture supprimée avec succès.'"
                            ;;
                        -x)
                            ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-x '$chemin' && echo 'Exécution supprimée avec succès.'"
                            ;;
                        retour)
                            source ./Gestion_DroitsPermissions.sh
                            ;;
                done
        ;;
        retour)
            echo "Retour menu précédent."
            sleep 3
            source ./menu1_gestion_utilisateursetdossier.sh
        ;;
        esac
done