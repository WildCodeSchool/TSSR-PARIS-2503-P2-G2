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
                        #ajouter commande retour menu précédent
                        ;;
                    2)  
                        read -p "Dans quel groupe local voulez vous ajouter $user?" groupadd #demande groupe
                            if  cat /etc/group | grep -q "^$group:" ; #vérification existence groupe
                            then #Ajout groupe local 
                                sudo usermod -aG $groupadd $user
                            else echo "ce groupe n'existe pas" #si le groupe indiqué n'existe pas
                            #ajouter commande retour menu précédent
                            fi 
                        ;;
                    3) 
                        # Sortie groupe local 
                        sudo gpasswd -d utilisateur groupe_local

                        read -p "Dans quel groupe local voulez vous supprimer $user?" groupdel #demande groupe
                            if  cat /etc/group | grep -q "^$group:" ; #vérification existence groupe
                            then #Suppression de $user dans $groupedel 
                                sudo usermod -aG $groupdel $user
                            else echo "ce groupe n'existe pas" #si le groupe indiqué n'existe pas
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