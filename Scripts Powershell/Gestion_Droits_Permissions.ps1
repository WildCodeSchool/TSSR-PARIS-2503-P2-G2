####################################################################################
# Autor : Pauline 
# Version : 1.0 
# Description : Script droit et permission.ps1
# Etat : 
####################################################################################

Droits/permissions de l’utilisateur sur un dossier
Droits/permissions de l’utilisateur sur un fichier

# obtenir les droits d'un fichier/dossier
Get-Acl "C:\chemin\vers\ton\fichier_ou_dossier"

# création d'une regle Allow/Deny et Read Write FullControl
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule("NomUtilisateur", "Read", "Allow")
$acl.SetAccessRule($rule)
Set-Acl "C:\chemin\vers\ton\fichier_ou_dossier" $acl