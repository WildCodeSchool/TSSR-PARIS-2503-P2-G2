####################################################################################
# Auteur : Pauline 
# Version : 1.1 
# Description : Script Gestion_Groupe.ps1
# État : a tester
####################################################################################

$Choix = ""

while ($Choix -ne "retour") {

    Write-Host "`n------------------------------------------------------------"
    Write-Host " [1] Ajouter un utilisateur au groupe Administrateurs"
    Write-Host " [2] Ajouter un utilisateur à un groupe local"
    Write-Host " [3] Supprimer un utilisateur d'un groupe local"
    Write-Host " [retour] Quitter"
    Write-Host "------------------------------------------------------------"
    $Choix = Read-Host "Entrez votre choix"

    switch ($Choix) {

        "1" {
            $User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné" 
            if (Get-LocalUser -Name $User -ErrorAction SilentlyContinue) {
                Add-LocalGroupMember -Group "Administrateurs" -Member $User
                Write-Host "✔️ L'utilisateur $User a bien été ajouté au groupe 'Administrateurs'." -ForegroundColor Green
            } else {
                Write-Host "❌ L'utilisateur $User n'existe pas." -ForegroundColor Red
            }
        }

        "2" {
            $User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné"
            if (Get-LocalUser -Name $User -ErrorAction SilentlyContinue) {
                $Group = Read-Host "Veuillez entrer le nom du groupe local"
                if (Get-LocalGroup -Name $Group -ErrorAction SilentlyContinue) {
                    Add-LocalGroupMember -Group $Group -Member $User
                    Write-Host "✔️ L'utilisateur $User a bien été ajouté au groupe '$Group'." -ForegroundColor Green
                } else {
                    Write-Host "❌ Le groupe '$Group' n'existe pas." -ForegroundColor Red
                }
            } else {
                Write-Host "❌ L'utilisateur $User n'existe pas." -ForegroundColor Red
            }
        }

        "3" {
            $User = Read-Host "Veuillez entrer le nom de l'utilisateur concerné"
            if (Get-LocalUser -Name $User -ErrorAction SilentlyContinue) {
                $Group = Read-Host "Veuillez entrer le nom du groupe local"
                if (Get-LocalGroup -Name $Group -ErrorAction SilentlyContinue) {
                    Remove-LocalGroupMember -Group $Group -Member $User
                    Write-Host "✔️ L'utilisateur $User a bien été retiré du groupe '$Group'." -ForegroundColor Green
                } else {
                    Write-Host "❌ Le groupe '$Group' n'existe pas." -ForegroundColor Red
                }
            } else {
                Write-Host "❌ L'utilisateur $User n'existe pas." -ForegroundColor Red
            }
        }

        "retour" {
            Write-Host "`nFin du script. À bientôt !" -ForegroundColor Cyan
        }

        Default {
            Write-Host "❓ Entrée incorrecte, veuillez taper 1, 2, 3 ou 'retour'." -ForegroundColor Yellow
        }
    }
}
