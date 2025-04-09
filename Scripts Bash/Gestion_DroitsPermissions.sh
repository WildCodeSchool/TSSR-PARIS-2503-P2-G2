######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################


#demande chemin + utilisateur 
read -p "Veuillez indiquer le chemin du fichier/dossier dont vous voulez changer les droits/permissions" chemin 
read -p "Veuillez indiquer l'utilisateur concerné" user 

#vérification existence chemin fichier et utilisateur 
if [ -e "$chemin" ] && id "$user" &>/dev/null; 
then
    read -p "Pour ajouter un droit" add 
    read -p "Pour supprimer un droit" del  

                case choice in

                    add)
                        read -p "Pour ajouter un droit en lecture " +r
                        read -p "Pour ajouter un droit en écriture " +w
                        read -p "Pour ajouter un droit en exécution " +x

                                        case choix in
                                            +r)
                                                chmod +r $chemin
                                                ;;
                                            +w)
                                                chmod +w $chemin
                                                ;;
                                            +x)
                                                chmod +x $chemin
                                                ;;
                                        esac
                        ;;

                    del)
                        read -p "Pour supprimer un droit en lecture " -r
                        read -p "Pour supprimer un droit en écriture " -w
                        read -p "Pour supprimer un droit en exécution " -x 

                                        case choix in
                                            -r)
                                                chmod -r $chemin
                                                ;;
                                            -w)
                                                chmod -w $chemin
                                                ;;
                                            -x)
                                                chmod -x $chemin
                                                ;;
                                        esac
                        ;;

                    default) 
                        #command menu précédent 
                esac

else 
echo "Le fichier/dossier n'existe pas ou l'utilisateur n'existe pas"
#commande retour menu précédent 

fi 