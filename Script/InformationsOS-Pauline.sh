######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

# Version de l'OS : 
hostnamectl | awk 'NR==6'
cat /etc/os-release | awk 'NR==4'