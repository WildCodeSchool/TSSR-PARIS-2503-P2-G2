#########################################################
# Autor : Pauline PRAK 
# Version : 1.0 
# Description : Script Informations OS 
# Etat : A verifier 
#########################################################

Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
#Commande retour menu précédent 