#!/bin/bash
######################################################################
# Auteur : Pauline PRAK
# Version : 1.2 
# Description : Script de gestion des droits/permissions
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

echo "$DATE-$HEURE-$USER-$1 : test existence fichier dans le systeme" >> $LOGFILE
ssh ${ssh_user}@${ip} "[ -e \"$chemin\" ] && id \"$user\" &>/dev/null"
if [ $? -ne 0 ]; then
    echo "Erreur : Le fichier/dossier ou l'utilisateur n'existe pas sur la machine distante."
    echo "$DATE-$HEURE-$USER-$1 : Erreur, le fichier/dossier ou l'utilisateur n'existe pas sur la machine" >> $LOGFILE
    exit 1
else
    echo "Vérification reussie."
    echo "$DATE-$HEURE-$USER-$1 : Verification existence fichier/dossier reussie" >> $LOGFILE

fi

echo "---------- Menu Gestion des Droits ----------"
echo "→ pour ajouter un droit : add "
echo "→ pour supprimer un droit : del "
echo "→ pour retourner dans le menu précédent : retour "
read -p "Votre choix : " choix

while [ "$choix" != "retour" ]; do

case "$choix" in
    add)
                echo "→ pour ajouter "lecture" : +r "
                echo "→ pour ajouter "écriture" : +w "            
                echo "→ pour ajouter "execution" : +x "
                echo "→ pour retourner au menu précédent : retour "
                read -p "Votre choix : " choix_add

            while [ "$choix_add" != "retour" ]; do
            case "choix" in
                    +r)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+r '$chemin' && echo 'Lecture ajouté avec succès.'"
                    echo "$DATE-$HEURE-$USER-$1 : ajout droit lecture réussis" >> $LOGFILE
                    ;;
                    +w)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+w '$chemin' && echo 'Écriture ajouté avec succès.'"
                    echo "$DATE-$HEURE-$USER-$1 : ajout droit ecriture réussis" >> $LOGFILE
                    ;;
                    +x)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u+x '$chemin' && echo 'Exécution ajouté avec succès.'"
                    echo "$DATE-$HEURE-$USER-$1 : ajout droit execution réussis" >> $LOGFILE
                    ;;
                    retour)
                    Echo "Retour menu précédent."
                    echo "$DATE-$HEURE-$USER-$1 : retour menu precedent" >> $LOGFILE
                    sleep 3
                    ;;
            esac
            done
    ;;
    del)
                echo "→ pour supprimer "lecture" : -r "
                echo "→ pour supprimer "écriture" : -w "            
                echo "→ pour supprimer "execution" : -x "
                echo "→ pour retourner au menu précédent : retour "
                read -p "Votre choix : " choix_del
                
            while [ "$choix_del" != "retour" ]; do
            case "$choix" in
                    -r)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-r '$chemin' && echo 'Lecture supprimé avec succès.'"                    
                    echo "$DATE-$HEURE-$USER-$1 : suppression droit lecture réussis" >> $LOGFILE
                    ;;
                    -w)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-w '$chemin' && echo 'Écriture supprimé avec succès.'"
                    echo "$DATE-$HEURE-$USER-$1 : suppression droit ecriture réussis" >> $LOGFILE
                    ;;
                    -x)
                    ssh ${ssh_user}@${ip} "echo '$sudo_pass' | sudo -S chmod u-x '$chemin' && echo 'Exécution supprimé avec succès.'"
                    echo "$DATE-$HEURE-$USER-$1 : suppression droit execution réussis" >> $LOGFILE
                    ;;
                    retour)
                    echo "Retour menu précédent."
                    echo "$DATE-$HEURE-$USER-$1 : retour menu precedent" >> $LOGFILE
                    sleep 3
                    ;;
            esac
            done

    ;;
    retour)
            echo "Retour menu précédent."
            echo "$DATE-$HEURE-$USER-$1 : retour menu principale" >> $LOGFILE
            sleep 3
    ;;
    
esac
done
