######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script Gestion Droits Permissions
# OK SSH
######################################################################

# info ssh distance à attaquer 
read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user

# Variable fichier et user 
read -p "Veuillez indiquer le chemin du fichier/dossier dont vous voulez changer les droits/permissions : " chemin 
read -p "Veuillez indiquer l'utilisateur concerné : " user 

ssh ${ssh_user}@${ip} << EOF

if [ -e \"$chemin\" ] && id \"$user\" &>/dev/null; 
then
    echo 'Tout est OK.'; 
else
    echo 'Erreur: Le fichier/dossier ou l'utilisateur n'existe pas.'; 
fi

EOF

# Vérifier le code de sortie de la commande SSH
if [ $? -ne 0 ]; 
then
    echo "Erreur : Le fichier/dossier n'existe pas ou l'utilisateur n'existe pas sur la machine distante. "
else
    echo "Vérification réussie. "
    
fi

# Modification droits 
echo -e "Pour ajouter un droit, tapez : add\nPour supprimer un droit, tapez : del "    
read choice

case "$choice" in
    add)
        echo -e "Ajouter droit lecture : +r\nAjouter droit écriture : +w\nAjouter droit exécution : +x \nMerci d'indiquer votre choix. "        
        read choixAdd

        case "$choixAdd" in
            +r)
                ssh -t ${ssh_user}@${ip} << EOF
                sudo chmod u+r '$chemin'
                echo 'Droit lecture ajouté avec succès. '
EOF
		;;
           +w)
             ssh -t ${ssh_user}@${ip} << EOF
                sudo chmod u+w '$chemin'
                echo 'Droit écriture ajouté avec succès. '
EOF
		;;
            +x)
             ssh -t ${ssh_user}@${ip} << EOF
                sudo chmod u+x '$chemin'
                echo 'Droit exécution ajouté avec succès. '
EOF
                ;;
            *)
                echo "Choix invalide pour l'ajout. "
                ;;
        esac
        ;;
    del)
        echo -e "Supprimer droit lecture : -r\nSupprimer droit écriture : -w\nSupprimer droit exécution : -x \nMerci d'indiquer votre choix. "
        read choixDel
        
        case "$choixDel" in
            -r)
                ssh -t ${ssh_user}@${ip} << EOF
                sudo chmod u-r '$chemin'
                echo 'Droit lecture supprimé avec succès. '
EOF
		;;
           -w)
             ssh -t ${ssh_user}@${ip} << EOF
                sudo chmod u-w '$chemin'
                echo 'Droit écriture supprimé avec succès. '
EOF
		;;
            -x)
             ssh -t ${ssh_user}@${ip} << EOF
                sudo chmod u-x '$chemin'
                echo 'Droit exécution supprimé avec succès. '
EOF
                ;;
            *)
                echo "Choix invalide pour la suppression. "
                ;;
        esac
        ;;
        
    *)
        echo "Choix d'action invalide. "
        ;;
esac