######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Informations User 
######################################################################


# Date de dernière connexion d’un utilisateur : 
    if [$# -eq 1]; 
    then
        last -n1 $user ; 
    else 
        echo "Veuillez ajouter un nom d'utilisateur en paramètre" ; 
    fi 


# Date de dernière modification du mot de passe : 
    if [$# -eq 1]; 
    then
        chage -l $user | awk 'NR==1' ; 
    else 
        echo "Veuillez ajouter un nom d'utilisateur en paramètre" ; 
    fi 


# Liste des sessions ouvertes par l'utilisateur ??????
who
w 
users 