######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

# Liste des applications/paquets installées
dpkg --list


# Liste des utilisateurs locaux
awk -F: '{ print $1}' /etc/passwd