####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script application et utilisateur.ps1
# Etat : 
####################################################################################

Liste des applications/paquets installées

Get-AppxPackage | Select-Object Name, Version, Publisher

Liste des utilisateurs locaux
Get-LocalUser
