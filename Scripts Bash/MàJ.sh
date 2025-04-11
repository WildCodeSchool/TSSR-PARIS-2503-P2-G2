######################################################################
#! /bin/bash
# Auteur : Sadek SABIRI 
# version : 1.0 
# Description : script MàJ 
# OK SSH
######################################################################

read -p "Veuillez entrer l'adresse IP de la machine à prendre en main " IPDISTANT
read -p "Veuillez entrer le nom de l'utilisateur " USER

ssh $USER@$IPDISTANT
