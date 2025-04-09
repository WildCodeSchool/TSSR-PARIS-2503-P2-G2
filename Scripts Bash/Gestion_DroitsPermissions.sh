######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Gestion Droits Permissions projet 2 
######################################################################


#demande chemin + utilisateur 
read -p "Veuillez indiquer le chemin du fichier/dossier dont vous voulez changer les droits/permissions " chemin 
read -p "Veuillez indiquer l'utilisateur concerné " user 

#vérification existence chemin fichier et utilisateur 
if [ -e "$chemin" ] && id "$user" &>/dev/null; 
then
    read -p "Pour ajouter un droit entrez : add. Pour supprimer un droit entrez : del " choice   

                case "$choice" in

                    add)
                        read -p "Pour ajouter un droit en lecture entrez : +r . Pour ajouter un droit en écriture entrez : +w . Pour ajouter un droit en exécution entrez : +x " choixAdd

                                        case "$choixAdd" in
                                            +r)
                                                chmod u+r "$chemin"
                                                ;;
                                            +w)
                                                chmod u+w "$chemin"
                                                ;;
                                            +x)
                                                chmod u+x "$chemin"
                                                ;;
                                        esac
                        ;;

                    del)
                        read -p "Pour supprimer un droit en lecture entrez : -r . Pour supprimer un droit en écriture entrez : -w . Pour supprimer un droit en exécution entrez : -x " choixDel

                                        case "$choixDel" in
                                            -r)
                                                chmod u-r "$chemin"
                                                ;;
                                            -w)
                                                chmod u-w "$chemin"
                                                ;;
                                            -x)
                                                chmod u-x "$chemin"
                                                ;;
                                        esac
                        ;;
                esac

else 
echo "Le fichier/dossier n'existe pas ou l'utilisateur n'existe pas"
#commande retour menu précédent 

fi 