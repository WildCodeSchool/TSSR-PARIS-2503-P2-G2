######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

# demande nom utilisateur 
read -p "Veuillez indiquer le nom d'utilisateur concerné : " user 

# Vérification du nom utilisateur valide 

    if cat /etc/passwd | grep -q "^$user:" ;

    then 
        echo "1) Ajouter l'utilisateur au groupe administrateur"
        echo "2) Ajouter l'utilisateur à un groupe local" 
        echo "3) Supprimer l'utilisateur d'un groupe local" 
        echo "4) Retour au menu précédent" 
                case "choix" in
                    1) 
                        sudo usermod -aG administrateurs $user
                        ;;
                    2)  
                        #Ajout groupe local 
                        sudo usermod -aG groupe_local $user
                        ;;
                    3) 
                        # Sortie groupe local 
                        sudo gpasswd -d utilisateur groupe_local
                        ;;
                    4)  
                        # Retour menu précédent 
                        command ...
                        ;;
                esac
    else 
        echo "Erreur, cet utilisateur n'existe pas" 
    fi 