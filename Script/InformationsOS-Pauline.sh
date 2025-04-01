######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 - Information version OS  
######################################################################

# Version de l'OS : 
hostnamectl | awk 'NR==6'
# ou 
# cat /etc/os-release | awk 'NR==4'