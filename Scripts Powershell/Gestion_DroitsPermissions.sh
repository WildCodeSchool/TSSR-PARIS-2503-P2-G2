######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

# vérification du nombre d'argument # vérification du nombre d'argument 


# demander utilisateur concerné  
        read -p "Veuillez indiquer pour quel utilisateur souhaitez vous modifier les droits " user 

# vérification existence de l'utilisateur 
    if [ $user -e $(echo /etc/password) ]; 
    then;
        echo "1 => Ajouter un droit pour $user"

        echo "2 => Supprimer un droit pour $user"
        echo "x => Quitter"
    else; 
        echo "Cet utilisateur n'existe pas"
        exit 
    fi



# ajouter un droit 
#  Pour utilisateur ?
      Ajouter R? chmod 400 $fichier
      Ajouter W? 200
      Ajouter X? 100
      Retour ? 
      
  pour groupe ? 
      Ajouter R? 040
      Ajouter W? 020
      Ajouter X? 010
      Retour ? 
      
  pour autre ? 
      Ajouter R? 004  
      Ajouter W? 002 
      Ajouter X? 001 
      Retour ? 

# supprimer un droit ? 
#  pour utilisateur ?
      Supprimer R?
      Supprimer W?
      Supprimer X? 
      Retour ?
      
  pour groupe ? 
      Supprimer R?
      Supprimer W?
      Supprimer X? 
      Retour ? 
      
  pour autre ? 
      Supprimer R?
      Supprimer W?
      Supprimer X?   
      Retour ?

# Retour au menu ?