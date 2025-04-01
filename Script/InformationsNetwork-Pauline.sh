######################################################################
#! /bin/bash
# Auteur : Pauline 
# version : 1.0 
# Description : script projet 2 
######################################################################

# Nombre d'interface
ip -brief address show | awk '{print $1, $3}' | wc -l


# Adresse IP de chaque interface
ip addr show | grep 'inet ' | awk '{print $2}' | cut -d/ -f1


# Adresse Mac
ip link show | grep 'link/ether' | awk '{print $2}'