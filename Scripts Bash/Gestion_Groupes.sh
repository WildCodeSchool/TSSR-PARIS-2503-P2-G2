######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script Gestion_DroitsPermission projet 2 
# VERIFIE
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

        read -p "choisissez une option " choix 

                case "$choix" in
                    1) 
                        sudo usermod -aG adm $user
                        echo "$user" a bien été ajouté au groupe administrateur
                        #ajouter commande retour menu précédent
                        ;;
                    2)  
                        read -p "Dans quel groupe local voulez vous ajouter $user? " groupadd #demande groupe
                            if  cat /etc/group | grep -qw "$groupadd" ; #vérification existence groupe
                            then #Ajout groupe local 
                                sudo usermod -aG $groupadd $user
                            else echo "ce groupe n'existe pas" #si le groupe indiqué n'existe pas
                            #ajouter commande retour menu précédent
                            fi 
                        ;;
                    3) 
                        # Sortie groupe local 

                        read -p "Dans quel groupe local voulez vous supprimer $user? " groupdel #demande groupe
                            if  cat /etc/group | grep -qw "$groupadd" ; #vérification existence groupe
                            then #Suppression groupe local 
                                sudo gpasswd -d $user $groupdel
                            else echo "ce groupe n'existe pas " #si le groupe indiqué n'existe pas
                            #ajouter commande retour menu précédent
                            fi             
                        ;;
                    4)  
                        # Ajouter commande Retour menu précédent 
                        ;;
                esac
    else 
        echo "Erreur, cet utilisateur n'existe pas" #si $user n'existe pas
        # Ajouter commande Retour menu précédent 

    fi 