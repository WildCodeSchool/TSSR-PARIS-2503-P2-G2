######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Informations User 
######################################################################
$1=user
# vérification de $1 
    if [ $# -eq 1 ]; 
    then
        echo "1 => Date dernière connexion de l'utilisateur " choix
        echo "2 => Date dernière modification du mot de passe de l'utilisateur " choix
        echo "3 => Liste des sessions ouvertes par l'utilisateur " choix 
        echo "x => Quitter " choix 
        read $choix

            case choix in ( liste )
                # Date de dernière connexion d’un utilisateur : 
                1)  if [ $# -eq 1 ]; 
                    then
                        last -n1 $user ; 
                    else 
                        echo "Veuillez ajouter un nom d'utilisateur en paramètre" ; 
                    fi 
                # Date dernière modification mot de passe d'un utilisateur : 
                2)  if [ $# -eq 1 ]; 
                    then
                        chage -l $user | awk 'NR==1' ; 
                    else 
                    echo "Veuillez ajouter un nom d'utilisateur en paramètre" ; 
                    fi 
                # Liste des sessions ouvertes par un utilisateur : 
                3)
                # Revenir au menu précédent/Quitter le script : 
                x)exit 
            esac

    else 
        echo "Veuillez renseigner un nom d"utilisateur en paramètre"
        exit 

    fi






# Liste des sessions ouvertes par l'utilisateur ??????
who
w 
users 