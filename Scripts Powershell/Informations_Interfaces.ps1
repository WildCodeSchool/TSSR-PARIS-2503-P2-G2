####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script information interface.ps1
# Etat : 
####################################################################################

# Nombre d'interface
Get-NetAdapter | Select-Object Name, Status, InterfaceDescription


# Adresse IP de chaque interface
Get-NetIPAddress | Select-Object InterfaceAlias, IPAddress

# Adresse Mac
Get-NetAdapter | Select-Object Name, MacAddress
