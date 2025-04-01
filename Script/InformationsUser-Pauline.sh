######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Informations User ######################################################################

echo "merci de bien vouloir spécifier l'utilisateur concerné" 
read user 

echo "1 => Date dernière connexion de l'utilisateur " 
echo "2 => Date dernière modification du mot de passe de l'utilisateur " 
echo "3 => Liste des sessions ouvertes par l'utilisateur "  
echo "x => Quitter "  
read choix

case choix in
    1) # Date de dernière connexion d'un user 
        last -n1 $user
        ;;
    2) # Date dernière modification mdp d'un user 
        chage -l $user | awk 'NR==1'
        ;;
    3) # Liste des sessions ouvertes par l'utilisateur 
        # commande à chercher 
        ;;
    
esac