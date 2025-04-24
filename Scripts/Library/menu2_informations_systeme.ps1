######################################################################
# Version : 1.0 
# Description : Menu 2 : informations systeme
# LOGS a finir  
######################################################################

Write-Host "______________________ INFORMATIONS SYSTEME ______________________"
Write-Host "Informations Interfaces                                        : 1"
Write-Host "Informations Materiel                                          : 2"
Write-Host "Informations Logs                                              : 3"
Write-Host "Informations Applications et Utilisateurs Locaux               : 4"
Write-Host "Retour menu precedent                                          : 5"

# Lecture initiale du choix
$choix = Read-Host "Votre choix"

while ($choix -ne "5") {
    switch ($choix) {
        "1" { 
            # Informations Interfaces
            . "$(Get-Location)/Library/Informations_Interfaces.ps1"
        }
        "2" { 
            # Informations Materiel
            . "$(Get-Location)/Library/Informations_Materiels.ps1"
        }
        "3" { 
            # Informations Logs
            . "$(Get-Location)/Library/Informations_Logs.ps1"
        }
        "4" {
            # Informations Applications et Utilisateurs Locaux
            . "$(Get-Location)/Library/Informations_Applications_Utilisateurs.ps1"
        }
        default {
            Write-Host "Choix invalide. Veuillez entrer un nombre entre 1 et 5."
        }
    }

    Write-Host "`n------------------------ MENU ------------------------"
    Write-Host "1 : Informations Interfaces"
    Write-Host "2 : Informations Materiel"
    Write-Host "3 : Informations Logs"
    Write-Host "4 : Informations Applications et Utilisateurs Locaux"
    Write-Host "5 : Retour menu precedent"
    $choix = Read-Host "Votre choix"
}

Write-Host "Retour au menu principal"
