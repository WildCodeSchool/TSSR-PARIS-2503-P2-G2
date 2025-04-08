####################################################################################
Autor : Pauline 
Version : 1.0 
Description : Script Powershell Gestion_Groupe.ps1
####################################################################################

# Demander nom user 
$User = Read-Host "Veuillez entrer le nom d'utilisateur à ajouter/retirer d'un groupe"   


# Vérifier si l'utilisateur existe
if (Get-LocalUser -Name $User) 
{

}
{
    Write-Host "L'utilisateur '$nomUtilisateur' n'existe pas." -ForegroundColor Red
    exit
}












# Demander groupe 
$Group = Read-Host "Veuillez entrer le groupe concerné" 

# Vérifier si le groupe existe
$groupeExiste = Get-LocalGroup -Name $nomGroupe -ErrorAction SilentlyContinue
if (-not $groupeExiste) {
    Write-Host "Le groupe '$nomGroupe' n'existe pas." -ForegroundColor Red
    exit
}

# Ajout à un groupe d'administration
Add-LocalGroupMember -Group "Administrateurs" -Member "NomUtilisateur"



# Ajout à un groupe local
Add-LocalGroupMember -Group "Administrateurs" -Member "NomUtilisateur"



# Sortie d’un groupe local
Remove-LocalGroupMember -Group "NomDuGroupe" -Member "NomUtilisateur"
