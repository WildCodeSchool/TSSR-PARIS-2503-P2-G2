######################################################################
#! /bin/bash
# Auteur : Pauline PRAK
# version : 1.0 
# Description : script Gestion Droits Permissions
# OK SSH
######################################################################


# Infos SSH
read -p "Adresse IP de la machine distante : " ip
read -p "Nom d'utilisateur SSH : " ssh_user

# Données à envoyer
read -p "Veuillez indiquer le chemin du fichier/dossier dont vous voulez changer les droits/permissions : " chemin 
read -p "Veuillez indiquer l'utilisateur concerné : " user 

# Vérification de l'existence du fichier/dossier et utilisateur à distance
echo "Vérification du fichier/dossier et de l'utilisateur sur la machine distante..."

# Note : on doit bien échapper les guillemets à l'intérieur de la commande SSH

ssh ${ssh_user}@${ip} << EOF 
    if [ -e \"$chemin\" ] && id \"$user\" &>/dev/null; 
    then 
        echo 'Tout est OK.'; 
    else 
        echo 'Erreur: Le fichier/dossier ou l'utilisateur n'existe pas.'; 
    fi
    EOF

# Vérifier le code de sortie de la commande SSH
if [ $? -ne 0 ]; then
    echo "Erreur : Le fichier/dossier n'existe pas ou l'utilisateur n'existe pas sur la machine distante."
else
    echo "Vérification réussie."
    # Tu peux rajouter ici un autre appel à SSH pour d'autres actions ou afficher un menu pour continuer
    
fi

# Type de modification
read -p "Pour ajouter un droit, tapez : add. Pour supprimer un droit, tapez : del : " choice   

case "$choice" in
    add)
        read -p "Ajouter droit lecture (+r), écriture (+w), exécution (+x) : " choixAdd
        case "$choixAdd" in
            +r | +w | +x)
                ssh -t ${ssh_user}@${ip} "sudo chmod u${choixAdd:1} '$chemin' && echo 'Droit ${choixAdd} ajouté avec succès.'"
                ;;
            *)
                echo "Choix invalide pour l'ajout."
                ;;
        esac
        ;;
    del)
        read -p "Supprimer droit lecture (-r), écriture (-w), exécution (-x) : " choixDel
        case "$choixDel" in
            -r | -w | -x)
            	echo "le choix est" ${choixDel:1}
                ssh -t ${ssh_user}@${ip} "sudo chmod u${choixDel} '$chemin' && echo 'Droit ${choixDel} supprimé avec succès.'"
                ;;
            *)
                echo "Choix invalide pour la suppression."
                ;;
        esac
        ;;
    *)
        echo "Choix d'action invalide."
        ;;
esac
