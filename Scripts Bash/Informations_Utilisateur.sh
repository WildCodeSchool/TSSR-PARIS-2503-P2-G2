######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Informations User 
######################################################################

read -p "merci de bien vouloir spécifier l'utilisateur concerné" user 

# verification si $user fait parti de la liste des utilisateurs de l'ordinateur 
    if      cat /etc/passwd | grep -q "^$user:" ;
    then 
            echo "1 => Date dernière connexion de l'utilisateur " 
            echo "2 => Date dernière modification du mot de passe de l'utilisateur " 
            echo "3 => Liste des sessions ouvertes par l'utilisateur "  
            echo "x => Retour menu précédent "  
            read choix

                    case $choix in
                        1) # Date de dernière connexion d'user 
                            # format date à retravailler
                            last -n1 $user
                            ;;
                        2) # Date dernière modification mdp d'un user 
                            chage -l $user | awk 'NR==1'
                            ;;
                        3) # Liste des sessions ouvertes par l'utilisateur 
                            # commande à chercher 
                            ;;
                        4) # Retour menu précédent  
                            # commande à chercher 
                            ;;
    
                    esac

    else    echo "$user ne fait pas parti de la liste des utilisateurs de l'ordinateur"
            # Ajouter retour menu précédent 
    fi 